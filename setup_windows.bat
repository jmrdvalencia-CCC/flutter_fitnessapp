@echo off
echo =======================================
echo  Fitness Tracker - Windows Setup
echo =======================================
echo.
echo Prerequisites:
echo   1. Flutter SDK (3.0+)
echo   2. Visual Studio 2022 with "Desktop development with C++" workload
echo   3. Windows 10 SDK
echo.

:: Enable Windows desktop
echo Enabling Windows desktop support...
flutter config --enable-windows-desktop
echo.

:: Create the full Flutter project if needed
echo Creating full Flutter project structure...
flutter create --platforms=windows,ios . 2>nul
echo.

:: Get deps
echo Getting dependencies...
flutter pub get
echo.

echo =======================================
echo  Setup complete!
echo.
echo  To run the app:
echo    flutter run -d windows
echo.
echo  To build release:
echo    flutter build windows --release
echo.
echo  Executable will be at:
echo    build\windows\x64\runner\Release\fitness_tracker.exe
echo =======================================
pause
