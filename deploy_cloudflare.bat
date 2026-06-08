@echo off
echo =======================================
echo  Fitness Tracker - Deploy to Cloudflare Pages
echo =======================================
echo.

:: Step 1: Build Flutter web
echo [1/3] Building Flutter web (release)...
flutter build web --release --base-href /
if %errorlevel% neq 0 (
    echo [ERROR] Flutter web build failed!
    pause
    exit /b 1
)
echo.

:: Step 2: Check if wrangler is installed
where wrangler >nul 2>nul
if %errorlevel% neq 0 (
    echo [2/3] Installing Wrangler CLI (Cloudflare)...
    npm install -g wrangler
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to install wrangler. Make sure Node.js is installed.
        pause
        exit /b 1
    )
)
echo.

:: Step 3: Deploy
echo [3/3] Deploying to Cloudflare Pages...
echo.
wrangler pages deploy build/web --project-name=fitness-tracker
echo.
echo =======================================
echo  Deployment complete!
echo  Your app is live at: https://fitness-tracker.pages.dev
echo =======================================
pause
