#!/usr/bin/env pwsh
# Quick Start Script - Runs both frontend and backend

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Deepfake Detection System" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if .env.local exists
if (!(Test-Path ".env.local")) {
    Write-Host "[WARNING] .env.local not found. Creating it..." -ForegroundColor Yellow
    Copy-Item ".env.example" ".env.local"
    Write-Host "[OK] Created .env.local" -ForegroundColor Green
}

# Check if backend venv exists
if (!(Test-Path "api\venv")) {
    Write-Host "[ERROR] Backend virtual environment not found!" -ForegroundColor Red
    Write-Host "Please run setup first: .\setup.ps1" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "[INFO] Starting backend server..." -ForegroundColor Yellow
Write-Host ""

# Start backend in a new window
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD\api'; .\venv\Scripts\Activate.ps1; Write-Host 'Backend starting on http://localhost:8000' -ForegroundColor Green; python main.py"

Write-Host "[OK] Backend started in new window" -ForegroundColor Green
Write-Host ""

# Wait a bit for backend to start
Write-Host "[INFO] Waiting for backend to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

Write-Host "[INFO] Starting frontend server..." -ForegroundColor Yellow
Write-Host ""

# Start frontend in a new window
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; Write-Host 'Frontend starting on http://localhost:3000' -ForegroundColor Green; npm run dev"

Write-Host "[OK] Frontend started in new window" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Servers Started!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backend:  http://localhost:8000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "API Docs: http://localhost:8000/docs" -ForegroundColor Cyan
Write-Host ""
Write-Host "Opening browser..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Open browser
Start-Process "http://localhost:3000"

Write-Host ""
Write-Host "To stop servers: Close the PowerShell windows or press Ctrl+C" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
