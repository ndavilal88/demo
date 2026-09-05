@echo off
REM Ningun enlace relativo de docs/ apunta a un fichero que no existe.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0enlaces-vivos.ps1"
exit /b %ERRORLEVEL%
