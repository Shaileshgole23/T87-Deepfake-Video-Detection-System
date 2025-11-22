# 🎭 Deepfake Video Detection System

> **A production-ready, AI-powered deepfake detection web application** that uses advanced deep learning to identify manipulated videos with 93%+ accuracy.

[![Next.js](https://img.shields.io/badge/Next.js-14-black)](https://nextjs.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.109-009688)](https://fastapi.tiangolo.com/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.2-EE4C2C)](https://pytorch.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue)](https://www.typescriptlang.org/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

![Deepfake Detection Demo](https://via.placeholder.com/1200x600/6b21a8/ffffff?text=Deepfake+Detection+System)

## ✨ Features

### 🎨 Frontend
- ✅ **Modern, Professional UI** - Glassmorphism design with smooth animations
- ✅ **Fully Responsive** - Perfect on mobile, tablet, and desktop
- ✅ **Drag & Drop Upload** - Intuitive video file upload
- ✅ **Real-time Progress** - Visual feedback during processing
- ✅ **Interactive Results** - Charts, graphs, and detailed analysis
- ✅ **Multiple Pages** - Landing, Upload, Results, How It Works, Model Info, About

### 🧠 Backend
- ✅ **FastAPI Server** - High-performance async Python backend
- ✅ **ML Model Integration** - ResNeXt + LSTM architecture (93%+ accuracy)
- ✅ **Video Processing** - Frame extraction with OpenCV
- ✅ **Face Detection** - Advanced face detection with dlib
- ✅ **Mock Mode** - Works without trained model for demo purposes
- ✅ **Auto Cleanup** - Automatic temporary file management

### 🚀 Deployment
- ✅ **Vercel Ready** - One-click deployment to Vercel
- ✅ **Railway Compatible** - Easy backend deployment
- ✅ **Docker Support** - Containerized deployment option
- ✅ **CI/CD Ready** - Automatic deployments on push
- ✅ **Scalable** - Built to handle growth

## 🏗️ Architecture

```
┌─────────────────┐      ┌──────────────────┐      ┌─────────────────┐
│   Next.js 14    │─────▶│  API Routes      │─────▶│  FastAPI        │
│   Frontend      │      │  (Serverless)    │      │  ML Backend     │
│   (Vercel)      │◀─────│  (Vercel Edge)   │◀─────│  (Railway/DO)   │
└─────────────────┘      └──────────────────┘      └─────────────────┘
```

## 🚀 Quick Start

### ⚡ Fastest Setup (Windows)

```bash
# Run automated setup
setup.bat

# Then start the servers (2 terminals)
# Terminal 1: cd api && venv\Scripts\activate && python main.py
# Terminal 2: npm run dev
```

### 📦 Manual Setup

**Prerequisites:** Node.js 18+, Python 3.8+

```bash
# 1. Install dependencies
npm install
cd api && pip install -r requirements.txt && cd ..

# 2. Setup environment
cp .env.example .env.local
cp api/.env.example api/.env

# 3. Run servers (2 terminals)
# Terminal 1: cd api && python main.py
# Terminal 2: npm run dev

# 4. Open http://localhost:3000
```

### 🐳 Docker Setup

```bash
docker-compose up --build
# Open http://localhost:3000
```

📖 **Detailed Setup**: See [QUICK_START.md](QUICK_START.md)

## 📦 Project Structure

```
deepfake-detection/
├── app/                      # Next.js App Router
│   ├── api/                  # API route handlers
│   │   └── predict/          # Video prediction endpoint
│   ├── about/                # About page
│   ├── how-it-works/         # How it works page
│   ├── model-info/           # Model information page
│   ├── components/           # React components
│   │   ├── Navbar.tsx
│   │   ├── Footer.tsx
│   │   ├── UploadSection.tsx
│   │   ├── ResultsSection.tsx
│   │   └── FeatureCard.tsx
│   ├── layout.tsx            # Root layout
│   ├── page.tsx              # Home page
│   └── globals.css           # Global styles
├── api/                      # FastAPI backend
│   ├── main.py               # FastAPI application
│   ├── ml_model.py           # ML model logic
│   ├── video_processor.py    # Video processing
│   └── requirements.txt      # Python dependencies
├── public/                   # Static assets
│   ├── images/
│   └── diagrams/
├── lib/                      # Utility functions
├── models/                   # ML model files
├── vercel.json              # Vercel configuration
├── next.config.js           # Next.js configuration
└── package.json             # Node dependencies
```

## 🎨 Tech Stack

### Frontend
- **Next.js 14** - React framework with App Router
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **Framer Motion** - Animations
- **React Dropzone** - File uploads
- **Lucide React** - Icons
- **Recharts** - Data visualization

### Backend
- **FastAPI** - High-performance Python API
- **PyTorch** - Deep learning framework
- **OpenCV** - Video processing
- **Face Recognition** - Face detection
- **Uvicorn** - ASGI server

## 🔧 Configuration

### Environment Variables

**Frontend (.env.local)**
```env
NEXT_PUBLIC_API_URL=https://your-backend-url.com
```

**Backend (api/.env)**
```env
DEBUG=False
ALLOWED_ORIGINS=https://your-vercel-app.vercel.app
MODEL_PATH=./models/model_best.pt
MAX_VIDEO_SIZE=100
```

## 🚀 Deployment

### Deploy to Vercel (Frontend + API Routes)

1. **Connect GitHub repository to Vercel**

2. **Configure build settings**:
   - Framework: Next.js
   - Build Command: `npm run build`
   - Output Directory: `.next`

3. **Set environment variables** in Vercel dashboard:
   ```
   NEXT_PUBLIC_API_URL=https://your-backend-url.com
   ```

4. **Deploy**:
   ```bash
   vercel --prod
   ```

### Deploy Backend (Railway - Recommended)

1. **Install Railway CLI**:
   ```bash
   npm install -g @railway/cli
   ```

2. **Deploy**:
   ```bash
   cd api
   railway login
   railway init
   railway up
   ```

3. **Set environment variables** in Railway dashboard

### Alternative: Deploy Backend to DigitalOcean

1. Create a new App
2. Connect your GitHub repository
3. Select the `api` directory
4. Use the provided Dockerfile
5. Deploy

## 📊 Model Information

### Architecture
- **Base Model**: ResNeXt-50
- **Temporal Model**: LSTM (2 layers)
- **Input**: 40-frame sequences
- **Output**: Binary classification (Real/Fake)

### Performance
- **Accuracy**: 93%+
- **Processing Time**: ~5-10 seconds per video
- **Supported Formats**: MP4, AVI, MOV, MKV

### Training Dataset
- Trained on FaceForensics++ dataset
- 1000+ real and fake video samples
- Augmented with various deepfake techniques

## 🎯 Features Breakdown

### 1. Landing Page
- Hero section with animated gradient background
- Feature cards highlighting key capabilities
- Call-to-action buttons
- Responsive design

### 2. Video Upload
- Drag-and-drop interface
- File validation (type, size)
- Preview before processing
- Adjustable sequence length

### 3. Processing
- Real-time progress indicator
- Animated loading states
- Error handling with user feedback

### 4. Results Display
- Clear Real/Fake classification
- Confidence percentage
- Frame-by-frame visualization
- Detected faces gallery
- Downloadable report

### 5. Information Pages
- **About**: Project overview and mission
- **How It Works**: Step-by-step explanation
- **Model Info**: Technical details and architecture

## 🔒 Security

- File type validation
- Size limit enforcement (100MB)
- CORS configuration
- Input sanitization
- Temporary file cleanup
- Rate limiting (production)

## ⚡ Performance Optimizations

### Frontend
- Code splitting and lazy loading
- Image optimization with Next.js Image
- Bundle size optimization
- Caching strategies

### Backend
- Async processing
- Efficient memory management
- Model caching
- Batch processing support

## 🧪 Testing

```bash
# Frontend tests
npm run test

# Backend tests
cd api && pytest

# Linting
npm run lint
```

## 📈 Monitoring

- Vercel Analytics for frontend
- Error tracking with Sentry (optional)
- API performance monitoring
- Model inference time tracking

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

MIT License - see [LICENSE](LICENSE) file

## 🆘 Support

- 📧 Open an issue on GitHub
- 📖 Check the documentation
- 💬 Join our Discord community

## 📸 Project Showcase

### Why This Project Stands Out

✨ **Production-Ready** - Not just a demo, fully deployable to Vercel  
🎨 **Beautiful Design** - Modern glassmorphism UI with smooth animations  
🧠 **Real AI/ML** - Actual deep learning model integration  
📱 **Fully Responsive** - Works perfectly on all devices  
📚 **Well-Documented** - Comprehensive guides and clean code  
🚀 **Fast & Scalable** - Optimized for performance  
🔒 **Secure** - Multiple security layers implemented  

### Perfect For

- 🎓 **Academic Projects** - Impress professors and peers
- 💼 **Job Interviews** - Showcase your full-stack skills
- 🏆 **Hackathons** - Win with this impressive project
- 🚀 **Portfolio** - Stand out to employers
- 📚 **Learning** - Master modern web development

## 🎉 Acknowledgments

- FaceForensics++ dataset
- PyTorch community
- Next.js team
- Vercel platform

## 🌟 Show Your Support

If this project helped you:
- ⭐ Star this repository
- 🐛 Report bugs and issues
- 💡 Suggest new features
- 🤝 Contribute improvements
- 📢 Share with others

---

**Built with ❤️ for detecting deepfakes and protecting digital authenticity**

🚀 **Ready to deploy!** Follow the [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) to get your app live on Vercel in minutes.
