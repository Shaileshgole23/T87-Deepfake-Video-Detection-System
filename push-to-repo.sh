#!/bin/bash

# Bash script to push to GitHub repository

echo "🚀 Deepfake Detection System - Push to Repository"
echo "================================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

# Show current status
echo "📊 Current Git Status:"
git status --short
echo ""

# Show current remotes
echo "🔗 Current Remotes:"
git remote -v
echo ""

# Ask user what they want to do
echo "What would you like to do?"
echo "1. Push to existing repository (Shaileshgole23/T87-Deepfake-Video-Detection-System)"
echo "2. Push to a NEW repository"
echo "3. Exit"
echo ""

read -p "Enter your choice (1, 2, or 3): " choice

case $choice in
    1)
        echo ""
        echo "📤 Pushing to existing repository..."
        
        # Switch to main branch
        echo "Switching to main branch..."
        git checkout -b main 2>/dev/null || git checkout main
        
        # Push to origin
        echo "Pushing to origin/main..."
        git push origin main --force
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ Successfully pushed to repository!"
            echo "🔗 Repository: https://github.com/Shaileshgole23/T87-Deepfake-Video-Detection-System"
        else
            echo ""
            echo "❌ Push failed. Please check your credentials and try again."
        fi
        ;;
    
    2)
        echo ""
        echo "📝 Creating new repository..."
        echo ""
        
        # Get new repository details
        read -p "Enter your GitHub username: " username
        read -p "Enter new repository name (e.g., deepfake-detection-system): " reponame
        
        echo ""
        echo "⚠️  Before continuing, please:"
        echo "1. Go to https://github.com/new"
        echo "2. Create a repository named: $reponame"
        echo "3. DO NOT initialize with README, .gitignore, or license"
        read -p "4. Press Enter when done..."
        
        # Remove old remotes
        echo "Removing old remotes..."
        git remote remove origin 2>/dev/null
        git remote remove new-origin 2>/dev/null
        
        # Add new remote
        newRemoteUrl="https://github.com/$username/$reponame.git"
        echo "Adding new remote: $newRemoteUrl"
        git remote add origin $newRemoteUrl
        
        # Switch to main branch
        echo "Switching to main branch..."
        git branch -M main
        
        # Push to new repository
        echo "Pushing to new repository..."
        git push -u origin main --force
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ Successfully pushed to new repository!"
            echo "🔗 Repository: https://github.com/$username/$reponame"
            echo ""
            echo "📋 Next steps:"
            echo "1. Visit your repository and verify files"
            echo "2. Add repository description and topics"
            echo "3. Enable GitHub Actions (if needed)"
            echo "4. Share with your team!"
        else
            echo ""
            echo "❌ Push failed. Please check:"
            echo "- Repository exists on GitHub"
            echo "- You have write access"
            echo "- Your credentials are correct"
        fi
        ;;
    
    3)
        echo ""
        echo "👋 Exiting..."
        exit 0
        ;;
    
    *)
        echo ""
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🎉 Done!"
