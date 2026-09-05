@echo off
REM Trazabilidad en los DOS sentidos. La logica vive en el .ps1 de al lado.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0trazabilidad-ids.ps1"
exit /b %ERRORLEVEL%
