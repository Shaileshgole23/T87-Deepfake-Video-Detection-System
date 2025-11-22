"""
Video Processing Utilities
Handles frame extraction, face detection, and preprocessing
"""

import cv2
import numpy as np
from typing import List, Tuple, Optional
import face_recognition
from pathlib import Path

def extract_frames(
    video_path: str,
    num_frames: int = 40,
    method: str = 'uniform'
) -> List[np.ndarray]:
    """
    Extract frames from video
    
    Args:
        video_path: Path to video file
        num_frames: Number of frames to extract
        method: 'uniform' for evenly spaced, 'random' for random sampling
    
    Returns:
        List of frame images as numpy arrays
    """
    cap = cv2.VideoCapture(video_path)
    
    if not cap.isOpened():
        raise ValueError(f"Could not open video: {video_path}")
    
    total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    fps = cap.get(cv2.CAP_PROP_FPS)
    
    if total_frames == 0:
        raise ValueError("Video has no frames")
    
    # Determine which frames to extract
    if method == 'uniform':
        # Evenly spaced frames
        frame_indices = np.linspace(0, total_frames - 1, num_frames, dtype=int)
    elif method == 'random':
        # Random frames
        frame_indices = np.random.choice(total_frames, size=min(num_frames, total_frames), replace=False)
        frame_indices.sort()
    else:
        raise ValueError(f"Unknown method: {method}")
    
    frames = []
    current_frame = 0
    
    for target_frame in frame_indices:
        # Seek to target frame
        cap.set(cv2.CAP_PROP_POS_FRAMES, target_frame)
        ret, frame = cap.read()
        
        if ret:
            # Convert BGR to RGB
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            frames.append(frame_rgb)
        else:
            print(f"Warning: Could not read frame {target_frame}")
    
    cap.release()
    
    if not frames:
        raise ValueError("No frames could be extracted from video")
    
    print(f"✓ Extracted {len(frames)} frames from video")
    return frames

def detect_faces(
    frames: List[np.ndarray],
    model: str = 'hog',
    min_face_size: int = 50
) -> List[np.ndarray]:
    """
    Detect and crop faces from frames
    
    Args:
        frames: List of frame images
        model: 'hog' (faster) or 'cnn' (more accurate)
        min_face_size: Minimum face size to detect
    
    Returns:
        List of cropped face images
    """
    face_images = []
    
    for i, frame in enumerate(frames):
        try:
            # Detect face locations
            face_locations = face_recognition.face_locations(frame, model=model)
            
            if not face_locations:
                # Try with smaller image if no face found
                small_frame = cv2.resize(frame, (0, 0), fx=0.5, fy=0.5)
                face_locations = face_recognition.face_locations(small_frame, model=model)
                # Scale back up
                face_locations = [(top*2, right*2, bottom*2, left*2) 
                                for top, right, bottom, left in face_locations]
            
            if face_locations:
                # Use the largest face
                largest_face = max(face_locations, 
                                 key=lambda loc: (loc[2] - loc[0]) * (loc[1] - loc[3]))
                
                top, right, bottom, left = largest_face
                
                # Check minimum size
                if (bottom - top) >= min_face_size and (right - left) >= min_face_size:
                    # Add padding
                    padding = int((bottom - top) * 0.2)
                    top = max(0, top - padding)
                    bottom = min(frame.shape[0], bottom + padding)
                    left = max(0, left - padding)
                    right = min(frame.shape[1], right + padding)
                    
                    # Crop face
                    face = frame[top:bottom, left:right]
                    face_images.append(face)
                else:
                    print(f"Face in frame {i} too small, skipping")
            else:
                print(f"No face detected in frame {i}")
                
        except Exception as e:
            print(f"Error processing frame {i}: {e}")
            continue
    
    if not face_images:
        print("⚠ No faces detected, using full frames")
        # Fallback: use center crop of frames
        face_images = [center_crop(frame, 224) for frame in frames]
    
    print(f"✓ Detected {len(face_images)} faces")
    return face_images

def center_crop(image: np.ndarray, size: int) -> np.ndarray:
    """
    Center crop image to square
    
    Args:
        image: Input image
        size: Output size
    
    Returns:
        Cropped image
    """
    h, w = image.shape[:2]
    
    # Determine crop size
    crop_size = min(h, w)
    
    # Calculate crop coordinates
    start_y = (h - crop_size) // 2
    start_x = (w - crop_size) // 2
    
    # Crop
    cropped = image[start_y:start_y + crop_size, start_x:start_x + crop_size]
    
    # Resize to target size
    if crop_size != size:
        cropped = cv2.resize(cropped, (size, size))
    
    return cropped

def preprocess_face(
    face: np.ndarray,
    target_size: Tuple[int, int] = (224, 224)
) -> np.ndarray:
    """
    Preprocess face image for model input
    
    Args:
        face: Face image
        target_size: Target size (height, width)
    
    Returns:
        Preprocessed face image
    """
    # Resize
    face = cv2.resize(face, target_size)
    
    # Normalize to [0, 1]
    face = face.astype(np.float32) / 255.0
    
    return face

def save_frames(
    frames: List[np.ndarray],
    output_dir: str,
    prefix: str = 'frame'
) -> List[str]:
    """
    Save frames to disk
    
    Args:
        frames: List of frame images
        output_dir: Output directory
        prefix: Filename prefix
    
    Returns:
        List of saved file paths
    """
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)
    
    saved_paths = []
    
    for i, frame in enumerate(frames):
        filename = f"{prefix}_{i:04d}.jpg"
        filepath = output_path / filename
        
        # Convert RGB to BGR for OpenCV
        frame_bgr = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
        cv2.imwrite(str(filepath), frame_bgr)
        
        saved_paths.append(str(filepath))
    
    return saved_paths

def get_video_info(video_path: str) -> dict:
    """
    Get video metadata
    
    Args:
        video_path: Path to video file
    
    Returns:
        Dictionary with video information
    """
    cap = cv2.VideoCapture(video_path)
    
    if not cap.isOpened():
        raise ValueError(f"Could not open video: {video_path}")
    
    info = {
        'total_frames': int(cap.get(cv2.CAP_PROP_FRAME_COUNT)),
        'fps': cap.get(cv2.CAP_PROP_FPS),
        'width': int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)),
        'height': int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)),
        'duration': int(cap.get(cv2.CAP_PROP_FRAME_COUNT)) / cap.get(cv2.CAP_PROP_FPS)
    }
    
    cap.release()
    return info

# Example usage
if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python video_processor.py <video_path>")
        sys.exit(1)
    
    video_path = sys.argv[1]
    
    print(f"Processing video: {video_path}")
    
    # Get video info
    info = get_video_info(video_path)
    print(f"\nVideo Info:")
    print(f"  Resolution: {info['width']}x{info['height']}")
    print(f"  FPS: {info['fps']:.2f}")
    print(f"  Duration: {info['duration']:.2f}s")
    print(f"  Total Frames: {info['total_frames']}")
    
    # Extract frames
    print(f"\nExtracting frames...")
    frames = extract_frames(video_path, num_frames=40)
    
    # Detect faces
    print(f"\nDetecting faces...")
    faces = detect_faces(frames)
    
    print(f"\n✓ Processing complete!")
    print(f"  Extracted: {len(frames)} frames")
    print(f"  Detected: {len(faces)} faces")
