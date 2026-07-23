[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$destination = Join-Path $env:USERPROFILE ".codex\pets\zhu-pi-deng"

if (-not (Test-Path -LiteralPath $destination)) {
    Write-Host "猪屁登尚未安装。"
    exit 0
}

$removed = "$destination.removed-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Move-Item -LiteralPath $destination -Destination $removed
Write-Host "猪屁登已从 Codex 移除。" -ForegroundColor Green
Write-Host "文件已保留在：$removed"
Write-Host "重启 Codex 后生效。"
