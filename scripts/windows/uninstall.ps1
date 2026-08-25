#Requires -RunAsAdministrator
$ErrorActionPreference = 'Stop'

$RegistryPath = 'HKLM:\SOFTWARE\Policies\BraveSoftware\Brave'
$BackupFile = Join-Path $env:ProgramData 'BraveOriginLikeConfig\preinstall.json'
$PolicyNames = @(
    'TorDisabled', 'BraveRewardsDisabled', 'BraveWalletDisabled', 'BraveVPNDisabled',
    'BraveAIChatEnabled', 'BraveNewsDisabled', 'BraveTalkDisabled',
    'BraveSpeedreaderEnabled', 'BraveWaybackMachineEnabled', 'BraveP3AEnabled',
    'BraveStatsPingEnabled', 'BraveWebDiscoveryEnabled', 'BravePlaylistEnabled',
    'MetricsReportingEnabled'
)

if (Test-Path $RegistryPath) {
    foreach ($name in $PolicyNames) {
        Remove-ItemProperty -Path $RegistryPath -Name $name -ErrorAction SilentlyContinue
    }
    if (Test-Path $BackupFile) {
        $backup = Get-Content -Raw $BackupFile | ConvertFrom-Json
        foreach ($property in $backup.PSObject.Properties) {
            New-ItemProperty -Path $RegistryPath -Name $property.Name -Value ([int]$property.Value) -PropertyType DWord -Force | Out-Null
        }
        Remove-Item $BackupFile -Force
    }
}

Write-Host 'Project policies removed and prior values restored. Restart Brave and reload brave://policy.'
