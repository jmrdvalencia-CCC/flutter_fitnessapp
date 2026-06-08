@echo off
echo =======================================
echo  Fitness Tracker - Web Build & Serve
echo =======================================
echo.

where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found in PATH!
    pause
    exit /b 1
)

echo [1/3] Getting dependencies...
flutter pub get
echo.

echo [2/3] Building for web...
flutter build web --release
if %errorlevel% neq 0 (
    echo [ERROR] Web build failed!
    echo.
    echo Try: flutter config --enable-web
    pause
    exit /b 1
)
echo.

echo [3/3] Build complete!
echo.
echo =======================================
echo  Web build output: build\web\
echo.
echo  To serve locally:
echo    cd build\web
echo    python -m http.server 8080
echo    Then open: http://localhost:8080
echo.
echo  To deploy (options):
echo    - Firebase Hosting: firebase deploy
echo    - GitHub Pages: copy build\web to repo
echo    - Netlify: drag build\web folder
echo    - Vercel: vercel build\web
echo =======================================
echo.

set /p serve="Start local server now? (y/n): "
if /i "%serve%"=="y" (
    echo.
    echo Starting server at http://localhost:8080 ...
    echo Press Ctrl+C to stop.
    cd build\web
    python -m http.server 8080
)
pause
