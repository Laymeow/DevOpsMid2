Write-Host "========================================" -ForegroundColor Magenta
Write-Host "DevOps2 Deployment Script by MukhanovT" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

Write-Host "1. Stopping existing containers..." -ForegroundColor Yellow
docker-compose -f ..\docker-compose_MukhanovT.yml down 2>$null
Write-Host "Cleanup done" -ForegroundColor Green

Write-Host "`n2. Starting Docker Compose stack..." -ForegroundColor Yellow
docker-compose -f ..\docker-compose_MukhanovT.yml up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "Docker Compose failed" -ForegroundColor Red
    exit 1
}
Write-Host "Services started" -ForegroundColor Green

Write-Host "`n3. Waiting for services to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 15

Write-Host "`n4. Testing application..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/devops2/api/health" -Method Get -TimeoutSec 10
    Write-Host "Application is healthy: $($response.status)" -ForegroundColor Green
    
    Write-Host "`n5. Displaying application info:" -ForegroundColor Yellow
    $status = Invoke-RestMethod -Uri "http://localhost:8080/devops2/api/status" -Method Get
    Write-Host "Application: $($status.application)" -ForegroundColor White
    Write-Host "Version: $($status.version)" -ForegroundColor White
    Write-Host "Status: $($status.status)" -ForegroundColor White
    
} catch {
    Write-Host "Application health check failed" -ForegroundColor Red
    Write-Host "Checking logs..." -ForegroundColor Yellow
    docker-compose -f ..\docker-compose_MukhanovT.yml logs app
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "Deployment completed successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "Application URLs:" -ForegroundColor White
Write-Host "  - Health: http://localhost:8080/devops2/api/health" -ForegroundColor Gray
Write-Host "  - Status: http://localhost:8080/devops2/api/status" -ForegroundColor Gray
Write-Host "  - Tools: http://localhost:8080/devops2/api/tools" -ForegroundColor Gray
Write-Host "  - Hello: http://localhost:8080/devops2/api/hello/YourName" -ForegroundColor Gray
Write-Host ""
Write-Host "Database:" -ForegroundColor White
Write-Host "  - Host: localhost:5432" -ForegroundColor Gray
Write-Host "  - Database: devops2db" -ForegroundColor Gray
Write-Host "  - User: postgres" -ForegroundColor Gray
Write-Host "  - Password: postgres" -ForegroundColor Gray