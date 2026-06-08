@echo off
echo =======================================
echo  Fitness Tracker - Build & Run Script
echo  Target: 78kg → 65-68kg by Aug 29
echo =======================================
echo.

:: Check if Flutter is available
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found in PATH!
    echo.
    echo Install Flutter from: https://docs.flutter.dev/get-started/install/windows
    echo After installing, add to PATH and run: flutter doctor
    pause
    exit /b 1
)

echo [1/4] Running flutter doctor...
flutter doctor --android-licenses 2>nul
echo.

echo [2/4] Getting dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to get dependencies!
    pause
    exit /b 1
)
echo.

echo [3/4] Building Windows app...
flutter build windows --release
if %errorlevel% neq 0 (
    echo [ERROR] Build failed!
    echo.
    echo Try these fixes:
    echo   1. Run: flutter doctor
    echo   2. Ensure Visual Studio 2022 with C++ workload is installed
    echo   3. Run: flutter config --enable-windows-desktop
    pause
    exit /b 1
)
echo.

echo [4/4] Launching app...
echo.
start "" "build\windows\x64\runner\Release\fitness_tracker.exe"

echo =======================================
echo  Build successful! App is running.
echo  
echo  Executable location:
echo  build\windows\x64\runner\Release\fitness_tracker.exe
echo =======================================
pause
