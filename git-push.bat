@echo off
chcp 65001 >nul
cd /d "%~dp0"
git add .
git commit -m "로컬 assets 폴더 및 최신 index.html 업데이트"
git push origin main
pause

