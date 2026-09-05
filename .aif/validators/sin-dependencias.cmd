@echo off
REM Constrain 1 de OBJETIVO.md: cero dependencias, solo la stdlib de Node.
REM La logica vive en el .ps1 de al lado: AIF copia el catalogo ENTERO, asi que
REM un validator puede apoyarse en ficheros vecinos.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0sin-dependencias.ps1"
exit /b %ERRORLEVEL%
