# 🚀 Complete Deployment Guide - All Components

## 📊 Deployment Strategy Overview

| Component | Platform | Cost | Difficulty | Time |
|-----------|----------|------|------------|------|
| **Frontend** | Vercel | FREE | ⭐ Easy | 5 min |
| **Backend** | Render | $7/month | ⭐⭐ Medium | 15 min |
| **ML Model** | Included in Backend | - | - | - |
| **Database** | Not needed | FREE | - | - |

**Total Cost**: $7/month (or FREE with alternatives)
**Total Time**: ~20 minutes

---

## 🎯 Recommended Deployment Plan

### Best Option: Vercel (Frontend) + Render (Backend)

**Why this combination?**
- ✅ Easiest to set up
- ✅ Automatic deployments from GitHub
- ✅ Free SSL certificates
- ✅ Good performance
- ✅ Generous free tiers
- ✅ No credit card needed for frontend

---

## 📦 PART 1: Deploy Frontend to Vercel

### Step 1: Prepare Frontend

Your frontend is already in the root directory with Next.js configuration.

**Verify files exist:**
- ✅ `app/` directory
- ✅ `package.json`
- ✅ `next.config.js`

### Step 2: Deploy to Vercel

#### Option A: Using Vercel Website (Easiest)

1. **Go to Vercel**
   - Visit: https://vercel.com
   - Click "Sign Up" or "Login"
   - Choose "Continue with GitHub"

2. **Import Project**
   - Click "Add New..." → "Project"
   - Select your repository: `T87-Deepfake-Video-Detection-System`
   - Click "Import"

3. **Configure Project**
   ```
   Framework Preset: Next.js
   Root Directory: ./
   Build Command: npm run build
   Output Directory: .next
   Install Command: npm install
   ```

4. **Environment Variables**
   Add this variable:
   ```
   NEXT_PUBLIC_API_URL = https://your-backend-url.onrender.com
   ```
   (We'll get the backend URL in Part 2)

5. **Deploy**
   - Click "Deploy"
   - Wait 2-3 minutes
   - Your frontend will be live at: `https://your-project.vercel.app`

#### Option B: Using Vercel CLI

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel --prod

# Follow prompts:
# - Link to existing project? No
# - Project name: deepfake-detection
# - Directory: ./
# - Override settings? No
```

### Step 3: Get Your Frontend URL

After deployment, you'll get a URL like:
```
https://deepfake-detection-abc123.vercel.app
```

**Save this URL!** You'll need it for the backend CORS configuration.

---

## 🔧 PART 2: Deploy Backend to Render

### Step 1: Prepare Backend

Your backend is in the `backend/` directory with:
- ✅ `main.py`
- ✅ `requirements.txt`
- ✅ `Dockerfile`

### Step 2: Deploy to Render

1. **Go to Render**
   - Visit: https://render.com
   - Click "Get Started" or "Sign In"
   - Choose "Continue with GitHub"

2. **Create New Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Select: `T87-Deepfake-Video-Detection-System`

3. **Configure Service**
   ```
   Name: deepfake-backend
   Region: Oregon (US West) or closest to you
   Branch: main
   Root Directory: backend
   Runtime: Docker
   ```

4. **Environment Variables**
   Add these variables:
   ```
   PORT = 8000
   ALLOWED_ORIGINS = https://your-frontend.vercel.app,http://localhost:3000
   PYTHON_ENV = production
   ```

5. **Instance Type**
   - Select: **Starter** ($7/month)
   - Or: **Free** (limited, sleeps after inactivity)

6. **Deploy**
   - Click "Create Web Service"
   - Wait 5-10 minutes for build
   - Your backend will be live at: `https://deepfake-backend.onrender.com`

### Step 3: Update Frontend Environment

1. Go back to Vercel dashboard
2. Select your project
3. Go to Settings → Environment Variables
4. Update `NEXT_PUBLIC_API_URL`:
   ```
   NEXT_PUBLIC_API_URL = https://deepfake-backend.onrender.com
   ```
5. Redeploy frontend (Deployments → Click "..." → Redeploy)

---

## 🎨 PART 3: Configure CORS

### Update Backend CORS Settings

Your backend is already configured, but verify in `backend/main.py`:

```python
ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "*").split(",")
app.add_middleware(
    CORSMiddleware,
    allow_origins=ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

In Render, make sure `ALLOWED_ORIGINS` includes your Vercel URL:
```
https://your-project.vercel.app,http://localhost:3000
```

---

## ✅ PART 4: Test Deployment

### 1. Test Backend

```bash
# Health check
curl https://deepfake-backend.onrender.com/health

# Expected response:
{
  "status": "healthy",
  "ml_model": "Vision Transformer",
  "face_detection": "MTCNN + OpenCV"
}
```

### 2. Test Frontend

1. Visit: `https://your-project.vercel.app`
2. Upload a test video
3. Verify it processes correctly
4. Check results display

### 3. Test Full Flow

1. Open frontend
2. Upload video
3. Wait for processing
4. Verify results show:
   - Prediction (REAL/FAKE)
   - Confidence score
   - Extracted frames
   - Detected faces
   - Charts

---

## 🔄 Alternative Deployment Options

### Option 2: Railway (Backend Alternative)

**Pros**: Easier than Render, good free tier
**Cons**: $5/month after free credits

**Steps:**
1. Go to https://railway.app
2. Sign in with GitHub
3. "New Project" → "Deploy from GitHub repo"
4. Select your repository
5. Select `backend` as root directory
6. Add environment variables
7. Deploy

**Cost**: $5/month (500 hours free)

### Option 3: Netlify (Frontend Alternative)

**Pros**: Similar to Vercel, good performance
**Cons**: Slightly more complex configuration

**Steps:**
1. Go to https://netlify.com
2. "Add new site" → "Import from Git"
3. Select repository
4. Configure build settings
5. Deploy

**Cost**: FREE

### Option 4: Azure (Full Stack - Best for Students)

**Pros**: $100 free credits, professional
**Cons**: More complex setup

See `AZURE_DEPLOY.md` for detailed instructions.

**Cost**: FREE for 6 months with student account

---

## 💰 Cost Comparison

### Recommended (Vercel + Render)
- Frontend: **FREE** (Vercel)
- Backend: **$7/month** (Render Starter)
- **Total: $7/month**

### Budget Option (Vercel + Render Free)
- Frontend: **FREE** (Vercel)
- Backend: **FREE** (Render Free - sleeps after 15 min)
- **Total: FREE** (but slower)

### Student Option (Azure)
- Frontend: **FREE** (Static Web Apps)
- Backend: **$15/month** (Container Apps)
- **Total: FREE for 6 months** ($100 credit)

### Premium Option (Vercel + Railway)
- Frontend: **FREE** (Vercel)
- Backend: **$5/month** (Railway)
- **Total: $5/month**

---

## 🎯 Step-by-Step Deployment Checklist

### Pre-Deployment
- [x] Code pushed to GitHub
- [x] Frontend in root directory
- [x] Backend in `backend/` directory
- [x] Dockerfile exists
- [x] Environment variables documented

### Frontend Deployment (Vercel)
- [ ] Create Vercel account
- [ ] Import GitHub repository
- [ ] Configure build settings
- [ ] Add environment variables (placeholder)
- [ ] Deploy
- [ ] Note frontend URL

### Backend Deployment (Render)
- [ ] Create Render account
- [ ] Create new Web Service
- [ ] Connect GitHub repository
- [ ] Configure Docker deployment
- [ ] Add environment variables
- [ ] Deploy
- [ ] Note backend URL

### Configuration
- [ ] Update frontend env with backend URL
- [ ] Update backend CORS with frontend URL
- [ ] Redeploy both services
- [ ] Test health endpoints
- [ ] Test full application flow

### Post-Deployment
- [ ] Add custom domain (optional)
- [ ] Set up monitoring
- [ ] Configure alerts
- [ ] Share URLs with team
- [ ] Update README with live URLs

---

## 🔐 Environment Variables Reference

### Frontend (.env.local or Vercel)
```bash
NEXT_PUBLIC_API_URL=https://your-backend.onrender.com
```

### Backend (Render Environment Variables)
```bash
PORT=8000
ALLOWED_ORIGINS=https://your-frontend.vercel.app,http://localhost:3000
PYTHON_ENV=production
```

---

## 📊 Monitoring & Maintenance

### Vercel Dashboard
- View deployments
- Check build logs
- Monitor analytics
- View function logs

### Render Dashboard
- View service status
- Check logs
- Monitor metrics
- View events

### Health Checks

**Backend:**
```bash
curl https://your-backend.onrender.com/health
```

**Frontend:**
```bash
curl https://your-frontend.vercel.app
```

---

## 🐛 Troubleshooting

### Frontend Issues

**Issue: Build fails**
```bash
# Check build logs in Vercel
# Common fixes:
# 1. Verify package.json is correct
# 2. Check Node version (use 20.x)
# 3. Clear cache and redeploy
```

**Issue: API calls fail**
```bash
# Check NEXT_PUBLIC_API_URL is set correctly
# Verify CORS is configured on backend
# Check browser console for errors
```

### Backend Issues

**Issue: Build fails**
```bash
# Check Dockerfile syntax
# Verify requirements.txt is complete
# Check Render build logs
```

**Issue: Service crashes**
```bash
# Check logs in Render dashboard
# Verify environment variables
# Check memory usage (upgrade if needed)
```

**Issue: Slow response**
```bash
# Render free tier sleeps after 15 min
# Upgrade to Starter ($7/month) for always-on
# Or use Railway ($5/month)
```

### CORS Issues

**Issue: CORS errors in browser**
```bash
# Update backend ALLOWED_ORIGINS
# Include your Vercel URL
# Redeploy backend
# Clear browser cache
```

---

## 🚀 Quick Deploy Commands

### Deploy Frontend (Vercel CLI)
```bash
cd /path/to/project
vercel --prod
```

### Deploy Backend (Render)
```bash
# Automatic from GitHub
# Just push to main branch:
git push origin main
```

### Update Environment Variables

**Vercel:**
```bash
vercel env add NEXT_PUBLIC_API_URL production
# Enter value: https://your-backend.onrender.com
```

**Render:**
- Go to dashboard → Environment
- Add/update variables
- Service auto-redeploys

---

## 📱 Custom Domain (Optional)

### Add Custom Domain to Vercel

1. Go to Project Settings → Domains
2. Add your domain: `deepfake-detector.com`
3. Configure DNS:
   ```
   Type: CNAME
   Name: www
   Value: cname.vercel-dns.com
   ```
4. Wait for DNS propagation (5-30 min)

### Add Custom Domain to Render

1. Go to Service Settings → Custom Domain
2. Add your domain: `api.deepfake-detector.com`
3. Configure DNS:
   ```
   Type: CNAME
   Name: api
   Value: your-service.onrender.com
   ```

---

## 🎓 For Your Project

### Live URLs to Share

After deployment, you'll have:

**Frontend:**
```
https://deepfake-detection.vercel.app
```

**Backend API:**
```
https://deepfake-backend.onrender.com
```

**API Documentation:**
```
https://deepfake-backend.onrender.com/docs
```

### Update README

Add these badges to your README:

```markdown
[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/YOUR_USERNAME/T87-Deepfake-Video-Detection-System)

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)
```

---

## 🎉 Success!

After following this guide, you'll have:

✅ **Frontend deployed** on Vercel (FREE)
✅ **Backend deployed** on Render ($7/month or FREE)
✅ **ML model running** in production
✅ **HTTPS enabled** automatically
✅ **Auto-deployments** from GitHub
✅ **Professional URLs** to share

**Total time**: ~20 minutes
**Total cost**: $7/month (or FREE with limitations)

---

## 📞 Support

- **Vercel Docs**: https://vercel.com/docs
- **Render Docs**: https://render.com/docs
- **Your Docs**: See DEPLOYMENT_GUIDE.md

---

**Ready to deploy? Let's do it!** 🚀

**Next**: Follow Part 1 to deploy frontend to Vercel
