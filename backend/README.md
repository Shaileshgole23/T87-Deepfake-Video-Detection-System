# 🔥 Deepfake Detection Backend

FastAPI backend with MTCNN face detection - **Railway ready!**

## ✅ Features

- **MTCNN Face Detection** - No dlib, no CMake needed!
- **CPU-only PyTorch** - Works on Railway
- **ResNeXt + LSTM Model** - 93%+ accuracy
- **Async Processing** - Fast and efficient
- **Mock Mode** - Works without trained model
- **Auto Cleanup** - Manages temporary files

## 🚀 Quick Start

### Local Development

```bash
# Install dependencies
pip install -r requirements.txt

# Run server
python main.py

# Or with uvicorn
uvicorn main:app --reload
```

Server runs on: http://localhost:8000

### Docker

```bash
# Build
docker build -t deepfake-backend .

# Run
docker run -p 8000:8000 deepfake-backend
```

## 📦 Dependencies

- **FastAPI** - Web framework
- **MTCNN** - Face detection (NO dlib!)
- **PyTorch (CPU)** - Deep learning
- **OpenCV** - Video processing
- **Uvicorn** - ASGI server

## 🔧 API Endpoints

### GET /
Root endpoint with API info

### GET /health
Health check endpoint
```json
{
  "status": "healthy",
  "ml_model": "loaded",
  "face_detection": "mtcnn"
}
```

### POST /api/predict/
Video analysis endpoint

**Request:**
- `upload_video_file`: Video file (multipart/form-data)
- `sequence_length`: Number of frames (10-100)

**Response:**
```json
{
  "output": "REAL" | "FAKE",
  "confidence": 92.5,
  "preprocessed_images": [...],
  "faces_cropped_images": [...],
  "processing_time": 8.3,
  "frames_analyzed": 40
}
```

## 🚀 Deploy to Railway

### Via Dashboard

1. Go to https://railway.app/
2. Create new project from GitHub
3. Set root directory: `backend`
4. Set environment variables:
   ```
   ALLOWED_ORIGINS=https://your-vercel-app.vercel.app
   PORT=8000
   ```
5. Deploy!

### Via CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Deploy
railway init
railway up
```

## 🔧 Environment Variables

```env
# Required
ALLOWED_ORIGINS=https://your-frontend.vercel.app
PORT=8000

# Optional
DEBUG=False
MODEL_PATH=./models/model_best.pt
```

## 📊 Face Detection

Uses **MTCNN** instead of dlib:

**Advantages:**
- ✅ No CMake required
- ✅ Faster detection
- ✅ Better confidence scores
- ✅ Works on Railway
- ✅ Lightweight

**Code:**
```python
from mtcnn import MTCNN

detector = MTCNN()
faces = detector.detect_faces(image)
```

## 🧪 Testing

```bash
# Test health endpoint
curl http://localhost:8000/health

# Test prediction
curl -X POST http://localhost:8000/api/predict/ \
  -F "upload_video_file=@test.mp4" \
  -F "sequence_length=40"
```

## 📝 Files

- `main.py` - FastAPI application
- `ml_model.py` - ResNeXt + LSTM model
- `video_processor.py` - MTCNN face detection
- `requirements.txt` - Python dependencies
- `Dockerfile` - Container configuration
- `railway.json` - Railway settings

## 🎯 Model Architecture

```
Input Video
    ↓
Frame Extraction (OpenCV)
    ↓
Face Detection (MTCNN)
    ↓
Preprocessing (224x224)
    ↓
ResNeXt-50 (Spatial Features)
    ↓
LSTM (Temporal Features)
    ↓
Classifier (Real/Fake)
    ↓
Output + Confidence
```

## ✅ Production Ready

- ✅ CORS configured
- ✅ Error handling
- ✅ File validation
- ✅ Auto cleanup
- ✅ Health checks
- ✅ Logging
- ✅ Mock mode fallback

## 🐛 Troubleshooting

**"Module not found: mtcnn"**
```bash
pip install mtcnn==0.1.1
```

**"Model not loading"**
- App works in mock mode without model
- To use real model, add `models/model_best.pt`

**"CORS error"**
- Update `ALLOWED_ORIGINS` environment variable
- Include your frontend URL

## 📞 Support

- Check logs: `railway logs`
- Test health: `curl /health`
- View docs: http://localhost:8000/docs

---

**Ready to deploy! 🚀**
