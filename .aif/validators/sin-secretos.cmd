@echo off
REM Ningun secreto en literales. Barre codigo y documentacion.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0sin-secretos.ps1"
exit /b %ERRORLEVEL%
