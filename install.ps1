[CmdletBinding()]
param(
    [string]$Destination = (Join-Path $env:USERPROFILE ".codex\pets\zhu-pi-deng")
)

$ErrorActionPreference = "Stop"
$petId = "zhu-pi-deng"
$repoBase = "https://raw.githubusercontent.com/Loki-Tricks/zhu-pi-deng/main"
$temporary = Join-Path ([System.IO.Path]::GetTempPath()) ("zhu-pi-deng-" + [guid]::NewGuid().ToString("N"))

function Get-PetFiles {
    param([string]$OutputDirectory)

    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
    $localManifest = if ($PSScriptRoot) { Join-Path $PSScriptRoot "pet.json" } else { "" }
    $localSheet = if ($PSScriptRoot) { Join-Path $PSScriptRoot "spritesheet.webp" } else { "" }

    if ($localManifest -and (Test-Path -LiteralPath $localManifest) -and (Test-Path -LiteralPath $localSheet)) {
        Copy-Item -LiteralPath $localManifest -Destination (Join-Path $OutputDirectory "pet.json") -Force
        Copy-Item -LiteralPath $localSheet -Destination (Join-Path $OutputDirectory "spritesheet.webp") -Force
        return
    }

    Write-Host "正在从 GitHub 下载猪屁登..."
    Invoke-WebRequest -UseBasicParsing -Uri "$repoBase/pet.json" -OutFile (Join-Path $OutputDirectory "pet.json")
    Invoke-WebRequest -UseBasicParsing -Uri "$repoBase/spritesheet.webp" -OutFile (Join-Path $OutputDirectory "spritesheet.webp")
}

try {
    Get-PetFiles -OutputDirectory $temporary

    $manifestPath = Join-Path $temporary "pet.json"
    $sheetPath = Join-Path $temporary "spritesheet.webp"
    $manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json

    if ($manifest.id -ne $petId) {
        throw "pet.json 的 id 不正确。"
    }
    if ([int]$manifest.spriteVersionNumber -ne 2) {
        throw "猪屁登不是 Codex v2 宠物包。"
    }
    if ((Get-Item -LiteralPath $sheetPath).Length -lt 100000) {
        throw "spritesheet.webp 下载不完整。"
    }

    if (Test-Path -LiteralPath $destination) {
        $backup = "$destination.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Move-Item -LiteralPath $destination -Destination $backup
        Write-Host "旧版本已备份到：$backup"
    }

    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    Copy-Item -LiteralPath $manifestPath -Destination (Join-Path $destination "pet.json") -Force
    Copy-Item -LiteralPath $sheetPath -Destination (Join-Path $destination "spritesheet.webp") -Force

    $installedManifest = Get-Content -LiteralPath (Join-Path $destination "pet.json") -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($installedManifest.id -ne $petId -or [int]$installedManifest.spriteVersionNumber -ne 2) {
        throw "安装后的配置校验失败。"
    }

    Write-Host ""
    Write-Host "猪屁登安装成功！" -ForegroundColor Green
    Write-Host "安装位置：$destination"
    Write-Host "请重启 Codex，然后在宠物菜单中选择“猪屁登”。"
}
finally {
    if (Test-Path -LiteralPath $temporary) {
        Remove-Item -LiteralPath $temporary -Recurse -Force
    }
}
