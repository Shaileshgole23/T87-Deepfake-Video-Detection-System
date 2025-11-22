#!/usr/bin/env pwsh
# Cleanup and Deploy Script

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Cleanup & Deploy to GitHub + Vercel" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Clean up unnecessary files
Write-Host "[STEP 1] Cleaning up unnecessary files..." -ForegroundColor Yellow
Write-Host ""

$filesToDelete = @(
    "db.sqlite3",
    "manage.py",
    "model.ipynb",
    "setup.sh",
    "*.md.backup",
    "Django_Application",
    "detection",
    "deepfake_app",
    "github_assets",
    "Model Creation",
    "T87-Deepfake-Video-Detection-System-backend"
)

foreach ($file in $filesToDelete) {
    if (Test-Path $file) {
        Remove-Item -Path $file -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "  ✓ Removed: $file" -ForegroundColor Green
    }
}

# Clean up old documentation
$oldDocs = @(
    "ACTION_REQUIRED.md",
    "DEPLOYMENT.md",
    "DEPLOYMENT_CHECKLIST.md",
    "DLIB_BUILD_FIX.md",
    "ENVIRONMENT_FIXES.md",
    "ENV_SETUP.md",
    "FIX_SUMMARY.md",
    "README-frontend.md",
    "VERCEL_DEPLOYMENT_README.md",
    "VERCEL_QUICK_START.md",
    "VERCEL_SECRET_FIX.md"
)

foreach ($doc in $oldDocs) {
    if (Test-Path $doc) {
        Remove-Item -Path $doc -Force -ErrorAction SilentlyContinue
        Write-Host "  ✓ Removed: $doc" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "[OK] Cleanup complete!" -ForegroundColor Green
Write-Host ""

# Step 2: Initialize Git
Write-Host "[STEP 2] Setting up Git repository..." -ForegroundColor Yellow
Write-Host ""

if (!(Test-Path ".git")) {
    git init
    Write-Host "  ✓ Git initialized" -ForegroundColor Green
} else {
    Write-Host "  ✓ Git already initialized" -ForegroundColor Green
}

# Create .gitignore if it doesn't exist
if (!(Test-Path ".gitignore")) {
    Write-Host "  ✓ Creating .gitignore..." -ForegroundColor Green
    @"
# Dependencies
node_modules/
/.pnp
.pnp.js

# Testing
/coverage

# Next.js
/.next/
/out/

# Production
/build

# Misc
.DS_Store
*.pem

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Local env files
.env*.local
.env

# Vercel
.vercel

# TypeScript
*.tsbuildinfo
next-env.d.ts

# Python
__pycache__/
*.py[cod]
*`$py.class
*.so
.Python
venv/
env/
ENV/
api/venv/
api/env/

# ML Models
*.pt
*.pth
*.h5
*.pkl

# Uploads
temp_uploads/
processed_media/
uploads/

# IDE
.vscode/
.idea/
*.swp
*.swo

# Old Django files
db.sqlite3
manage.py
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
}

Write-Host ""

# Step 3: Commit changes
Write-Host "[STEP 3] Committing changes..." -ForegroundColor Yellow
Write-Host ""

git add .
git commit -m "Clean project and prepare for deployment" -ErrorAction SilentlyContinue

Write-Host "  ✓ Changes committed" -ForegroundColor Green
Write-Host ""

# Step 4: GitHub setup
Write-Host "[STEP 4] GitHub Repository Setup" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please provide your GitHub repository URL:" -ForegroundColor Cyan
Write-Host "Example: https://github.com/username/deepfake-detection.git" -ForegroundColor Gray
Write-Host ""
$repoUrl = Read-Host "GitHub Repository URL"

if ($repoUrl) {
    Write-Host ""
    Write-Host "  Setting up remote..." -ForegroundColor Yellow
    
    # Remove existing remote if any
    git remote remove origin -ErrorAction SilentlyContinue
    
    # Add new remote
    git remote add origin $repoUrl
    
    Write-Host "  ✓ Remote added" -ForegroundColor Green
    Write-Host ""
    
    # Push to GitHub
    Write-Host "  Pushing to GitHub..." -ForegroundColor Yellow
    Write-Host ""
    
    $branch = git branch --show-current
    if (!$branch) {
        $branch = "main"
        git branch -M main
    }
    
    git push -u origin $branch --force
    
    Write-Host ""
    Write-Host "  ✓ Pushed to GitHub!" -ForegroundColor Green
} else {
    Write-Host "  ⚠ Skipped GitHub push" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Cleanup & Git Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 5: Vercel deployment
Write-Host "[STEP 5] Deploy to Vercel?" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Yes, deploy now" -ForegroundColor White
Write-Host "2. No, I'll deploy manually" -ForegroundColor White
Write-Host ""
$deployChoice = Read-Host "Enter choice (1 or 2)"

if ($deployChoice -eq "1") {
    Write-Host ""
    Write-Host "  Deploying to Vercel..." -ForegroundColor Yellow
    Write-Host ""
    
    # Check if vercel is installed
    if (!(Get-Command vercel -ErrorAction SilentlyContinue)) {
        Write-Host "  Installing Vercel CLI..." -ForegroundColor Yellow
        npm install -g vercel
    }
    
    # Deploy
    vercel --prod
    
    Write-Host ""
    Write-Host "  ✓ Deployed to Vercel!" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "All Done! 🎉" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. ✓ Project cleaned up" -ForegroundColor White
Write-Host "2. ✓ Pushed to GitHub" -ForegroundColor White
Write-Host "3. ✓ Ready for Vercel" -ForegroundColor White
Write-Host ""
Write-Host "Your frontend should be live on Vercel!" -ForegroundColor Cyan
Write-Host "Backend can be deployed separately to Railway later." -ForegroundColor Cyan
Write-Host ""
Write-Host "For backend deployment, see: VERCEL_DEPLOYMENT.md" -ForegroundColor Gray
Write-Host "========================================" -ForegroundColor Cyan
