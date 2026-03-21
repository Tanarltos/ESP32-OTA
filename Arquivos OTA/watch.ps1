$arquivo = "C:\Users\Gemeos\Documents\Arduino\ESP32_TEMPLATE\ESP32_TEMPLATE\build\esp32.esp32.esp32doit-devkit-v1\ESP32_TEMPLATE.ino.bin"

Write-Host "Script iniciado em $(Get-Date)"
Write-Host "Monitorando: $arquivo"

# pega última modificação inicial
$ultimaMod = (Get-Item $arquivo).LastWriteTime

while ($true) {
    Start-Sleep 2

    $novaMod = (Get-Item $arquivo).LastWriteTime

    if ($novaMod -ne $ultimaMod) {

        Write-Host "Mudança detectada em $(Get-Date)"

        # espera terminar de escrever (muito importante)
        Start-Sleep 2

        Write-Host "Rodando deploy..."
        Start-Process "C:\esp32-ota\Arquivos OTA\deploy.bat"

        $ultimaMod = $novaMod
    }
}