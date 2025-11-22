# 🚀 Complete Deployment Guide

This guide will walk you through deploying your Deepfake Detection System to production.

## 📋 Prerequisites

- Node.js 18+ installed
- Python 3.8+ installed
- Git installed
- GitHub account
- Vercel account (free tier works)
- Railway account (for backend) OR DigitalOcean account

## 🎯 Deployment Architecture

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│  Frontend (Vercel)                                      │
│  - Next.js 14 App                                       │
│  - Static Assets                                        │
│  - Edge Functions                                       │
│  - Global CDN                                           │
│                                                         │
└────────────────┬────────────────────────────────────────┘
                 │
                 │ HTTPS API Calls
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│                                                         │
│  Backend (Railway/DigitalOcean)                         │
│  - FastAPI Server                                       │
│  - ML Model Inference                                   │
│  - Video Processing                                     │
│  - Face Detection                                       │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## 📦 Step 1: Prepare Your Repository

### 1.1 Initialize Git (if not already done)

```bash
git init
git add .
git commit -m "Initial commit: Deepfake Detection System"
```

### 1.2 Create GitHub Repository

1. Go to https://github.com/new
2. Create a new repository (e.g., `deepfake-detection`)
3. Push your code:

```bash
git remote add origin https://github.com/YOUR_USERNAME/deepfake-detection.git
git branch -M main
git push -u origin main
```

## 🎨 Step 2: Deploy Frontend to Vercel

### 2.1 Install Vercel CLI

```bash
npm install -g vercel
```

### 2.2 Login to Vercel

```bash
vercel login
```

### 2.3 Deploy

```bash
# From project root
vercel

# Follow the prompts:
# - Set up and deploy? Yes
# - Which scope? Your account
# - Link to existing project? No
# - Project name? deepfake-detection
# - Directory? ./
# - Override settings? No
```

### 2.4 Set Environment Variables

After deployment, set environment variables in Vercel dashboard:

1. Go to https://vercel.com/dashboard
2. Select your project
3. Go to Settings → Environment Variables
4. Add:
   ```
   NEXT_PUBLIC_API_URL=https://your-backend-url.railway.app
   ```

### 2.5 Deploy to Production

```bash
vercel --prod
```

Your frontend is now live! 🎉

## 🔧 Step 3: Deploy Backend to Railway

### 3.1 Install Railway CLI

```bash
npm install -g @railway/cli
```

### 3.2 Login to Railway

```bash
railway login
```

### 3.3 Initialize Railway Project

```bash
cd api
railway init
```

### 3.4 Deploy

```bash
railway up
```

### 3.5 Set Environment Variables

```bash
railway variables set DEBUG=False
railway variables set ALLOWED_ORIGINS=https://your-vercel-app.vercel.app
railway variables set PORT=8000
```

### 3.6 Get Your Backend URL

```bash
railway domain
```

Copy this URL and update your Vercel environment variable `NEXT_PUBLIC_API_URL`.

## 🐳 Alternative: Deploy Backend to DigitalOcean

### 3A.1 Create DigitalOcean App

1. Go to https://cloud.digitalocean.com/apps
2. Click "Create App"
3. Connect your GitHub repository
4. Select the `api` directory
5. Choose "Dockerfile" as build method

### 3A.2 Configure Environment Variables

In the DigitalOcean dashboard:
- `DEBUG=False`
- `ALLOWED_ORIGINS=https://your-vercel-app.vercel.app`
- `PORT=8000`

### 3A.3 Deploy

Click "Create Resources" and wait for deployment.

## 📊 Step 4: Upload ML Model (Important!)

Your ML model file is too large for Git. You need to upload it separately:

### Option A: Railway

```bash
# SSH into Railway container
railway run bash

# Upload model using scp or download from cloud storage
wget https://your-storage-url/model_best.pt -O models/model_best.pt
```

### Option B: Use Cloud Storage

1. Upload `model_best.pt` to AWS S3, Google Cloud Storage, or similar
2. Modify `api/ml_model.py` to download model on startup:

```python
import requests

def download_model():
    url = "https://your-storage-url/model_best.pt"
    response = requests.get(url)
    with open("models/model_best.pt", "wb") as f:
        f.write(response.content)
```

### Option C: Use Git LFS

```bash
# Install Git LFS
git lfs install

# Track model files
git lfs track "*.pt"
git lfs track "*.pth"

# Add and commit
git add .gitattributes
git add models/model_best.pt
git commit -m "Add ML model with Git LFS"
git push
```

## ✅ Step 5: Verify Deployment

### 5.1 Test Backend

```bash
curl https://your-backend-url.railway.app/health
```

Expected response:
```json
{
  "status": "healthy",
  "ml_model": "loaded"
}
```

### 5.2 Test Frontend

1. Visit your Vercel URL
2. Try uploading a test video
3. Verify results are displayed correctly

## 🔒 Step 6: Security Configuration

### 6.1 Update CORS Settings

In `api/main.py`, update allowed origins:

```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://your-vercel-app.vercel.app",
        "https://your-custom-domain.com"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### 6.2 Add Rate Limiting (Optional)

Install slowapi:
```bash
pip install slowapi
```

Add to `api/main.py`:
```python
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter

@app.post("/api/predict/")
@limiter.limit("5/minute")
async def predict_deepfake(...):
    ...
```

## 🌐 Step 7: Custom Domain (Optional)

### 7.1 Add Domain to Vercel

1. Go to Project Settings → Domains
2. Add your custom domain
3. Update DNS records as instructed

### 7.2 Add Domain to Railway

```bash
railway domain add your-api-domain.com
```

Update DNS:
```
Type: CNAME
Name: api (or your subdomain)
Value: your-app.railway.app
```

## 📈 Step 8: Monitoring & Analytics

### 8.1 Vercel Analytics

Vercel Analytics is automatically enabled. View in dashboard.

### 8.2 Backend Monitoring

Add logging to `api/main.py`:

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.post("/api/predict/")
async def predict_deepfake(...):
    logger.info(f"Processing video: {upload_video_file.filename}")
    ...
```

### 8.3 Error Tracking (Optional)

Add Sentry:

```bash
pip install sentry-sdk
```

```python
import sentry_sdk

sentry_sdk.init(
    dsn="your-sentry-dsn",
    traces_sample_rate=1.0,
)
```

## 🔄 Step 9: Continuous Deployment

Both Vercel and Railway support automatic deployments:

1. **Vercel**: Automatically deploys on push to `main` branch
2. **Railway**: Automatically deploys on push to connected branch

To disable auto-deploy:
- Vercel: Project Settings → Git → Disable
- Railway: Settings → Deployments → Manual

## 🐛 Troubleshooting

### Frontend Issues

**Build fails:**
```bash
# Check build locally
npm run build

# Check logs in Vercel dashboard
```

**Environment variables not working:**
- Ensure variables start with `NEXT_PUBLIC_`
- Redeploy after adding variables

### Backend Issues

**Model not loading:**
- Check model file exists in `models/` directory
- Verify file permissions
- Check logs: `railway logs`

**CORS errors:**
- Update `ALLOWED_ORIGINS` in backend
- Ensure frontend URL is correct

**Timeout errors:**
- Increase timeout in Vercel config
- Optimize video processing
- Consider using background jobs

### Performance Issues

**Slow inference:**
- Use CPU-optimized PyTorch build
- Reduce sequence length
- Consider using ONNX runtime

**High memory usage:**
- Limit concurrent requests
- Add request queuing
- Scale backend resources

## 📊 Cost Estimation

### Free Tier (Recommended for Demo)

- **Vercel**: Free (100GB bandwidth, unlimited requests)
- **Railway**: $5/month credit (enough for light usage)
- **Total**: ~$0-5/month

### Production Tier

- **Vercel Pro**: $20/month (1TB bandwidth)
- **Railway**: $20-50/month (depending on usage)
- **Total**: ~$40-70/month

## 🎉 Success!

Your Deepfake Detection System is now live and production-ready!

### Next Steps

1. ✅ Share your app URL
2. ✅ Add to your portfolio
3. ✅ Present at hackathons/competitions
4. ✅ Add to your resume
5. ✅ Get feedback and iterate

### Useful Commands

```bash
# View frontend logs
vercel logs

# View backend logs
railway logs

# Redeploy frontend
vercel --prod

# Redeploy backend
railway up

# Check deployment status
vercel ls
railway status
```

## 📞 Support

If you encounter issues:

1. Check the logs (Vercel/Railway dashboard)
2. Review this guide
3. Check GitHub Issues
4. Contact support

---

**Congratulations! Your AI-powered Deepfake Detection System is now live! 🚀**
