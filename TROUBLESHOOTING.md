# 🔧 Troubleshooting Guide

## Common Issues and Solutions

### ❌ Error: "Unexpected token 'I', 'Internal S'... is not valid JSON"

**Cause:** The backend server is not running or not reachable.

**Solution:**

1. **Check if backend is running:**
   ```powershell
   # Open a new terminal and run:
   cd api
   .\venv\Scripts\Activate.ps1
   python main.py
   ```

2. **Verify backend is accessible:**
   ```powershell
   # In another terminal:
   curl http://localhost:8000/health
   ```
   
   Expected response:
   ```json
   {"status":"healthy","ml_model":"unavailable"}
   ```

3. **Check .env.local file exists:**
   ```powershell
   # Make sure this file exists in project root:
   Get-Content .env.local
   ```
   
   Should contain:
   ```
   NEXT_PUBLIC_API_URL=http://localhost:8000
   ```

4. **Restart both servers:**
   
   **Terminal 1 (Backend):**
   ```powershell
   cd api
   .\venv\Scripts\Activate.ps1
   python main.py
   ```
   
   **Terminal 2 (Frontend):**
   ```powershell
   npm run dev
   ```

---

### ❌ Error: "Cannot connect to backend server"

**Cause:** Backend is not running on port 8000.

**Solution:**

1. **Start the backend:**
   ```powershell
   cd api
   .\venv\Scripts\Activate.ps1
   python main.py
   ```

2. **Check if port 8000 is in use:**
   ```powershell
   netstat -ano | findstr :8000
   ```

3. **If port is in use, kill the process:**
   ```powershell
   # Find the PID from netstat output, then:
   taskkill /PID <PID> /F
   ```

---

### ❌ Error: "Module not found" or Import errors

**Cause:** Dependencies not installed.

**Solution:**

1. **Reinstall frontend dependencies:**
   ```powershell
   npm install
   ```

2. **Reinstall backend dependencies:**
   ```powershell
   cd api
   .\venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   ```

---

### ❌ Error: "Port 3000 already in use"

**Cause:** Another process is using port 3000.

**Solution:**

1. **Find and kill the process:**
   ```powershell
   # Find the process
   netstat -ano | findstr :3000
   
   # Kill it (replace <PID> with actual PID)
   taskkill /PID <PID> /F
   ```

2. **Or use a different port:**
   ```powershell
   # Run on port 3001 instead
   npm run dev -- -p 3001
   ```

---

### ❌ Error: "CORS policy" errors

**Cause:** CORS not configured properly.

**Solution:**

1. **Check backend CORS settings in `api/main.py`:**
   ```python
   app.add_middleware(
       CORSMiddleware,
       allow_origins=["*"],  # Should allow all origins
       allow_credentials=True,
       allow_methods=["*"],
       allow_headers=["*"],
   )
   ```

2. **Restart backend after changes:**
   ```powershell
   cd api
   python main.py
   ```

---

### ❌ Error: "face_recognition" or "dlib" installation fails

**Cause:** Missing C++ build tools.

**Solution:**

1. **Install Visual C++ Build Tools:**
   - Download from: https://visualstudio.microsoft.com/visual-cpp-build-tools/
   - Install "Desktop development with C++"

2. **Install cmake:**
   ```powershell
   pip install cmake
   ```

3. **Retry installation:**
   ```powershell
   pip install dlib
   pip install face-recognition
   ```

4. **Alternative - Use mock mode:**
   The app works without these packages using mock predictions.

---

### ❌ Frontend shows blank page

**Cause:** Build error or JavaScript error.

**Solution:**

1. **Check browser console:**
   - Press F12
   - Look for errors in Console tab

2. **Rebuild the app:**
   ```powershell
   npm run build
   npm run dev
   ```

3. **Clear cache:**
   ```powershell
   # Delete .next folder
   Remove-Item -Recurse -Force .next
   npm run dev
   ```

---

### ❌ Video upload fails immediately

**Cause:** File validation or size limit.

**Solution:**

1. **Check file format:**
   - Supported: MP4, AVI, MOV, MKV, WebM
   - Max size: 100MB

2. **Try a smaller video:**
   - Use a video under 50MB
   - Try a different format

3. **Check backend logs:**
   - Look at the terminal running `python main.py`
   - Check for error messages

---

### ❌ Results not displaying

**Cause:** API response format issue.

**Solution:**

1. **Check backend response:**
   ```powershell
   # Test the API directly
   curl -X POST http://localhost:8000/api/predict/ `
     -F "upload_video_file=@test.mp4" `
     -F "sequence_length=40"
   ```

2. **Check browser console:**
   - Press F12
   - Look for errors

3. **Verify mock mode is working:**
   - Backend should show: "Warning: ML modules not available. Using mock predictions."

---

## 🔍 Diagnostic Commands

### Check if everything is running:

```powershell
# Check Node.js
node --version

# Check Python
python --version

# Check if backend is running
curl http://localhost:8000/health

# Check if frontend is running
curl http://localhost:3000

# Check ports in use
netstat -ano | findstr :3000
netstat -ano | findstr :8000
```

### View logs:

```powershell
# Backend logs are in the terminal running python main.py
# Frontend logs are in the terminal running npm run dev
# Browser logs: Press F12 → Console tab
```

---

## 🚀 Complete Reset

If nothing works, try a complete reset:

```powershell
# 1. Stop all servers (Ctrl+C in both terminals)

# 2. Delete generated files
Remove-Item -Recurse -Force .next
Remove-Item -Recurse -Force node_modules
Remove-Item -Recurse -Force api\venv

# 3. Reinstall everything
npm install
cd api
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
cd ..

# 4. Create environment files
Copy-Item .env.example .env.local
Copy-Item api\.env.example api\.env

# 5. Start servers
# Terminal 1:
cd api
.\venv\Scripts\Activate.ps1
python main.py

# Terminal 2:
npm run dev
```

---

## 📞 Still Having Issues?

### Before asking for help:

1. ✅ Read this troubleshooting guide
2. ✅ Check error messages carefully
3. ✅ Try the diagnostic commands
4. ✅ Attempt a complete reset

### When asking for help, provide:

- Error message (full text)
- What you were trying to do
- Steps you've already tried
- Output of diagnostic commands
- Screenshots if relevant

### Where to get help:

- Check GitHub Issues
- Review documentation
- Ask in discussions
- Contact support

---

## 💡 Pro Tips

1. **Always run backend first, then frontend**
2. **Keep both terminals open and visible**
3. **Check logs when errors occur**
4. **Use Ctrl+C to stop servers cleanly**
5. **Restart servers after code changes**
6. **Clear browser cache if UI looks broken**
7. **Use incognito mode to test without cache**

---

## ✅ Verification Checklist

Before reporting an issue, verify:

- [ ] Node.js is installed (`node --version`)
- [ ] Python is installed (`python --version`)
- [ ] Dependencies installed (`npm install` and `pip install`)
- [ ] Environment files exist (`.env.local` and `api/.env`)
- [ ] Backend is running (`http://localhost:8000/health`)
- [ ] Frontend is running (`http://localhost:3000`)
- [ ] No port conflicts (check with `netstat`)
- [ ] No firewall blocking ports
- [ ] Browser console shows no errors (F12)

---

**Most issues are solved by ensuring both servers are running! 🚀**
