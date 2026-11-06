@echo off
cd /d "%~dp0"
echo === South Block: setup and run ===
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter is not installed. Install it from https://docs.flutter.dev/get-started/install then run this file again.
  pause
  exit /b 1
)
if not exist web (
  echo Creating web and android folders...
  call flutter create . --platforms=web,android --project-name southblock_app
)
call flutter pub get
set /p EMAIL=Your email for the photo download (press Enter to skip photos): 
if not "%EMAIL%"=="" (
  where py >nul 2>nul
  if errorlevel 1 (
    python tools\fetch_commons_photos.py --contact %EMAIL% --embed
  ) else (
    py tools\fetch_commons_photos.py --contact %EMAIL% --embed
  )
)
call flutter run -d chrome
pause
