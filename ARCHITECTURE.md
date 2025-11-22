# 🏗️ System Architecture

## Overview

The Deepfake Detection System is built with a modern, scalable architecture that separates concerns between frontend presentation, API routing, and ML inference.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                          USER INTERFACE                             │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐            │
│  │   Landing    │  │   Upload     │  │   Results    │            │
│  │     Page     │  │     Page     │  │     Page     │            │
│  └──────────────┘  └──────────────┘  └──────────────┘            │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐            │
│  │  How It      │  │  Model       │  │    About     │            │
│  │   Works      │  │    Info      │  │     Page     │            │
│  └──────────────┘  └──────────────┘  └──────────────┘            │
│                                                                     │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             │ Next.js 14 (React)
                             │ Tailwind CSS
                             │ Framer Motion
                             │
┌────────────────────────────┴────────────────────────────────────────┐
│                      FRONTEND LAYER (Vercel)                        │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐  │
│  │                    Next.js App Router                        │  │
│  │                                                              │  │
│  │  • Server-Side Rendering (SSR)                              │  │
│  │  • Static Site Generation (SSG)                             │  │
│  │  • API Route Handlers                                       │  │
│  │  • Edge Functions                                           │  │
│  │  • Image Optimization                                       │  │
│  └─────────────────────────────────────────────────────────────┘  │
│                                                                     │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             │ HTTPS/REST API
                             │ JSON Payloads
                             │
┌────────────────────────────┴────────────────────────────────────────┐
│                   BACKEND LAYER (Railway/DO)                        │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐  │
│  │                      FastAPI Server                          │  │
│  │                                                              │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │  │
│  │  │   Upload     │  │   Predict    │  │   Static     │     │  │
│  │  │  Endpoint    │  │  Endpoint    │  │   Files      │     │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘     │  │
│  │                                                              │  │
│  │  • CORS Middleware                                          │  │
│  │  • Request Validation                                       │  │
│  │  • Error Handling                                           │  │
│  │  • File Management                                          │  │
│  └─────────────────────────────────────────────────────────────┘  │
│                                                                     │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             │ Function Calls
                             │
┌────────────────────────────┴────────────────────────────────────────┐
│                    PROCESSING LAYER                                 │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐ │
│  │                  Video Processor                             │ │
│  │                                                              │ │
│  │  • Frame Extraction (OpenCV)                                │ │
│  │  • Face Detection (face_recognition/dlib)                   │ │
│  │  • Image Preprocessing                                      │ │
│  │  • Face Cropping & Alignment                                │ │
│  └──────────────────────────────────────────────────────────────┘ │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐ │
│  │                    ML Model                                  │ │
│  │                                                              │ │
│  │  ┌────────────────┐         ┌────────────────┐             │ │
│  │  │   ResNeXt-50   │────────▶│   LSTM Layers  │             │ │
│  │  │   (Spatial)    │         │   (Temporal)   │             │ │
│  │  └────────────────┘         └────────────────┘             │ │
│  │          │                           │                      │ │
│  │          └───────────┬───────────────┘                      │ │
│  │                      ▼                                      │ │
│  │              ┌────────────────┐                             │ │
│  │              │  Classifier    │                             │ │
│  │              │  (Real/Fake)   │                             │ │
│  │              └────────────────┘                             │ │
│  │                                                              │ │
│  │  • PyTorch Framework                                        │ │
│  │  • GPU/CPU Inference                                        │ │
│  │  • Batch Processing                                         │ │
│  └──────────────────────────────────────────────────────────────┘ │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

## Data Flow

### 1. Video Upload Flow

```
User Browser
    │
    │ 1. Select video file
    │
    ▼
Next.js Frontend
    │
    │ 2. Validate file (type, size)
    │ 3. Create FormData
    │ 4. POST /api/predict
    │
    ▼
FastAPI Backend
    │
    │ 5. Receive file
    │ 6. Save temporarily
    │
    ▼
Video Processor
    │
    │ 7. Extract frames (OpenCV)
    │ 8. Detect faces (dlib)
    │ 9. Crop & preprocess
    │
    ▼
ML Model
    │
    │ 10. Load frames into tensor
    │ 11. ResNeXt feature extraction
    │ 12. LSTM temporal analysis
    │ 13. Classification
    │
    ▼
FastAPI Backend
    │
    │ 14. Format results
    │ 15. Save processed images
    │ 16. Return JSON response
    │
    ▼
Next.js Frontend
    │
    │ 17. Parse results
    │ 18. Display visualization
    │ 19. Show confidence scores
    │
    ▼
User Browser
```

### 2. Request/Response Format

**Request:**
```http
POST /api/predict/ HTTP/1.1
Content-Type: multipart/form-data

upload_video_file: [binary video data]
sequence_length: 40
```

**Response:**
```json
{
  "output": "FAKE",
  "confidence": 87.5,
  "preprocessed_images": [
    "/static/frame_0.jpg",
    "/static/frame_1.jpg",
    ...
  ],
  "faces_cropped_images": [
    "/static/face_0.jpg",
    "/static/face_1.jpg",
    ...
  ],
  "original_video": "/static/video.mp4",
  "processing_time": 8.3,
  "frames_analyzed": 40
}
```

## Component Architecture

### Frontend Components

```
app/
├── layout.tsx                 # Root layout with Navbar & Footer
├── page.tsx                   # Main page with state management
├── components/
│   ├── Navbar.tsx            # Navigation component
│   ├── Footer.tsx            # Footer component
│   ├── FeatureCard.tsx       # Reusable feature card
│   ├── UploadSection.tsx     # Video upload interface
│   └── ResultsSection.tsx    # Results display with charts
├── how-it-works/
│   └── page.tsx              # Educational content
├── model-info/
│   └── page.tsx              # Technical specifications
└── about/
    └── page.tsx              # Project information
```

### Backend Modules

```
api/
├── main.py                    # FastAPI application & routes
├── ml_model.py               # Model loading & inference
├── video_processor.py        # Video processing utilities
├── requirements.txt          # Python dependencies
├── Dockerfile               # Container configuration
└── .env.example             # Environment template
```

## Technology Stack

### Frontend
- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Animations**: Framer Motion
- **Charts**: Recharts
- **File Upload**: React Dropzone
- **HTTP Client**: Fetch API
- **Notifications**: React Hot Toast

### Backend
- **Framework**: FastAPI
- **Language**: Python 3.10
- **Server**: Uvicorn (ASGI)
- **ML Framework**: PyTorch 2.2
- **Computer Vision**: OpenCV
- **Face Detection**: face_recognition + dlib
- **Image Processing**: Pillow

### Infrastructure
- **Frontend Hosting**: Vercel
- **Backend Hosting**: Railway / DigitalOcean
- **CDN**: Vercel Edge Network
- **SSL**: Automatic (Vercel/Railway)

## Security Architecture

### Frontend Security
```
┌─────────────────────────────────────┐
│  Client-Side Validation             │
│  • File type checking               │
│  • Size limit enforcement           │
│  • XSS protection                   │
└─────────────────────────────────────┘
                │
                ▼
┌─────────────────────────────────────┐
│  HTTPS Transport                    │
│  • TLS 1.3                          │
│  • Certificate pinning              │
└─────────────────────────────────────┘
                │
                ▼
┌─────────────────────────────────────┐
│  Backend Validation                 │
│  • Content-Type verification        │
│  • File size limits                 │
│  • CORS policy                      │
│  • Rate limiting                    │
└─────────────────────────────────────┘
```

### Data Security
- **In Transit**: HTTPS/TLS encryption
- **At Rest**: Temporary files deleted after processing
- **Privacy**: No video storage, immediate cleanup
- **Authentication**: Optional (can add JWT/OAuth)

## Scalability

### Horizontal Scaling
```
                    Load Balancer
                         │
        ┌────────────────┼────────────────┐
        │                │                │
        ▼                ▼                ▼
   Backend 1        Backend 2        Backend 3
   (Railway)        (Railway)        (Railway)
```

### Vertical Scaling
- Increase CPU/RAM for backend instances
- Use GPU instances for faster inference
- Optimize model with ONNX/TensorRT

### Caching Strategy
```
┌──────────────┐
│   Browser    │ ← Cache static assets (24h)
└──────────────┘
        │
        ▼
┌──────────────┐
│  Vercel CDN  │ ← Cache pages & images (1h)
└──────────────┘
        │
        ▼
┌──────────────┐
│   Backend    │ ← Cache model in memory
└──────────────┘
```

## Performance Optimization

### Frontend
- Code splitting by route
- Image optimization (Next.js Image)
- Lazy loading components
- Prefetching critical resources
- Bundle size optimization

### Backend
- Model loaded once on startup
- Async request handling
- Efficient memory management
- Batch processing support
- Connection pooling

### ML Inference
- CPU-optimized PyTorch
- Reduced precision (FP16)
- Model quantization (optional)
- ONNX runtime (optional)
- Batch inference

## Monitoring & Observability

```
┌─────────────────────────────────────┐
│         Application Logs            │
│  • Request/Response logging         │
│  • Error tracking                   │
│  • Performance metrics              │
└─────────────────────────────────────┘
                │
                ▼
┌─────────────────────────────────────┐
│      Vercel Analytics               │
│  • Page views                       │
│  • User sessions                    │
│  • Core Web Vitals                  │
└─────────────────────────────────────┘
                │
                ▼
┌─────────────────────────────────────┐
│      Railway Metrics                │
│  • CPU usage                        │
│  • Memory usage                     │
│  • Request latency                  │
│  • Error rates                      │
└─────────────────────────────────────┘
```

## Deployment Pipeline

```
Developer
    │
    │ git push
    │
    ▼
GitHub Repository
    │
    ├─────────────────┬─────────────────┐
    │                 │                 │
    ▼                 ▼                 ▼
Vercel Build      Railway Build    GitHub Actions
    │                 │                 │
    │ Build Next.js   │ Build Docker    │ Run Tests
    │                 │                 │
    ▼                 ▼                 ▼
Vercel Deploy     Railway Deploy    Notifications
    │                 │
    │                 │
    ▼                 ▼
Production        Production
Frontend          Backend
```

## Future Enhancements

### Phase 1 (Current)
- ✅ Basic deepfake detection
- ✅ Web interface
- ✅ Results visualization

### Phase 2 (Planned)
- 🔄 Real-time video streaming
- 🔄 Batch processing API
- 🔄 User authentication
- 🔄 Result history

### Phase 3 (Future)
- 📋 Browser extension
- 📋 Mobile app
- 📋 API marketplace
- 📋 Multi-modal detection (audio + video)

---

This architecture is designed to be:
- **Scalable**: Handle increasing load
- **Maintainable**: Clear separation of concerns
- **Secure**: Multiple layers of protection
- **Performant**: Optimized at every layer
- **Extensible**: Easy to add new features
