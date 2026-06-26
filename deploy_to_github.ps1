# deploy_to_github.ps1 - Veggie Recipe Book GitHub Pages deploy

$ErrorActionPreference = "Stop"
$REPO_DIR  = "C:\Users\crepe\Documents\yasuda_short\recipe_app"
$REPO_NAME = "veggie-recipes"
$GH_USER   = "crepello88-png"

Set-Location $REPO_DIR

Write-Host "=== Veggie Recipe Book deploy ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path ".git")) {
    Write-Host "[1/5] git init" -ForegroundColor Yellow
    git init
    git branch -M main
} else {
    Write-Host "[1/5] git already initialized" -ForegroundColor Green
}

@"
.DS_Store
Thumbs.db
desktop.ini
.vscode/
.idea/
*.swp
"@ | Out-File -FilePath ".gitignore" -Encoding utf8 -NoNewline
Write-Host "[2/5] .gitignore written" -ForegroundColor Green

@"
# Veggie Recipe Book

PWA for managing recipes with vegetable tags.

URL: https://$GH_USER.github.io/$REPO_NAME/

## Usage
- Tap + to add a new recipe
- Auto-tag from ingredients
- Tap a tag to filter
- Search across title / ingredients / steps
- Top buttons export / import JSON

## Features
- Title / ingredients / steps
- Photo upload (auto-resize)
- Cook time + difficulty
- 100+ vegetable auto-tag dictionary
- LocalStorage persistence
- PWA offline support
- JSON backup
"@ | Out-File -FilePath "README.md" -Encoding utf8 -NoNewline
Write-Host "[3/5] README.md written" -ForegroundColor Green

git add .
$pending = git status --porcelain
if (-not $pending) {
    Write-Host "[4/5] no changes to commit" -ForegroundColor Yellow
} else {
    git commit -m "deploy: veggie recipe book"
    Write-Host "[4/5] committed" -ForegroundColor Green
}

$remote = git remote 2>$null
if (-not $remote) {
    Write-Host ""
    Write-Host "------------------------------------------" -ForegroundColor Cyan
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Create empty public repo on GitHub:" -ForegroundColor White
    Write-Host "   https://github.com/new" -ForegroundColor Cyan
    Write-Host "   Repo name: $REPO_NAME" -ForegroundColor Cyan
    Write-Host "   Public, no README, no gitignore" -ForegroundColor White
    Write-Host ""
    Write-Host "2. Then run:" -ForegroundColor White
    Write-Host "   git remote add origin https://github.com/$GH_USER/$REPO_NAME.git" -ForegroundColor Cyan
    Write-Host "   git push -u origin main" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "3. Enable Pages at:" -ForegroundColor White
    Write-Host "   https://github.com/$GH_USER/$REPO_NAME/settings/pages" -ForegroundColor Cyan
    Write-Host "   Source: Deploy from a branch" -ForegroundColor White
    Write-Host "   Branch: main / (root)" -ForegroundColor White
    Write-Host ""
    Write-Host "4. Access URL after a few minutes:" -ForegroundColor White
    Write-Host "   https://$GH_USER.github.io/$REPO_NAME/" -ForegroundColor Green
    Write-Host "------------------------------------------" -ForegroundColor Cyan
} else {
    Write-Host "[5/5] pushing to remote..." -ForegroundColor Yellow
    git push origin main
    Write-Host ""
    Write-Host "------------------------------------------" -ForegroundColor Cyan
    Write-Host "  Deploy complete!" -ForegroundColor Green
    Write-Host "  URL (available in a few minutes):" -ForegroundColor White
    Write-Host "  https://$GH_USER.github.io/$REPO_NAME/" -ForegroundColor Cyan
    Write-Host "------------------------------------------" -ForegroundColor Cyan
}
