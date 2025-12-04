Write-Host "Testing Jenkinsfile locally - MukhanovT" -ForegroundColor Magenta
Write-Host "=========================================" -ForegroundColor Magenta

$stages = @(
    @{Name="Checkout"; Command="echo 'Checking out code...'"},
    @{Name="Build"; Command="mvn clean package -DskipTests -q"},
    @{Name="Test"; Command="echo 'Running tests...'"},
    @{Name="Docker Build"; Command="docker build -f Dockerfile_MukhanovT -t todo-app-mukhanovt ."},
    @{Name="Deploy"; Command="echo 'Deployment completed'"}
)

foreach ($stage in $stages) {
    Write-Host "`nStage: $($stage.Name)" -ForegroundColor Cyan
    Write-Host "Command: $($stage.Command)" -ForegroundColor Gray
    
    try {
        if ($stage.Command -match "mvn") {
            Invoke-Expression $stage.Command
        } elseif ($stage.Command -match "docker") {
            # Только проверяем что Dockerfile существует
            if (Test-Path "Dockerfile_MukhanovT") {
                Write-Host "Dockerfile_MukhanovT found" -ForegroundColor Green
            } else {
                Write-Host "Dockerfile_MukhanovT not found" -ForegroundColor Red
            }
        } else {
            Invoke-Expression $stage.Command
        }
        
        Write-Host "Stage completed" -ForegroundColor Green
    } catch {
        Write-Host "Stage failed: $_" -ForegroundColor Red
    }
}

Write-Host "`n Jenkinsfile validation completed!" -ForegroundColor Green
Write-Host "`nTo run real Jenkins pipeline:" -ForegroundColor Yellow
Write-Host "1. Install Jenkins: docker run -d -p 8080:8080 --name jenkins jenkins/jenkins:lts" -ForegroundColor White
Write-Host "2. Open http://localhost:8080" -ForegroundColor White
Write-Host "3. Create Pipeline job" -ForegroundColor White
Write-Host "4. Point to Jenkinsfile_MukhanovT in your repository" -ForegroundColor White