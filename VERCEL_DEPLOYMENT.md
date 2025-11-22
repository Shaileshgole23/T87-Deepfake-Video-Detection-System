# 🚀 Vercel Deployment Guide

## Quick Deployment Steps

### Method 1: Deploy via Vercel Dashboard (Easiest)

1. **Go to Vercel Dashboard**
   - Visit: https://vercel.com/
   - Sign up or login with GitHub

2. **Import Your Project**
   - Click "Add New..." → "Project"
   - Import your GitHub repository
   - Or upload your project folder

3. **Configure Build Settings**
   - Framework Preset: **Next.js**
   - Build Command: `npm run build`
   - Output Directory: `.next`
   - Install Command: `npm install`

4. **Set Environment Variables**
   - Click "Environment Variables"
   - Add: `NEXT_PUBLIC_API_URL` = `http://localhost:8000` (temporary)
   - We'll update this after deploying the backend

5. **Deploy!**
   - Click "Deploy"
   - Wait 2-3 minutes
   - Your frontend will be live! 🎉

---

### Method 2: Deploy via CLI

#### Step 1: Login to Vercel

```powershell
vercel login
```

- A browser window will open
- Login with GitHub, GitLab, or Email
- Return to terminal after authentication

#### Step 2: Deploy

```powershell
# Deploy to preview
vercel

# Or deploy to production directly
vercel --prod
```

Follow the prompts:
- **Set up and deploy?** → Yes
- **Which scope?** → Your account
- **Link to existing project?** → No
- **Project name?** → deepfake-detection (or your choice)
- **Directory?** → ./ (current directory)
- **Override settings?** → No

#### Step 3: Set Environment Variables

After deployment, set environment variables:

```powershell
# Set environment variable
vercel env add NEXT_PUBLIC_API_URL

# When prompted, enter: http://localhost:8000
# Select: Production, Preview, Development
```

Or set via dashboard:
1. Go to your project on Vercel
2. Settings → Environment Variables
3. Add `NEXT_PUBLIC_API_URL`

---

## 🔧 Backend Deployment Options

Since Vercel is primarily for frontend, you need to deploy the backend separately.

### Option 1: Railway (Recommended)

1. **Install Railway CLI**
   ```powershell
   npm install -g @railway/cli
   ```

2. **Login**
   ```powershell
   railway login
   ```

3. **Deploy Backend**
   ```powershell
   cd api
   railway init
   railway up
   ```

4. **Get Backend URL**
   ```powershell
   railway domain
   ```

5. **Update Vercel Environment Variable**
   - Go to Vercel Dashboard
   - Settings → Environment Variables
   - Update `NEXT_PUBLIC_API_URL` to your Railway URL
   - Redeploy: `vercel --prod`

### Option 2: Render.com (Free Tier)

1. Go to https://render.com/
2. Sign up with GitHub
3. Click "New +" → "Web Service"
4. Connect your repository
5. Configure:
   - **Name**: deepfake-api
   - **Root Directory**: api
   - **Environment**: Python 3
   - **Build Command**: `pip install -r requirements-simple.txt`
   - **Start Command**: `uvicorn main:app --host 0.0.0.0 --port $PORT`
6. Add Environment Variables:
   - `DEBUG=False`
   - `ALLOWED_ORIGINS=https://your-vercel-app.vercel.app`
7. Deploy!

### Option 3: Vercel Serverless Functions (Limited)

**Note**: This won't work well for ML models due to size limits, but you can try:

1. Move `api/main.py` to `api/index.py`
2. Create `api/requirements.txt` with only FastAPI
3. Deploy with frontend

---

## 📝 Complete Deployment Checklist

### Frontend (Vercel)
- [ ] Vercel account created
- [ ] Project imported/uploaded
- [ ] Build successful
- [ ] Environment variables set
- [ ] Deployed to production
- [ ] Custom domain added (optional)

### Backend (Railway/Render)
- [ ] Backend service created
- [ ] Repository connected
- [ ] Build successful
- [ ] Environment variables set
- [ ] Backend URL obtained
- [ ] CORS configured

### Integration
- [ ] Frontend `NEXT_PUBLIC_API_URL` updated with backend URL
- [ ] Backend `ALLOWED_ORIGINS` includes frontend URL
- [ ] Frontend redeployed with new env var
- [ ] Test video upload works
- [ ] All pages accessible

---

## 🎯 Quick Deploy Commands

### Deploy Frontend to Vercel
```powershell
# First time
vercel

# Production
vercel --prod

# Check deployment
vercel ls
```

### Deploy Backend to Railway
```powershell
cd api
railway login
railway init
railway up
railway domain
```

---

## 🔍 Verify Deployment

### Check Frontend
```powershell
# Visit your Vercel URL
# Should see the landing page
```

### Check Backend
```powershell
# Test health endpoint
curl https://your-backend-url.railway.app/health

# Should return: {"status":"healthy","ml_model":"unavailable"}
```

### Test Integration
1. Go to your Vercel URL
2. Click "Try Demo Now"
3. Upload a video
4. Should process and show results

---

## ❌ Troubleshooting

### Build Fails on Vercel

**Error: "Module not found"**
```powershell
# Make sure all dependencies are in package.json
npm install
git add package.json package-lock.json
git commit -m "Update dependencies"
git push
```

**Error: "Build timeout"**
- Increase build timeout in Vercel settings
- Or optimize your build

### Backend Not Connecting

**CORS Error**
- Update `ALLOWED_ORIGINS` in backend
- Include your Vercel URL
- Redeploy backend

**404 Error**
- Check backend URL is correct
- Verify backend is running
- Check Railway/Render logs

### Environment Variables Not Working

- Make sure they start with `NEXT_PUBLIC_` for frontend
- Redeploy after adding env vars
- Check they're set for correct environment (Production/Preview)

---

## 🎉 Success!

Once deployed, you'll have:
- ✅ Frontend live on Vercel (e.g., `your-app.vercel.app`)
- ✅ Backend live on Railway/Render
- ✅ Fully functional deepfake detection app
- ✅ Accessible from anywhere
- ✅ Automatic HTTPS
- ✅ Global CDN

---

## 📊 Deployment URLs

After deployment, save these:

**Frontend URL**: `https://your-app.vercel.app`
**Backend URL**: `https://your-api.railway.app`
**API Docs**: `https://your-api.railway.app/docs`

---

## 🔄 Continuous Deployment

Both Vercel and Railway support automatic deployments:

1. Push to GitHub
2. Vercel automatically deploys frontend
3. Railway automatically deploys backend
4. Changes go live in minutes!

---

## 💰 Cost

**Free Tier Limits:**
- **Vercel**: 100GB bandwidth, unlimited requests
- **Railway**: $5 credit/month (enough for light usage)
- **Render**: 750 hours/month free

**Total**: $0-5/month for demo/portfolio use

---

## 📞 Need Help?

If deployment fails:
1. Check build logs in Vercel/Railway dashboard
2. Verify all files are committed to Git
3. Check environment variables are set
4. Review error messages carefully
5. Try deploying again

---

**Your app is ready to go live! 🚀**
