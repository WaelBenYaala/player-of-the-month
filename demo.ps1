Write-Host "1. Verification de l'etat Git et de la branche..." -ForegroundColor Cyan
$branch = "demo-$(Get-Date -UFormat %s)"
git status -s

Write-Host "2. Creation et push de la branche de demonstration ($branch)..." -ForegroundColor Cyan
git checkout -b $branch
git push -u origin $branch

Write-Host "3. Verification du endpoint /health..." -ForegroundColor Cyan
curl http://localhost:3000/health

Write-Host "4. Ouvrir une Pull Request sur GitHub :" -ForegroundColor Green
Write-Host "https://github.com/WaelBenYaala/player-of-the-month/compare/$branch?expand=1"
Write-Host "5. Suivre le pipeline et la supervision :" -ForegroundColor Green
Write-Host "Actions : https://github.com/WaelBenYaala/player-of-the-month/actions"
Write-Host "Uptime Kuma : http://localhost:3001/dashboard/1"