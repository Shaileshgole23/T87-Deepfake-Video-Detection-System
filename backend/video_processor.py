"""
Video Processing with OpenCV Haar Cascades Face Detection
NO dlib, NO MTCNN, NO CMake - Railway compatible!
"""

import cv2
import numpy as np
from typing import List
import os

# Initialize OpenCV Haar Cascade detector (built-in, no dependencies!)
cascade_path = cv2.data.haarcascades + 'haarcascade_frontalface_default.xml'
face_cascade = cv2.CascadeClassifier(cascade_path)

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
        method: 'uniform' for evenly spaced frames
    
    Returns:
        List of frame images as numpy arrays
    """
    cap = cv2.VideoCapture(video_path)
    
    if not cap.isOpened():
        raise ValueError(f"Could not open video: {video_path}")
    
    total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    
    if total_frames == 0:
        raise ValueError("Video has no frames")
    
    # Determine which frames to extract
    if method == 'uniform':
        frame_indices = np.linspace(0, total_frames - 1, num_frames, dtype=int)
    else:
        frame_indices = np.random.choice(total_frames, size=min(num_frames, total_frames), replace=False)
        frame_indices.sort()
    
    frames = []
    
    for target_frame in frame_indices:
        cap.set(cv2.CAP_PROP_POS_FRAMES, target_frame)
        ret, frame = cap.read()
        
        if ret:
            # Convert BGR to RGB
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            frames.append(frame_rgb)
    
    cap.release()
    
    if not frames:
        raise ValueError("No frames could be extracted from video")
    
    print(f"✓ Extracted {len(frames)} frames from video")
    return frames

def detect_faces_opencv(
    frames: List[np.ndarray],
    scale_factor: float = 1.1,
    min_neighbors: int = 5,
    min_face_size: int = 50
) -> List[np.ndarray]:
    """
    Detect and crop faces from frames using OpenCV Haar Cascades
    
    Args:
        frames: List of frame images
        scale_factor: Parameter specifying how much the image size is reduced
        min_neighbors: Parameter specifying how many neighbors each candidate rectangle should have
        min_face_size: Minimum face size in pixels
    
    Returns:
        List of cropped face images
    """
    face_images = []
    
    for i, frame in enumerate(frames):
        try:
            # Convert to grayscale for detection
            gray = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
            
            # Detect faces using Haar Cascade
            faces = face_cascade.detectMultiScale(
                gray,
                scaleFactor=scale_factor,
                minNeighbors=min_neighbors,
                minSize=(min_face_size, min_face_size)
            )
            
            if len(faces) > 0:
                # Get the largest face
                largest_face = max(faces, key=lambda rect: rect[2] * rect[3])
                x, y, w, h = largest_face
                
                # Add padding
                padding = int(max(w, h) * 0.2)
                x = max(0, x - padding)
                y = max(0, y - padding)
                w = min(frame.shape[1] - x, w + 2 * padding)
                h = min(frame.shape[0] - y, h + 2 * padding)
                
                # Crop face
                face = frame[y:y+h, x:x+w]
                face_images.append(face)
            else:
                print(f"No face detected in frame {i}")
                
        except Exception as e:
            print(f"Error processing frame {i}: {e}")
            continue
    
    if not face_images:
        print("⚠ No faces detected with OpenCV, using center crops")
        # Fallback: use center crop of frames
        face_images = [center_crop(frame, 224) for frame in frames[:20]]
    
    print(f"✓ Detected {len(face_images)} faces using OpenCV Haar Cascades")
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
