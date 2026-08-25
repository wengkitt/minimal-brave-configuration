#Requires -RunAsAdministrator
$ErrorActionPreference = 'Stop'

$RegistryPath = 'HKLM:\SOFTWARE\Policies\BraveSoftware\Brave'
$BackupDir = Join-Path $env:ProgramData 'MinimalBraveConfiguration'
$BackupFile = Join-Path $BackupDir 'preinstall.json'
$LegacyBackupFile = Join-Path $env:ProgramData 'BraveOriginLikeConfig\preinstall.json'
$Policies = [ordered]@{
    TorDisabled = 1
    BraveRewardsDisabled = 1
    BraveWalletDisabled = 1
    BraveVPNDisabled = 1
    BraveAIChatEnabled = 0
    BraveNewsDisabled = 1
    BraveTalkDisabled = 1
    BraveSpeedreaderEnabled = 0
    BraveWaybackMachineEnabled = 0
    BraveP3AEnabled = 0
    BraveStatsPingEnabled = 0
    BraveWebDiscoveryEnabled = 0
    BravePlaylistEnabled = 0
    MetricsReportingEnabled = 0
}

New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
New-Item -Path $RegistryPath -Force | Out-Null

if ((Test-Path $LegacyBackupFile) -and -not (Test-Path $BackupFile)) {
    Copy-Item $LegacyBackupFile $BackupFile
}
if (-not (Test-Path $BackupFile)) {
    $existing = [ordered]@{}
    foreach ($name in $Policies.Keys) {
        $value = Get-ItemPropertyValue -Path $RegistryPath -Name $name -ErrorAction SilentlyContinue
        if ($null -ne $value) { $existing[$name] = [int]$value }
    }
    $existing | ConvertTo-Json | Set-Content -Path $BackupFile -Encoding UTF8
}

foreach ($entry in $Policies.GetEnumerator()) {
    New-ItemProperty -Path $RegistryPath -Name $entry.Key -Value $entry.Value -PropertyType DWord -Force | Out-Null
}

Write-Host 'Policies installed. Fully quit and relaunch Brave, then reload brave://policy.'
