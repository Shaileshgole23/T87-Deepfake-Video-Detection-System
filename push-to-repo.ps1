# PowerShell script to push to GitHub repository

Write-Host "🚀 Deepfake Detection System - Push to Repository" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git is not installed. Please install Git first." -ForegroundColor Red
    exit 1
}

# Show current status
Write-Host "📊 Current Git Status:" -ForegroundColor Yellow
git status --short
Write-Host ""

# Show current remotes
Write-Host "🔗 Current Remotes:" -ForegroundColor Yellow
git remote -v
Write-Host ""

# Ask user what they want to do
Write-Host "What would you like to do?" -ForegroundColor Green
Write-Host "1. Push to existing repository (Shaileshgole23/T87-Deepfake-Video-Detection-System)"
Write-Host "2. Push to a NEW repository"
Write-Host "3. Exit"
Write-Host ""

$choice = Read-Host "Enter your choice (1, 2, or 3)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "📤 Pushing to existing repository..." -ForegroundColor Cyan
        
        # Switch to main branch
        Write-Host "Switching to main branch..." -ForegroundColor Yellow
        git checkout -b main 2>$null
        if ($LASTEXITCODE -ne 0) {
            git checkout main
        }
        
        # Push to origin
        Write-Host "Pushing to origin/main..." -ForegroundColor Yellow
        git push origin main --force
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ Successfully pushed to repository!" -ForegroundColor Green
            Write-Host "🔗 Repository: https://github.com/Shaileshgole23/T87-Deepfake-Video-Detection-System" -ForegroundColor Cyan
        } else {
            Write-Host ""
            Write-Host "❌ Push failed. Please check your credentials and try again." -ForegroundColor Red
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "📝 Creating new repository..." -ForegroundColor Cyan
        Write-Host ""
        
        # Get new repository details
        $username = Read-Host "Enter your GitHub username"
        $reponame = Read-Host "Enter new repository name (e.g., deepfake-detection-system)"
        
        Write-Host ""
        Write-Host "⚠️  Before continuing, please:" -ForegroundColor Yellow
        Write-Host "1. Go to https://github.com/new" -ForegroundColor White
        Write-Host "2. Create a repository named: $reponame" -ForegroundColor White
        Write-Host "3. DO NOT initialize with README, .gitignore, or license" -ForegroundColor White
        Write-Host "4. Press Enter when done..." -ForegroundColor White
        Read-Host
        
        # Remove old remotes
        Write-Host "Removing old remotes..." -ForegroundColor Yellow
        git remote remove origin 2>$null
        git remote remove new-origin 2>$null
        
        # Add new remote
        $newRemoteUrl = "https://github.com/$username/$reponame.git"
        Write-Host "Adding new remote: $newRemoteUrl" -ForegroundColor Yellow
        git remote add origin $newRemoteUrl
        
        # Switch to main branch
        Write-Host "Switching to main branch..." -ForegroundColor Yellow
        git branch -M main
        
        # Push to new repository
        Write-Host "Pushing to new repository..." -ForegroundColor Yellow
        git push -u origin main --force
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ Successfully pushed to new repository!" -ForegroundColor Green
            Write-Host "🔗 Repository: https://github.com/$username/$reponame" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "📋 Next steps:" -ForegroundColor Yellow
            Write-Host "1. Visit your repository and verify files" -ForegroundColor White
            Write-Host "2. Add repository description and topics" -ForegroundColor White
            Write-Host "3. Enable GitHub Actions (if needed)" -ForegroundColor White
            Write-Host "4. Share with your team!" -ForegroundColor White
        } else {
            Write-Host ""
            Write-Host "❌ Push failed. Please check:" -ForegroundColor Red
            Write-Host "- Repository exists on GitHub" -ForegroundColor White
            Write-Host "- You have write access" -ForegroundColor White
            Write-Host "- Your credentials are correct" -ForegroundColor White
        }
    }
    
    "3" {
        Write-Host ""
        Write-Host "👋 Exiting..." -ForegroundColor Yellow
        exit 0
    }
    
    default {
        Write-Host ""
        Write-Host "❌ Invalid choice. Please run the script again." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "🎉 Done!" -ForegroundColor Green
