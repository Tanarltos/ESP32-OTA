@echo off

echo ========= DEPLOY OTA =========
timeout /t 2 >nul

REM === CAMINHO DO BIN ===
set BIN_PATH=C:\Users\Gemeos\Documents\Arduino\ESP32_TEMPLATE\ESP32_TEMPLATE\build\esp32.esp32.esp32doit-devkit-v1\ESP32_TEMPLATE.ino.bin

REM === CAMINHO DO REPO ===
set REPO=C:\esp32-ota

REM === COPIAR FIRMWARE ===
echo Copiando firmware...
copy "%BIN_PATH%" "%REPO%\firmware.bin" /Y

REM === GERAR VERSAO AUTOMATICA ===
for /f %%i in ('powershell -command "Get-Date -Format yyyyMMddHHmmss"') do set VERSAO=%%i
echo %VERSAO% > "%REPO%\version.txt"

REM === SUBIR PARA GITHUB ===
cd /d "%REPO%"
git add .
git commit -m "OTA update %VERSAO%"
git pull --rebase
git push

echo ========= FINALIZADO =========
pause