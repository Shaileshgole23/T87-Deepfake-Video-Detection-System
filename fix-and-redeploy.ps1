#!/usr/bin/env pwsh
# Fix GitHub repository and redeploy

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Fix Repository & Redeploy" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[STEP 1] Removing old nested folder..." -ForegroundColor Yellow
Write-Host ""

# Remove the problematic nested folder
if (Test-Path "T87-Deepfake-Video-Detection-System-backend") {
    Remove-Item -Path "T87-Deepfake-Video-Detection-System-backend" -Recurse -Force
    Write-Host "  ✓ Removed nested folder" -ForegroundColor Green
} else {
    Write-Host "  ✓ Folder already removed" -ForegroundColor Green
}

Write-Host ""
Write-Host "[STEP 2] Committing changes..." -ForegroundColor Yellow
Write-Host ""

git add .
git commit -m "Remove nested folder and fix deployment"

Write-Host "  ✓ Changes committed" -ForegroundColor Green
Write-Host ""

Write-Host "[STEP 3] Pushing to GitHub..." -ForegroundColor Yellow
Write-Host ""

git push --force

Write-Host "  ✓ Pushed to GitHub" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Repository Fixed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Now Vercel will automatically redeploy." -ForegroundColor Cyan
Write-Host "Check your Vercel dashboard in 2-3 minutes." -ForegroundColor Cyan
Write-Host ""
Write-Host "Or manually trigger redeploy:" -ForegroundColor Yellow
Write-Host "1. Go to https://vercel.com/dashboard" -ForegroundColor White
Write-Host "2. Select your project" -ForegroundColor White
Write-Host "3. Go to Deployments" -ForegroundColor White
Write-Host "4. Click '...' → 'Redeploy'" -ForegroundColor White
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
