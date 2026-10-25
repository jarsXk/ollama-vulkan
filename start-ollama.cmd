@echo off
setlocal

cd /d "%~dp0"

rem Store models folder
set "OLLAMA_MODELS=%USERPROFILE%\.ollama\models"

rem Listen address
set "OLLAMA_HOST=127.0.0.1:11434"

rem Context window size
set "OLLAMA_CONTEXT_LENGTH=8192"

rem Unload models after N minutes of inactivity
set "OLLAMA_KEEP_ALIVE=5m"

rem Запуск сервера Ollama в фоне
start "Ollama Vulkan" /min "%~dp0ollama.exe" serve

endlocal
