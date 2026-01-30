# Otimização Gamer Completa para Windows 10/11/12
# Autor: gameegasm-collab
# Última atualização: 2026-01

Write-Host "🎮 Iniciando otimização do sistema para jogos..." -ForegroundColor Cyan

# Criar ponto de restauração
Write-Host "🛡️ Criando ponto de restauração..."
Checkpoint-Computer -Description "Pré-Otimização Gamer" -RestorePointType "MODIFY_SETTINGS" | Out-Null

# Ativar plano de energia de alto desempenho
Write-Host "⚡ Ativando plano de energia de alto desempenho..."
powercfg -duplicatescheme SCHEME_MAX

# Limpeza de arquivos temporários
Write-Host "🧹 Limpando arquivos temporários..."
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue

# Otimizar disco (SSD ou HDD)
Write-Host "💽 Otimizando discos..."
Optimize-Volume -DriveLetter C -ReTrim -Verbose -ErrorAction SilentlyContinue

# Desinstalar bloatware
Write-Host "🗑️ Removendo aplicativos inúteis..."
Get-AppxPackage *xbox* | Remove-AppxPackage
Get-AppxPackage *zune* | Remove-AppxPackage
Get-AppxPackage *people* | Remove-AppxPackage
Get-AppxPackage *bing* | Remove-AppxPackage
Get-AppxPackage *solitaire* | Remove-AppxPackage
Get-AppxPackage *clipchamp* | Remove-AppxPackage
Get-AppxPackage *cortana* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage
Get-AppxPackage *3d* | Remove-AppxPackage

# Remover OneDrive
Write-Host "📦 Removendo OneDrive..."
taskkill /f /im OneDrive.exe >$null 2>&1
Start-Sleep -Seconds 2
if (Test-Path "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe") {
  & "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe" /uninstall
} elseif (Test-Path "$env:SYSTEMROOT\System32\OneDriveSetup.exe") {
  & "$env:SYSTEMROOT\System32\OneDriveSetup.exe" /uninstall
}

# Desativar GameDVR e gravação em segundo plano
Write-Host "🎥 Desativando GameDVR..."
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >$null
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >$null

# Instalar apps com winget
Write-Host "📦 Instalando aplicativos essenciais para streaming e jogos..."
$apps = @(
    "Valve.Steam",
    "Discord.Discord",
    "OBSProject.OBSStudio",
    "Google.Chrome",
    "7zip.7zip",
    "VideoLAN.VLC",
    "RARLab.WinRAR",
    "RetroArch.RetroArch",
    "DuckStation.DuckStation",
    "PCSX2.PCSX2",
    "RPCS3.RPCS3",
    "Snes9xTeam.Snes9x",
    "mgba-emu.mGBA"
)

foreach ($app in $apps) {
    winget install --id $app -e --silent --accept-package-agreements --accept-source-agreements
}

# Criar pastas de ROMs
Write-Host "📁 Criando pastas para ROMs..."
$romDirs = @(
    "C:\ROMs\SNES",
    "C:\ROMs\PS1",
    "C:\ROMs\PS2",
    "C:\ROMs\PS3",
    "C:\ROMs\N64",
    "C:\ROMs\GBA",
    "C:\ROMs\GB",
    "C:\ROMs\GBC"
)
foreach ($dir in $romDirs) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

Write-Host "✅ Otimização concluída! Reinicie o sistema para aplicar todas as mudanças." -ForegroundColor Green
