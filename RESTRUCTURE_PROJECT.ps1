#!/usr/bin/env pwsh
# Restructure project for Railway + Vercel deployment

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "RESTRUCTURING PROJECT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create frontend directory structure
Write-Host "[1/5] Creating frontend directory..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "frontend" -Force | Out-Null
New-Item -ItemType Directory -Path "frontend/app" -Force | Out-Null
New-Item -ItemType Directory -Path "frontend/public" -Force | Out-Null

# Copy frontend files
Write-Host "[2/5] Moving frontend files..." -ForegroundColor Yellow

# Copy app directory
if (Test-Path "app") {
    Copy-Item -Path "app/*" -Destination "frontend/app/" -Recurse -Force
    Write-Host "  ✓ Copied app/" -ForegroundColor Green
}

# Copy public directory
if (Test-Path "public") {
    Copy-Item -Path "public/*" -Destination "frontend/public/" -Recurse -Force
    Write-Host "  ✓ Copied public/" -ForegroundColor Green
}

# Copy frontend config files
$frontendFiles = @(
    "package.json",
    "next.config.js",
    "tailwind.config.js",
    "postcss.config.js",
    "tsconfig.json",
    ".env.example",
    ".env.local"
)

foreach ($file in $frontendFiles) {
    if (Test-Path $file) {
        Copy-Item -Path $file -Destination "frontend/" -Force
        Write-Host "  ✓ Copied $file" -ForegroundColor Green
    }
}

# Create frontend vercel.json
Write-Host "[3/5] Creating frontend vercel.json..." -ForegroundColor Yellow
@"
{
  "version": 2,
  "framework": "nextjs",
  "buildCommand": "npm run build",
  "outputDirectory": ".next",
  "installCommand": "npm install"
}
"@ | Out-File -FilePath "frontend/vercel.json" -Encoding UTF8
Write-Host "  ✓ Created frontend/vercel.json" -ForegroundColor Green

# Verify backend structure
Write-Host "[4/5] Verifying backend structure..." -ForegroundColor Yellow

if (Test-Path "backend/main.py") {
    Write-Host "  ✓ backend/main.py exists" -ForegroundColor Green
} else {
    Write-Host "  ✗ backend/main.py missing!" -ForegroundColor Red
}

if (Test-Path "backend/requirements.txt") {
    Write-Host "  ✓ backend/requirements.txt exists" -ForegroundColor Green
} else {
    Write-Host "  ✗ backend/requirements.txt missing!" -ForegroundColor Red
}

if (Test-Path "backend/Dockerfile") {
    Write-Host "  ✓ backend/Dockerfile exists" -ForegroundColor Green
} else {
    Write-Host "  ✗ backend/Dockerfile missing!" -ForegroundColor Red
}

# Create README files
Write-Host "[5/5] Creating README files..." -ForegroundColor Yellow

@"
# Frontend - Next.js 14

Deploy this folder to Vercel.

## Deploy

1. Go to https://vercel.com/
2. Import this repository
3. Set root directory: \`frontend\`
4. Add environment variable:
   - \`NEXT_PUBLIC_API_URL\` = \`https://your-railway-url.railway.app\`
5. Deploy!

## Local Development

\`\`\`bash
npm install
npm run dev
\`\`\`

Open http://localhost:3000
"@ | Out-File -FilePath "frontend/README.md" -Encoding UTF8

Write-Host "  ✓ Created frontend/README.md" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "RESTRUCTURE COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Project Structure:" -ForegroundColor Yellow
Write-Host "  frontend/  → Deploy to Vercel" -ForegroundColor Cyan
Write-Host "  backend/   → Deploy to Railway" -ForegroundColor Cyan
Write-Host ""

Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Commit changes: git add . && git commit -m 'Restructure for deployment'" -ForegroundColor White
Write-Host "2. Push to GitHub: git push" -ForegroundColor White
Write-Host "3. Deploy backend to Railway (root: backend)" -ForegroundColor White
Write-Host "4. Deploy frontend to Vercel (root: frontend)" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to exit"
