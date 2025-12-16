@echo off
chcp 65001 >nul
echo === 자동 커밋 및 푸시 시작 ===

REM Git 상태 확인
git status --porcelain >nul 2>&1
if errorlevel 1 (
    echo 변경된 파일이 없습니다.
    pause
    exit /b
)

echo.
echo 변경된 파일:
git status --short

echo.
echo 변경사항 스테이징 중...
git add .

REM 커밋 메시지 생성
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set mydate=%%c-%%a-%%b
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set mytime=%%a:%%b
set commitMessage=Update: %mydate% %mytime%

echo 커밋 중...
git commit -m "%commitMessage%"

if %errorlevel% equ 0 (
    echo 커밋 완료!
    echo.
    echo GitHub에 푸시 중...
    git push origin main
    
    if %errorlevel% equ 0 (
        echo.
        echo === 푸시 완료! ===
        echo 몇 분 후 사이트에 반영됩니다: https://monsterryotbiz-dot.github.io/monsterryot/
    ) else (
        echo 푸시 실패. 오류를 확인해주세요.
    )
) else (
    echo 커밋 실패. 오류를 확인해주세요.
)

pause

