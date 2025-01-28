# Parar a execução do script em caso de erro
$ErrorActionPreference = "Stop"

# Variáveis de Configuração
$imageName = "saulotarsobc/pg-bkp-restore"  # Nome da imagem (inclui o nome de usuário para Docker Hub)
$imageTag = "latest"                        # Tag da imagem
$dockerfilePath = "."                       # Caminho do Dockerfile (por padrão, o diretório atual)

# Construir a imagem Docker
Write-Host "Construindo a imagem Docker..." -ForegroundColor Cyan
docker build -t "${imageName}:${imageTag}" $dockerfilePath

if ($LASTEXITCODE -ne 0) {
    Write-Host "Erro ao construir a imagem Docker." -ForegroundColor Red
    exit 1
}

# Fazer o push da imagem para o Docker Hub
Write-Host "Enviando a imagem para o Docker Hub..." -ForegroundColor Cyan
docker push "${imageName}:${imageTag}"

if ($LASTEXITCODE -ne 0) {
    Write-Host "Erro ao enviar a imagem para o Docker Hub." -ForegroundColor Red
    exit 1
}

Write-Host "Imagem Docker construída e enviada com sucesso!" -ForegroundColor Green
