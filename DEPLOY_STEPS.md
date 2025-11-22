# 🚀 Simple Deployment Steps

## ✅ Quick Deploy (Automated)

Run this one command:

```powershell
.\cleanup-and-deploy.ps1
```

This will:
1. ✅ Clean up unnecessary files
2. ✅ Setup Git
3. ✅ Push to GitHub
4. ✅ Deploy to Vercel

---

## 📝 Manual Steps (If You Prefer)

### Step 1: Clean Up Project

Delete these unnecessary folders/files:
- `Django_Application/`
- `detection/`
- `deepfake_app/`
- `db.sqlite3`
- `manage.py`
- Old documentation files

### Step 2: Initialize Git

```powershell
git init
git add .
git commit -m "Initial commit: Deepfake Detection System"
```

### Step 3: Create GitHub Repository

1. Go to https://github.com/new
2. Create repository: `deepfake-detection`
3. Don't initialize with README (we have one)

### Step 4: Push to GitHub

```powershell
git remote add origin https://github.com/YOUR_USERNAME/deepfake-detection.git
git branch -M main
git push -u origin main
```

### Step 5: Deploy to Vercel

**Option A: Via Dashboard**
1. Go to https://vercel.com/
2. Click "Add New..." → "Project"
3. Import your GitHub repository
4. Click "Deploy"

**Option B: Via CLI**
```powershell
npm install -g vercel
vercel login
vercel --prod
```

---

## ✅ What Gets Deployed

**Frontend (Vercel):**
- ✅ Next.js app
- ✅ All pages (Home, How It Works, Model Info, About)
- ✅ Beautiful UI
- ✅ Responsive design

**Backend (Deploy Later):**
- ⏭️ FastAPI server (deploy to Railway separately)
- ⏭️ ML model
- ⏭️ Video processing

---

## 🎯 After Deployment

Your frontend will be live at:
```
https://your-app.vercel.app
```

**What works:**
- ✅ All pages
- ✅ Navigation
- ✅ UI/UX

**What needs backend:**
- ⚠️ Video upload (deploy backend to Railway)

---

## 🔧 Deploy Backend (Optional - Later)

When ready:

```powershell
cd api
railway login
railway init
railway up
```

Then update `NEXT_PUBLIC_API_URL` in Vercel.

---

## 📞 Need Help?

- **Automated**: Run `.\cleanup-and-deploy.ps1`
- **Manual**: Follow steps above
- **Issues**: Check TROUBLESHOOTING.md

---

**Ready? Run the script or follow manual steps!** 🚀
