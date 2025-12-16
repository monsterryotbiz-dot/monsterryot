# 자동 커밋 및 푸시 스크립트
# 사용법: PowerShell에서 .\auto-commit.ps1 실행

Write-Host "=== 자동 커밋 및 푸시 시작 ===" -ForegroundColor Green

# Git 상태 확인
$gitStatus = git status --porcelain
if (-not $gitStatus) {
    Write-Host "변경된 파일이 없습니다." -ForegroundColor Yellow
    exit
}

# 변경된 파일 표시
Write-Host "`n변경된 파일:" -ForegroundColor Cyan
git status --short

# 모든 변경사항 스테이징
Write-Host "`n변경사항 스테이징 중..." -ForegroundColor Yellow
git add .

# 커밋 메시지 생성 (현재 시간 포함)
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMessage = "Update: $timestamp"

# 커밋 실행
Write-Host "커밋 중..." -ForegroundColor Yellow
git commit -m $commitMessage

if ($LASTEXITCODE -eq 0) {
    Write-Host "커밋 완료!" -ForegroundColor Green
    
    # 푸시 실행
    Write-Host "GitHub에 푸시 중..." -ForegroundColor Yellow
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n=== 푸시 완료! ===" -ForegroundColor Green
        Write-Host "몇 분 후 사이트에 반영됩니다: https://monsterryotbiz-dot.github.io/monsterryot/" -ForegroundColor Cyan
    } else {
        Write-Host "푸시 실패. 오류를 확인해주세요." -ForegroundColor Red
    }
} else {
    Write-Host "커밋 실패. 오류를 확인해주세요." -ForegroundColor Red
}

