@echo off
setlocal enabledelayedexpansion

echo Building Flutter web...
flutter build web --base-href /b-medix/ --release

echo Preparing deployment folder...
if exist web-release (
    rmdir /s /q web-release
)
mkdir web-release
xcopy /s /e /y build\web web-release

cd web-release

echo Initializing git...
git init
git remote add origin https://github.com/Snake-B/b-medix.git
git checkout -b main

echo Committing build...
git add .
git commit -m "Deploy Flutter Web"
git push -f origin main

cd ..
rmdir /s /q web-release

echo Done! Your site should be live on GitHub Pages.
pause
