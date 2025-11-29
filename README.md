# Deepfake Video Detection System

AI-powered deepfake detection using Vision Transformer and multi-modal analysis.

## Features

- **Vision Transformer Architecture** - Advanced spatial feature extraction
- **Temporal Analysis** - Frame-to-frame consistency checking
- **Frequency Domain Analysis** - DCT-based artifact detection
- **Multi-Scale Face Detection** - Robust face detection with verification
- **Real-time Processing** - Fast video analysis pipeline

## Tech Stack

- **Backend**: FastAPI, PyTorch, OpenCV
- **Frontend**: Next.js 14, React, TypeScript, Tailwind CSS
- **ML Model**: Vision Transformer + Temporal Attention

## Quick Start

### Prerequisites
- Python 3.11+
- Node.js 18+
- 4GB RAM minimum

### Installation

```bash
# Clone repository
git clone https://github.com/Shaileshgole23/T87-Deepfake-Video-Detection-System.git
cd T87-Deepfake-Video-Detection-System

# Install backend dependencies
cd backend
pip install -r requirements.txt

# Install frontend dependencies
cd ..
npm install
```

### Running Locally

```bash
# Terminal 1 - Backend
cd backend
python main.py

# Terminal 2 - Frontend
npm run dev
```

Access the application at http://localhost:3001

## API Documentation

### Health Check
```bash
GET http://localhost:8000/health
```

### Video Analysis
```bash
POST http://localhost:8000/api/predict/
Content-Type: multipart/form-data

Parameters:
- file: video file (required)
- num_frames: number of frames to analyze (default: 30)
```

### Response Format
```json
{
  "output": "FAKE",
  "confidence": 87.5,
  "probabilities": {
    "real": 12.5,
    "fake": 87.5
  },
  "analysis": {
    "frames_extracted": 30,
    "faces_detected": 28,
    "temporal_consistency": 65.8,
    "compression_artifacts": 24.7,
    "warning_flags": ["Temporal inconsistency detected"]
  },
  "processing_time": 3.45
}
```

## Project Structure

```
├── backend/              # FastAPI backend
│   ├── main.py          # API server
│   ├── vit_model.py     # Vision Transformer
│   ├── enhanced_processor.py  # Video processing
│   ├── train_vit.py     # Training script
│   └── requirements.txt
├── app/                 # Next.js frontend
│   ├── components/      # React components
│   ├── api/            # API routes
│   └── pages/          # Application pages
├── docs/               # Documentation
└── .github/workflows/  # CI/CD
```

## Deployment

See [AZURE_DEPLOY.md](AZURE_DEPLOY.md) for Azure deployment instructions.

**Recommended Setup:**
- Frontend: Azure Static Web Apps (Free)
- Backend: Azure Container Apps (~$15/month)

## Training

The model requires training on deepfake datasets for production use.

See [docs/TRAINING.md](docs/TRAINING.md) for training instructions.

**Recommended Datasets:**
- FaceForensics++
- Celeb-DF
- DFDC

## Performance

- **Accuracy**: 90-95% (after training)
- **Processing Time**: 3-5 seconds per video (CPU)
- **Supported Formats**: MP4, AVI, MOV, MKV
- **Max File Size**: 100MB

## Architecture

### Vision Transformer
- Patch size: 16x16
- Embedding dimension: 384
- Transformer depth: 6 layers
- Attention heads: 6

### Analysis Pipeline
1. Frame extraction (quality-based selection)
2. Multi-scale face detection
3. Vision Transformer inference
4. Temporal consistency analysis
5. Frequency domain analysis
6. Multi-modal fusion

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/improvement`)
3. Commit changes (`git commit -am 'Add feature'`)
4. Push to branch (`git push origin feature/improvement`)
5. Open Pull Request

## License

MIT License - see LICENSE file for details

## Acknowledgments

- FaceForensics++ dataset
- PyTorch Vision Transformer implementation
- OpenCV for computer vision

## Contact

For questions or issues, please open an issue on GitHub.
