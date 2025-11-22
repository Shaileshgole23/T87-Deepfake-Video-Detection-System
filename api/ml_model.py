"""
ML Model Loading and Inference
Handles ResNeXt + LSTM model for deepfake detection
"""

import torch
import torch.nn as nn
from torchvision import models, transforms
import numpy as np
from pathlib import Path
from typing import Tuple, List
import os

class DeepfakeDetector(nn.Module):
    """
    ResNeXt-50 + LSTM model for deepfake detection
    """
    def __init__(self, num_classes=2, hidden_size=256, num_layers=2, dropout=0.3):
        super(DeepfakeDetector, self).__init__()
        
        # ResNeXt-50 backbone for spatial features
        self.resnext = models.resnext50_32x4d(pretrained=True)
        num_features = self.resnext.fc.in_features
        self.resnext.fc = nn.Identity()  # Remove final FC layer
        
        # LSTM for temporal features
        self.lstm = nn.LSTM(
            input_size=num_features,
            hidden_size=hidden_size,
            num_layers=num_layers,
            batch_first=True,
            dropout=dropout if num_layers > 1 else 0,
            bidirectional=True
        )
        
        # Final classification layers
        self.fc = nn.Sequential(
            nn.Linear(hidden_size * 2, 128),  # *2 for bidirectional
            nn.ReLU(),
            nn.Dropout(dropout),
            nn.Linear(128, num_classes)
        )
        
    def forward(self, x):
        """
        Args:
            x: Tensor of shape (batch_size, sequence_length, channels, height, width)
        Returns:
            logits: Tensor of shape (batch_size, num_classes)
        """
        batch_size, seq_len, c, h, w = x.size()
        
        # Extract spatial features for each frame
        x = x.view(batch_size * seq_len, c, h, w)
        features = self.resnext(x)
        features = features.view(batch_size, seq_len, -1)
        
        # Extract temporal features
        lstm_out, _ = self.lstm(features)
        
        # Use last output for classification
        last_output = lstm_out[:, -1, :]
        logits = self.fc(last_output)
        
        return logits

def load_model(model_path: str = None) -> DeepfakeDetector:
    """
    Load the trained deepfake detection model
    
    Args:
        model_path: Path to model checkpoint. If None, looks in default locations.
    
    Returns:
        Loaded model in eval mode
    """
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    
    # Try to find model file
    if model_path is None:
        possible_paths = [
            Path("models/model_best.pt"),
            Path("../models/model_best.pt"),
            Path("api/models/model_best.pt"),
        ]
        
        for path in possible_paths:
            if path.exists():
                model_path = str(path)
                break
    
    # Initialize model
    model = DeepfakeDetector()
    
    # Load weights if available
    if model_path and Path(model_path).exists():
        try:
            checkpoint = torch.load(model_path, map_location=device)
            
            # Handle different checkpoint formats
            if isinstance(checkpoint, dict):
                if 'model_state_dict' in checkpoint:
                    model.load_state_dict(checkpoint['model_state_dict'])
                elif 'state_dict' in checkpoint:
                    model.load_state_dict(checkpoint['state_dict'])
                else:
                    model.load_state_dict(checkpoint)
            else:
                model = checkpoint
            
            print(f"✓ Loaded model from {model_path}")
        except Exception as e:
            print(f"✗ Failed to load model weights: {e}")
            print("  Using randomly initialized model")
    else:
        print("⚠ Model file not found. Using randomly initialized model.")
        print("  For production, train and save a model to models/model_best.pt")
    
    model = model.to(device)
    model.eval()
    
    return model

def get_transform():
    """
    Get image preprocessing transform
    """
    return transforms.Compose([
        transforms.ToPILImage(),
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize(
            mean=[0.485, 0.456, 0.406],
            std=[0.229, 0.224, 0.225]
        )
    ])

def predict_video(
    model: DeepfakeDetector,
    face_images: List[np.ndarray],
    device: str = None
) -> Tuple[int, float]:
    """
    Predict if video is real or fake
    
    Args:
        model: Trained DeepfakeDetector model
        face_images: List of face images (numpy arrays)
        device: Device to run inference on
    
    Returns:
        prediction: 0 for real, 1 for fake
        confidence: Confidence score (0-1)
    """
    if device is None:
        device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    
    if not face_images:
        raise ValueError("No face images provided")
    
    # Preprocess images
    transform = get_transform()
    processed_images = []
    
    for img in face_images:
        try:
            # Convert to RGB if needed
            if len(img.shape) == 2:
                img = np.stack([img] * 3, axis=-1)
            elif img.shape[2] == 4:
                img = img[:, :, :3]
            
            # Apply transform
            tensor = transform(img)
            processed_images.append(tensor)
        except Exception as e:
            print(f"Error processing image: {e}")
            continue
    
    if not processed_images:
        raise ValueError("Failed to process any images")
    
    # Stack into sequence
    sequence = torch.stack(processed_images).unsqueeze(0)  # (1, seq_len, C, H, W)
    sequence = sequence.to(device)
    
    # Run inference
    with torch.no_grad():
        logits = model(sequence)
        probabilities = torch.softmax(logits, dim=1)
        prediction = torch.argmax(probabilities, dim=1).item()
        confidence = probabilities[0, prediction].item()
    
    return prediction, confidence

def predict_batch(
    model: DeepfakeDetector,
    video_sequences: List[List[np.ndarray]],
    device: str = None
) -> List[Tuple[int, float]]:
    """
    Predict multiple videos in batch
    
    Args:
        model: Trained DeepfakeDetector model
        video_sequences: List of video sequences (each is a list of face images)
        device: Device to run inference on
    
    Returns:
        List of (prediction, confidence) tuples
    """
    results = []
    
    for sequence in video_sequences:
        try:
            pred, conf = predict_video(model, sequence, device)
            results.append((pred, conf))
        except Exception as e:
            print(f"Error predicting video: {e}")
            results.append((0, 0.5))  # Default to uncertain
    
    return results

# Example usage
if __name__ == "__main__":
    # Test model loading
    print("Testing model loading...")
    model = load_model()
    print(f"Model device: {next(model.parameters()).device}")
    print(f"Model parameters: {sum(p.numel() for p in model.parameters()):,}")
    
    # Test inference with dummy data
    print("\nTesting inference...")
    dummy_sequence = [np.random.randint(0, 255, (224, 224, 3), dtype=np.uint8) for _ in range(40)]
    prediction, confidence = predict_video(model, dummy_sequence)
    print(f"Prediction: {'FAKE' if prediction == 1 else 'REAL'}")
    print(f"Confidence: {confidence:.2%}")
