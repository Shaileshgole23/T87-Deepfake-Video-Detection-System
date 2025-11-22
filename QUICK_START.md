# ⚡ Quick Start Guide

Get your Deepfake Detection System running in 5 minutes!

## 🚀 Option 1: Fastest Setup (Recommended)

### Step 1: Install Dependencies

```bash
# Install frontend dependencies
npm install

# Install backend dependencies
cd api
pip install -r requirements.txt
cd ..
```

### Step 2: Set Up Environment

```bash
# Copy environment files
cp .env.example .env.local
cp api/.env.example api/.env
```

### Step 3: Run the Application

**Terminal 1 - Backend:**
```bash
cd api
python main.py
```

**Terminal 2 - Frontend:**
```bash
npm run dev
```

### Step 4: Open Your Browser

Visit: **http://localhost:3000**

That's it! 🎉

---

## 🐳 Option 2: Docker Setup

### Prerequisites
- Docker installed
- Docker Compose installed

### Run with Docker

```bash
# Build and start all services
docker-compose up --build

# Or run in background
docker-compose up -d
```

Visit: **http://localhost:3000**

### Stop Services

```bash
docker-compose down
```

---

## 📦 Option 3: Manual Setup

### Prerequisites
- Node.js 18+
- Python 3.8+
- pip

### Frontend Setup

```bash
# Install dependencies
npm install

# Create environment file
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local

# Run development server
npm run dev
```

Frontend runs on: **http://localhost:3000**

### Backend Setup

```bash
# Navigate to API directory
cd api

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On Mac/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create environment file
cp .env.example .env

# Run server
python main.py
```

Backend runs on: **http://localhost:8000**

---

## 🧪 Testing the Application

### 1. Check Backend Health

```bash
curl http://localhost:8000/health
```

Expected response:
```json
{
  "status": "healthy",
  "ml_model": "unavailable"
}
```

Note: ML model will show "unavailable" until you add a trained model file.

### 2. Test Frontend

1. Open http://localhost:3000
2. Click "Try Demo Now"
3. Upload a test video
4. View results

### 3. Test API Directly

```bash
curl -X POST http://localhost:8000/api/predict/ \
  -F "upload_video_file=@test_video.mp4" \
  -F "sequence_length=40"
```

---

## 🎯 What to Do Next

### For Development

1. **Explore the Code**
   - Frontend: `app/` directory
   - Backend: `api/` directory
   - Components: `app/components/`

2. **Customize the UI**
   - Edit `app/globals.css` for styling
   - Modify `tailwind.config.js` for theme
   - Update components in `app/components/`

3. **Add Your ML Model**
   - Place trained model in `api/models/model_best.pt`
   - Model will automatically load on backend restart

### For Deployment

1. **Deploy to Vercel** (Frontend)
   ```bash
   vercel --prod
   ```

2. **Deploy to Railway** (Backend)
   ```bash
   cd api
   railway up
   ```

3. **Update Environment Variables**
   - Set `NEXT_PUBLIC_API_URL` in Vercel
   - Set `ALLOWED_ORIGINS` in Railway

See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for detailed instructions.

---

## 🐛 Troubleshooting

### Port Already in Use

**Frontend (3000):**
```bash
# Kill process on port 3000
# Windows:
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Mac/Linux:
lsof -ti:3000 | xargs kill -9
```

**Backend (8000):**
```bash
# Kill process on port 8000
# Windows:
netstat -ano | findstr :8000
taskkill /PID <PID> /F

# Mac/Linux:
lsof -ti:8000 | xargs kill -9
```

### Module Not Found

```bash
# Reinstall dependencies
npm install
cd api && pip install -r requirements.txt
```

### CORS Errors

Make sure backend is running and `NEXT_PUBLIC_API_URL` in `.env.local` matches your backend URL.

### Python Version Issues

```bash
# Check Python version (must be 3.8+)
python --version

# Use specific Python version
python3.10 -m venv venv
```

### Face Recognition Installation Issues

**Windows:**
```bash
# Install Visual C++ Build Tools first
# Then install dlib
pip install cmake
pip install dlib
pip install face-recognition
```

**Mac:**
```bash
brew install cmake
pip install dlib
pip install face-recognition
```

**Linux:**
```bash
sudo apt-get install cmake
sudo apt-get install libboost-all-dev
pip install dlib
pip install face-recognition
```

---

## 📚 Additional Resources

- [Full Documentation](README.md)
- [Architecture Guide](ARCHITECTURE.md)
- [Deployment Guide](DEPLOYMENT_GUIDE.md)
- [API Documentation](http://localhost:8000/docs) (when backend is running)

---

## 💡 Tips

1. **Use Mock Mode**: The app works without a trained model using mock predictions
2. **Hot Reload**: Both frontend and backend support hot reload during development
3. **API Docs**: Visit http://localhost:8000/docs for interactive API documentation
4. **Logs**: Check terminal output for debugging information

---

## ✅ Checklist

- [ ] Node.js 18+ installed
- [ ] Python 3.8+ installed
- [ ] Dependencies installed (`npm install` and `pip install`)
- [ ] Environment files created (`.env.local` and `api/.env`)
- [ ] Backend running on port 8000
- [ ] Frontend running on port 3000
- [ ] Can access http://localhost:3000
- [ ] Can upload and process videos

---

**Ready to build something amazing! 🚀**

Need help? Check the troubleshooting section or open an issue on GitHub.
