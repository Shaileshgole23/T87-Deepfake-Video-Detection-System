# 🚀 START HERE - Quick Fix for Your Error

## ❌ Your Error: "Unexpected token 'I', 'Internal S'... is not valid JSON"

### ✅ Solution (3 Steps):

#### Step 1: Make sure you have the environment file
```powershell
# Check if .env.local exists
Get-Content .env.local

# If it doesn't exist, create it:
Copy-Item .env.example .env.local
```

#### Step 2: Start the Backend Server
```powershell
# Open Terminal 1 and run:
cd api
.\venv\Scripts\Activate.ps1
python main.py
```

You should see:
```
INFO:     Uvicorn running on http://0.0.0.0:8000
```

#### Step 3: Start the Frontend Server
```powershell
# Open Terminal 2 and run:
npm run dev
```

You should see:
```
- Local:        http://localhost:3000
```

### 🎯 Now Try Again!

1. Open http://localhost:3000
2. Upload a video
3. It should work! ✅

---

## 🚀 Even Faster: Use the Start Script

```powershell
.\start.ps1
```

This will:
- ✅ Start backend automatically
- ✅ Start frontend automatically
- ✅ Open browser automatically

---

## 🔍 Verify Everything is Working

### Check Backend:
```powershell
curl http://localhost:8000/health
```

Expected response:
```json
{"status":"healthy","ml_model":"unavailable"}
```

### Check Frontend:
Open http://localhost:3000 in your browser

---

## ❌ Still Not Working?

### Common Issues:

**1. "Port already in use"**
```powershell
# Kill process on port 8000
netstat -ano | findstr :8000
taskkill /PID <PID> /F

# Kill process on port 3000
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

**2. "Module not found"**
```powershell
# Reinstall dependencies
npm install
cd api
pip install -r requirements.txt
```

**3. "Virtual environment not found"**
```powershell
# Run setup first
.\setup.ps1
```

---

## 📚 Need More Help?

- **Detailed Troubleshooting**: See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Complete Setup Guide**: See [QUICK_START.md](QUICK_START.md)
- **Getting Started**: See [GETTING_STARTED.md](GETTING_STARTED.md)

---

## ✅ Quick Checklist

Before uploading a video, make sure:

- [ ] Backend is running (Terminal 1 shows "Uvicorn running")
- [ ] Frontend is running (Terminal 2 shows "Local: http://localhost:3000")
- [ ] You can access http://localhost:8000/health
- [ ] You can access http://localhost:3000
- [ ] .env.local file exists

---

## 🎉 Success!

Once both servers are running:
1. Go to http://localhost:3000
2. Click "Try Demo Now"
3. Upload a video (MP4, AVI, MOV, etc.)
4. Wait for processing
5. See results!

**The error happens when the backend isn't running. Just make sure both servers are up! 🚀**
