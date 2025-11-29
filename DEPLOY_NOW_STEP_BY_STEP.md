# 🚀 Deploy NOW - Step by Step Guide

## ⏱️ Total Time: 20 Minutes
## 💰 Total Cost: $7/month (or FREE)

---

## 🎯 STEP 1: Deploy Frontend to Vercel (5 minutes)

### 1.1 Go to Vercel
```
🌐 Open: https://vercel.com
```

### 1.2 Sign Up/Login
- Click **"Sign Up"** or **"Login"**
- Choose **"Continue with GitHub"**
- Authorize Vercel to access your repositories

### 1.3 Import Project
- Click **"Add New..."** → **"Project"**
- Find your repository: **"T87-Deepfake-Video-Detection-System"**
- Click **"Import"**

### 1.4 Configure Build Settings

**Framework Preset:** Next.js (auto-detected)

**Root Directory:** `./` (leave as is)

**Build Command:**
```bash
npm run build
```

**Output Directory:**
```bash
.next
```

**Install Command:**
```bash
npm install
```

### 1.5 Add Environment Variable

Click **"Environment Variables"**

Add:
```
Name: NEXT_PUBLIC_API_URL
Value: https://placeholder.com
```
(We'll update this after backend deployment)

### 1.6 Deploy!

- Click **"Deploy"**
- Wait 2-3 minutes ⏳
- ✅ **Done!**

### 1.7 Save Your Frontend URL

You'll get a URL like:
```
https://t87-deepfake-video-detection-system.vercel.app
```

**📝 Write this down!** You'll need it for the backend.

---

## 🔧 STEP 2: Deploy Backend to Render (15 minutes)

### 2.1 Go to Render
```
🌐 Open: https://render.com
```

### 2.2 Sign Up/Login
- Click **"Get Started"** or **"Sign In"**
- Choose **"Continue with GitHub"**
- Authorize Render

### 2.3 Create New Web Service
- Click **"New +"** → **"Web Service"**
- Click **"Connect account"** (if needed)
- Find your repository: **"T87-Deepfake-Video-Detection-System"**
- Click **"Connect"**

### 2.4 Configure Service

**Name:**
```
deepfake-backend
```

**Region:**
```
Oregon (US West) - or closest to you
```

**Branch:**
```
main
```

**Root Directory:**
```
backend
```

**Runtime:**
```
Docker
```

**Instance Type:**
```
Starter - $7/month
```
(Or choose **Free** if you want to test first - but it sleeps after 15 min)

### 2.5 Add Environment Variables

Click **"Advanced"** → **"Add Environment Variable"**

Add these THREE variables:

**Variable 1:**
```
Key: PORT
Value: 8000
```

**Variable 2:**
```
Key: ALLOWED_ORIGINS
Value: https://YOUR-FRONTEND-URL.vercel.app,http://localhost:3000
```
(Replace with your actual Vercel URL from Step 1.7)

**Variable 3:**
```
Key: PYTHON_ENV
Value: production
```

### 2.6 Deploy!

- Click **"Create Web Service"**
- Wait 5-10 minutes ⏳ (Docker build takes time)
- Watch the logs - you'll see:
  ```
  Building Docker image...
  Pushing image...
  Starting service...
  ✓ Service is live!
  ```

### 2.7 Save Your Backend URL

You'll get a URL like:
```
https://deepfake-backend.onrender.com
```

**📝 Write this down!**

### 2.8 Test Backend

Open in browser:
```
https://deepfake-backend.onrender.com/health
```

You should see:
```json
{
  "status": "healthy",
  "ml_model": "Vision Transformer",
  "face_detection": "MTCNN + OpenCV"
}
```

✅ **Backend is live!**

---

## 🔄 STEP 3: Connect Frontend to Backend (2 minutes)

### 3.1 Update Frontend Environment

Go back to **Vercel Dashboard**

1. Select your project
2. Click **"Settings"**
3. Click **"Environment Variables"**
4. Find `NEXT_PUBLIC_API_URL`
5. Click **"Edit"**
6. Update value to:
   ```
   https://deepfake-backend.onrender.com
   ```
   (Use your actual backend URL from Step 2.7)
7. Click **"Save"**

### 3.2 Redeploy Frontend

1. Go to **"Deployments"** tab
2. Click the **"..."** menu on the latest deployment
3. Click **"Redeploy"**
4. Wait 1-2 minutes

✅ **Frontend updated!**

---

## ✅ STEP 4: Test Everything (3 minutes)

### 4.1 Open Your App

Visit your frontend URL:
```
https://YOUR-PROJECT.vercel.app
```

### 4.2 Test Upload

1. Click or drag a video file
2. Adjust frames slider (try 20-40)
3. Click **"Analyze Video"**
4. Wait for processing
5. See results!

### 4.3 Check All Pages

- **Home**: Upload and results ✅
- **Metrics**: Performance dashboard ✅
- **About**: Ethics and info ✅

### 4.4 Verify API Connection

Open browser console (F12) and check:
- No CORS errors ✅
- API calls successful ✅
- Images loading ✅

---

## 🎉 SUCCESS! You're Live!

### Your Live URLs:

**Frontend (Public):**
```
https://YOUR-PROJECT.vercel.app
```

**Backend API:**
```
https://deepfake-backend.onrender.com
```

**API Documentation:**
```
https://deepfake-backend.onrender.com/docs
```

---

## 📱 Share Your Project

### For Your Team:
```
Frontend: https://YOUR-PROJECT.vercel.app
Backend: https://deepfake-backend.onrender.com
GitHub: https://github.com/Shaileshgole23/T87-Deepfake-Video-Detection-System
```

### For Your Professors:
```
Live Demo: https://YOUR-PROJECT.vercel.app
Documentation: https://github.com/Shaileshgole23/T87-Deepfake-Video-Detection-System#readme
```

### For Your Resume:
```
Deepfake Detection System
- Live: https://YOUR-PROJECT.vercel.app
- Tech: Next.js, FastAPI, PyTorch, Vision Transformer
- Features: 87.5% accuracy, real-time analysis
```

---

## 🔧 Post-Deployment Tasks

### 1. Update README

Add live URLs to your README.md:

```markdown
## 🌐 Live Demo

**Frontend**: https://YOUR-PROJECT.vercel.app
**Backend API**: https://deepfake-backend.onrender.com
**API Docs**: https://deepfake-backend.onrender.com/docs
```

### 2. Add Deployment Badges

```markdown
[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/Shaileshgole23/T87-Deepfake-Video-Detection-System)

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)
```

### 3. Set Up Monitoring

**Vercel:**
- Go to Analytics tab
- View page views, performance

**Render:**
- Go to Metrics tab
- Monitor CPU, memory, requests

### 4. Configure Alerts (Optional)

**Render:**
- Settings → Notifications
- Add email for downtime alerts

---

## 💰 Cost Breakdown

### What You're Paying For:

**Vercel (Frontend):**
- ✅ FREE forever
- ✅ Unlimited bandwidth
- ✅ Automatic HTTPS
- ✅ Global CDN

**Render (Backend):**
- 💵 $7/month (Starter plan)
- ✅ 512 MB RAM
- ✅ Always-on (no sleep)
- ✅ Automatic HTTPS
- ✅ Free SSL

**Total: $7/month**

### Free Alternative:

Use Render **Free** tier:
- ✅ FREE
- ⚠️ Sleeps after 15 min inactivity
- ⚠️ Slower cold starts (30-60 seconds)
- ✅ Good for demos/testing

---

## 🐛 Troubleshooting

### Frontend Issues

**Build fails:**
```bash
# Check Vercel build logs
# Common fix: Clear cache and redeploy
```

**API not connecting:**
```bash
# Verify NEXT_PUBLIC_API_URL is correct
# Check browser console for errors
# Verify backend is running
```

### Backend Issues

**Build fails:**
```bash
# Check Render logs
# Verify Dockerfile is correct
# Check requirements.txt
```

**Service crashes:**
```bash
# Check Render logs
# Verify environment variables
# May need to upgrade instance size
```

**Slow/timeout:**
```bash
# Free tier sleeps after 15 min
# First request takes 30-60 seconds
# Upgrade to Starter ($7/month) for always-on
```

### CORS Errors

```bash
# Update ALLOWED_ORIGINS in Render
# Include your Vercel URL
# Redeploy backend
```

---

## 🔄 Making Updates

### Update Frontend:

```bash
# Make changes locally
git add .
git commit -m "Update frontend"
git push origin main

# Vercel auto-deploys in 2-3 minutes
```

### Update Backend:

```bash
# Make changes locally
git add .
git commit -m "Update backend"
git push origin main

# Render auto-deploys in 5-10 minutes
```

### Update Environment Variables:

**Vercel:**
1. Dashboard → Settings → Environment Variables
2. Edit variable
3. Redeploy

**Render:**
1. Dashboard → Environment
2. Edit variable
3. Auto-redeploys

---

## 📊 Monitoring Your App

### Check Status:

**Frontend:**
```bash
curl https://YOUR-PROJECT.vercel.app
# Should return HTML
```

**Backend:**
```bash
curl https://deepfake-backend.onrender.com/health
# Should return JSON with "status": "healthy"
```

### View Logs:

**Vercel:**
- Dashboard → Functions → View logs

**Render:**
- Dashboard → Logs → View real-time logs

### Monitor Performance:

**Vercel:**
- Analytics tab shows:
  - Page views
  - Load times
  - Visitor locations

**Render:**
- Metrics tab shows:
  - CPU usage
  - Memory usage
  - Request count
  - Response times

---

## 🎓 For Your Project Submission

### What to Include:

1. **Live Demo Link**
   ```
   https://YOUR-PROJECT.vercel.app
   ```

2. **GitHub Repository**
   ```
   https://github.com/Shaileshgole23/T87-Deepfake-Video-Detection-System
   ```

3. **API Documentation**
   ```
   https://deepfake-backend.onrender.com/docs
   ```

4. **Demo Video** (Optional)
   - Record screen showing:
     - Upload video
     - Processing
     - Results display
     - Metrics page
     - About page

5. **Architecture Diagram**
   - See ARCHITECTURE.md

---

## ✅ Deployment Checklist

- [x] Code pushed to GitHub
- [ ] Frontend deployed to Vercel
- [ ] Backend deployed to Render
- [ ] Environment variables configured
- [ ] Frontend connected to backend
- [ ] All pages working
- [ ] Video upload working
- [ ] Results displaying correctly
- [ ] README updated with live URLs
- [ ] Team members notified
- [ ] Professors notified

---

## 🎉 You're Done!

Your complete deepfake detection system is now:

✅ **Live on the internet**
✅ **Accessible from anywhere**
✅ **Automatically deploying updates**
✅ **Professional and production-ready**
✅ **Ready to showcase**

**Congratulations!** 🎊

---

## 📞 Need Help?

- **Vercel Support**: https://vercel.com/support
- **Render Support**: https://render.com/docs
- **Your Docs**: See COMPLETE_DEPLOYMENT.md

---

**Made with ❤️ by Team T-87 from GLA University**

**Now go show off your deployed project!** 🚀
