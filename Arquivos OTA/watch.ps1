$path = "C:\Users\Gemeos\Documents\Arduino\ESP32_TEMPLATE\ESP32_TEMPLATE\build\esp32.esp32.esp32doit-devkit-v1"

$filter = "ESP32_TEMPLATE.ino.bin"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $path
$watcher.Filter = $filter
$watcher.EnableRaisingEvents = $true

$lastRun = Get-Date

$action = {
    $now = Get-Date
    if (($now - $lastRun).TotalSeconds -lt 5) {
        return
    }

    Write-Host "Novo firmware detectado! Fazendo deploy..."

    Start-Process "C:\esp32-ota\Arquivos OTA\deploy.bat"

    $script:lastRun = Get-Date
}

Register-ObjectEvent $watcher "Changed" -Action $action

Write-Host "Monitorando firmware..."
while ($true) { Start-Sleep 1 }