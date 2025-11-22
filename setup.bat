@echo off
echo ========================================
echo Deepfake Detection System Setup
echo ========================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not installed!
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Check if Python is installed
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Python is not installed!
    echo Please install Python from https://www.python.org/
    pause
    exit /b 1
)

echo [1/6] Installing frontend dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to install frontend dependencies
    pause
    exit /b 1
)
echo [OK] Frontend dependencies installed
echo.

echo [2/6] Setting up environment files...
if not exist .env.local (
    copy .env.example .env.local
    echo [OK] Created .env.local
) else (
    echo [SKIP] .env.local already exists
)

if not exist api\.env (
    copy api\.env.example api\.env
    echo [OK] Created api\.env
) else (
    echo [SKIP] api\.env already exists
)
echo.

echo [3/6] Creating Python virtual environment...
cd api
if not exist venv (
    python -m venv venv
    echo [OK] Virtual environment created
) else (
    echo [SKIP] Virtual environment already exists
)
echo.

echo [4/6] Activating virtual environment...
call venv\Scripts\activate.bat
echo [OK] Virtual environment activated
echo.

echo [5/6] Installing backend dependencies...
echo This may take a few minutes...
python -m pip install --upgrade pip
pip install -r requirements.txt
if %ERRORLEVEL% NEQ 0 (
    echo [WARNING] Some packages may have failed to install
    echo You may need to install Visual C++ Build Tools
    echo Download from: https://visualstudio.microsoft.com/visual-cpp-build-tools/
)
echo [OK] Backend dependencies installed
echo.

echo [6/6] Creating necessary directories...
if not exist temp_uploads mkdir temp_uploads
if not exist processed_media mkdir processed_media
if not exist models mkdir models
cd ..
if not exist public mkdir public
echo [OK] Directories created
echo.

echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo To run the application:
echo.
echo Terminal 1 (Backend):
echo   cd api
echo   venv\Scripts\activate
echo   python main.py
echo.
echo Terminal 2 (Frontend):
echo   npm run dev
echo.
echo Then open: http://localhost:3000
echo.
echo For deployment instructions, see DEPLOYMENT_GUIDE.md
echo ========================================
pause
