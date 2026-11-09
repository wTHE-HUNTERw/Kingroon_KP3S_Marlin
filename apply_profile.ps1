param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("stock_mbl", "bltouch_abl")]
    [string]$Profile = "stock_mbl"
)

$sourceDir = Join-Path $PSScriptRoot "config_kp3s\$Profile"
$targetDir = Join-Path $PSScriptRoot "Marlin"

if (-not (Test-Path $sourceDir)) {
    Write-Error "No se encontro el directorio del perfil: $sourceDir"
    exit 1
}

Copy-Item -Path (Join-Path $sourceDir "Configuration.h") -Destination $targetDir -Force
Copy-Item -Path (Join-Path $sourceDir "Configuration_adv.h") -Destination $targetDir -Force

Write-Host "==========================================================" -ForegroundColor Green
Write-Host " Perfil aplicado con exito: $Profile" -ForegroundColor Green
if ($Profile -eq "stock_mbl") {
    Write-Host " Modo: KP3S 3.0 Stock (Manual Mesh Bed Leveling 4x4, Sin BLTouch)" -ForegroundColor Yellow
} else {
    Write-Host " Modo: KP3S 3.0 con sensor BLTouch (Bilinear ABL 4x4 + Z Wizard)" -ForegroundColor Yellow
}
Write-Host "==========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Para compilar ejecuta:" -ForegroundColor Cyan
Write-Host "  & 'C:\Users\erick\.platformio\penv\Scripts\platformio.exe' run -e mks_robin_nano_v1v2" -ForegroundColor White
Write-Host ""
Write-Host "El archivo compilado se generara automaticamente en:" -ForegroundColor Cyan
Write-Host "  .pio\build\mks_robin_nano_v1v2\Robin_nano.bin" -ForegroundColor White
