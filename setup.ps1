#!/usr/bin/env pwsh
# Deepfake Detection System Setup Script for PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deepfake Detection System Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Node.js is installed
Write-Host "[Checking] Node.js..." -ForegroundColor Yellow
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Node.js is not installed!" -ForegroundColor Red
    Write-Host "Please install Node.js from https://nodejs.org/" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "[OK] Node.js is installed" -ForegroundColor Green
Write-Host ""

# Check if Python is installed
Write-Host "[Checking] Python..." -ForegroundColor Yellow
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Python is not installed!" -ForegroundColor Red
    Write-Host "Please install Python from https://www.python.org/" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "[OK] Python is installed" -ForegroundColor Green
Write-Host ""

# Install frontend dependencies
Write-Host "[1/6] Installing frontend dependencies..." -ForegroundColor Yellow
try {
    npm install
    if ($LASTEXITCODE -ne 0) { throw "npm install failed" }
    Write-Host "[OK] Frontend dependencies installed" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to install frontend dependencies" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Setup environment files
Write-Host "[2/6] Setting up environment files..." -ForegroundColor Yellow
if (!(Test-Path ".env.local")) {
    Copy-Item ".env.example" ".env.local"
    Write-Host "[OK] Created .env.local" -ForegroundColor Green
} else {
    Write-Host "[SKIP] .env.local already exists" -ForegroundColor Yellow
}

if (!(Test-Path "api\.env")) {
    Copy-Item "api\.env.example" "api\.env"
    Write-Host "[OK] Created api\.env" -ForegroundColor Green
} else {
    Write-Host "[SKIP] api\.env already exists" -ForegroundColor Yellow
}
Write-Host ""

# Create Python virtual environment
Write-Host "[3/6] Creating Python virtual environment..." -ForegroundColor Yellow
Set-Location api
if (!(Test-Path "venv")) {
    python -m venv venv
    Write-Host "[OK] Virtual environment created" -ForegroundColor Green
} else {
    Write-Host "[SKIP] Virtual environment already exists" -ForegroundColor Yellow
}
Write-Host ""

# Activate virtual environment and install dependencies
Write-Host "[4/6] Activating virtual environment..." -ForegroundColor Yellow
& ".\venv\Scripts\Activate.ps1"
Write-Host "[OK] Virtual environment activated" -ForegroundColor Green
Write-Host ""

Write-Host "[5/6] Installing backend dependencies..." -ForegroundColor Yellow
Write-Host "This may take a few minutes..." -ForegroundColor Yellow
try {
    python -m pip install --upgrade pip --quiet
    pip install -r requirements.txt
    Write-Host "[OK] Backend dependencies installed" -ForegroundColor Green
} catch {
    Write-Host "[WARNING] Some packages may have failed to install" -ForegroundColor Yellow
    Write-Host "You may need to install Visual C++ Build Tools" -ForegroundColor Yellow
    Write-Host "Download from: https://visualstudio.microsoft.com/visual-cpp-build-tools/" -ForegroundColor Yellow
}
Write-Host ""

# Create necessary directories
Write-Host "[6/6] Creating necessary directories..." -ForegroundColor Yellow
$directories = @("temp_uploads", "processed_media", "models")
foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}
Set-Location ..
if (!(Test-Path "public")) {
    New-Item -ItemType Directory -Path "public" | Out-Null
}
Write-Host "[OK] Directories created" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To run the application:" -ForegroundColor White
Write-Host ""
Write-Host "Terminal 1 (Backend):" -ForegroundColor Yellow
Write-Host "  cd api" -ForegroundColor White
Write-Host "  .\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host "  python main.py" -ForegroundColor White
Write-Host ""
Write-Host "Terminal 2 (Frontend):" -ForegroundColor Yellow
Write-Host "  npm run dev" -ForegroundColor White
Write-Host ""
Write-Host "Then open: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""
Write-Host "For deployment instructions, see DEPLOYMENT_GUIDE.md" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to exit"
