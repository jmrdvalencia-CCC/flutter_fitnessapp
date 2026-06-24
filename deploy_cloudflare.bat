@echo off
echo =======================================
echo  Fitness Tracker - Deploy to Cloudflare Pages
echo =======================================
echo.

:: Step 1: Build Flutter web (no service worker to avoid Cloudflare caching issues)
echo [1/4] Building Flutter web (release, no service worker)...
flutter build web --release --base-href / --pwa-strategy none
if %errorlevel% neq 0 (
    echo [ERROR] Flutter web build failed!
    pause
    exit /b 1
)
echo.

:: Step 2: Remove service worker references from bootstrap
echo [2/4] Patching for Cloudflare (removing service worker)...
powershell -command "(Get-Content 'build\web\flutter_bootstrap.js' -Raw) -replace 'serviceWorkerSettings:\s*\{[^}]*\}', '' | Set-Content 'build\web\flutter_bootstrap.js' -NoNewline"
if exist build\web\flutter_service_worker.js del build\web\flutter_service_worker.js
echo.

:: Step 3: Check if wrangler is installed
where wrangler >nul 2>nul
if %errorlevel% neq 0 (
    echo [3/4] Installing Wrangler CLI (Cloudflare)...
    npm install -g wrangler
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to install wrangler. Make sure Node.js is installed.
        pause
        exit /b 1
    )
)
echo.

:: Step 4: Deploy
echo [4/4] Deploying to Cloudflare Pages...
echo.
wrangler pages deploy build/web --project-name=fitness-tracker
echo.
echo =======================================
echo  Deployment complete!
echo  Your app is live at: https://fitness-tracker.pages.dev
echo =======================================
pause
