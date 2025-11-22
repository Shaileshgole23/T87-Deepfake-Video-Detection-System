#!/usr/bin/env pwsh
# Vercel Deployment Script

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Vercel Deployment Helper" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if vercel is installed
if (!(Get-Command vercel -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Vercel CLI not installed!" -ForegroundColor Red
    Write-Host "Installing Vercel CLI..." -ForegroundColor Yellow
    npm install -g vercel
}

Write-Host "[INFO] Vercel CLI is ready" -ForegroundColor Green
Write-Host ""

# Check if user is logged in
Write-Host "[STEP 1] Checking Vercel authentication..." -ForegroundColor Yellow
Write-Host ""
Write-Host "A browser window will open for authentication." -ForegroundColor Cyan
Write-Host "Please login and return here." -ForegroundColor Cyan
Write-Host ""
Read-Host "Press ENTER to continue"

vercel login

Write-Host ""
Write-Host "[STEP 2] Deploying to Vercel..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Choose deployment type:" -ForegroundColor Cyan
Write-Host "1. Preview deployment (test)" -ForegroundColor White
Write-Host "2. Production deployment" -ForegroundColor White
Write-Host ""
$choice = Read-Host "Enter choice (1 or 2)"

if ($choice -eq "2") {
    Write-Host ""
    Write-Host "[INFO] Deploying to PRODUCTION..." -ForegroundColor Yellow
    vercel --prod
} else {
    Write-Host ""
    Write-Host "[INFO] Deploying to PREVIEW..." -ForegroundColor Yellow
    vercel
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deployment Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Copy your Vercel URL from above" -ForegroundColor White
Write-Host "2. Deploy backend to Railway (see VERCEL_DEPLOYMENT.md)" -ForegroundColor White
Write-Host "3. Update NEXT_PUBLIC_API_URL in Vercel dashboard" -ForegroundColor White
Write-Host "4. Redeploy: vercel --prod" -ForegroundColor White
Write-Host ""
Write-Host "For detailed instructions, see: VERCEL_DEPLOYMENT.md" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
