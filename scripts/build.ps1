Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DevOps2 Build Script by MukhanovT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""


Write-Host "1. Checking Java..." -ForegroundColor Yellow
try {
    java -version 2>&1 | Out-Null
    Write-Host "Java is installed" -ForegroundColor Green
} catch {
    Write-Host "Java is NOT installed" -ForegroundColor Red
    exit 1
}

Write-Host "`n2. Checking Maven..." -ForegroundColor Yellow
try {
    mvn --version 2>&1 | Out-Null
    Write-Host "Maven is installed" -ForegroundColor Green
} catch {
    Write-Host "Maven is NOT installed" -ForegroundColor Red
    exit 1
}


Write-Host "`n3. Building Spring Boot application..." -ForegroundColor Yellow
cd ..
mvn clean package -DskipTests
if ($LASTEXITCODE -eq 0) {
    Write-Host "Application built successfully" -ForegroundColor Green
} else {
    Write-Host "uild failed" -ForegroundColor Red
    exit 1
}


Write-Host "`n4. Building Docker image..." -ForegroundColor Yellow
docker build -f Dockerfile_Dockerfile_MukhanovT -t devops2-mukhanovt:1.0 .
if ($LASTEXITCODE -eq 0) {
    Write-Host "Docker image built successfully" -ForegroundColor Green
} else {
    Write-Host "Docker build failed" -ForegroundColor Red
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " Build completed successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "1. Run with Docker Compose:" -ForegroundColor Gray
Write-Host "   docker-compose -f docker-compose_MukhanovT.yml up -d" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Test the application:" -ForegroundColor Gray
Write-Host "   curl http://localhost:8080/devops2/api/health" -ForegroundColor Gray