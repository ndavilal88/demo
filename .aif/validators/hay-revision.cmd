@echo off
REM Una fase de revision deja SU informe, y el informe declara sus limites.
setlocal enabledelayedexpansion
cd /d "%AIF_WORKSPACE%" || exit /b 3

set INFORME=
for /r "docs\revisiones" %%F in (*.md) do set INFORME=%%F
if not defined INFORME (
  echo No hay ningun informe en docs/revisiones/. Una fase de revision que no
  echo deja informe no ha revisado nada que nadie pueda leer.
  exit /b 1
)

set ULTIMO=
for /f "delims=" %%F in ('dir /b /o-d "docs\revisiones\*.md" 2^>nul') do (
  if not defined ULTIMO set ULTIMO=docs\revisiones\%%F
)

findstr /i /c:"NO he comprobado" "!ULTIMO!" >nul 2>&1
if errorlevel 1 (
  echo El informe !ULTIMO! no declara sus limites.
  echo Falta el apartado "Lo que NO he comprobado": una revision sin limites
  echo declarados se lee como si lo hubiera cubierto todo.
  exit /b 1
)
echo Informe presente y con sus limites declarados: !ULTIMO!
exit /b 0
