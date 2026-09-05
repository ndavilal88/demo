@echo off
REM El prototipo es HTML5 navegable y se abre con doble clic: un fichero real,
REM no una descripcion de un fichero.
setlocal enabledelayedexpansion
cd /d "%AIF_WORKSPACE%" || exit /b 3

set FALLOS=0

if not exist "prototipo\index.html" (
  echo Falta prototipo/index.html. Un prototipo que no se puede abrir no es un
  echo prototipo: es una descripcion de uno.
  set /a FALLOS+=1
) else (
  findstr /i /c:"<!doctype html" "prototipo\index.html" >nul 2>&1
  if errorlevel 1 (
    echo prototipo/index.html no es un documento HTML5 completo.
    set /a FALLOS+=1
  )
  powershell -NoProfile -Command ^
    "$t = Get-Content 'prototipo/index.html' -Raw;" ^
    "if ($t -match 'https?://(?!localhost)') { Write-Output 'El prototipo carga algo de la red: tiene que abrirse con doble clic y sin conexion.'; exit 1 }; exit 0"
  if errorlevel 1 set /a FALLOS+=1
)

if not exist "docs\02-prototipo\decisiones-ux.md" (
  echo Falta docs/02-prototipo/decisiones-ux.md: un prototipo sin las decisiones
  echo que lo explican no se puede revisar, solo opinar.
  set /a FALLOS+=1
)

if !FALLOS! GTR 0 exit /b 1
echo Prototipo HTML5 presente, autocontenido y con sus decisiones escritas.
exit /b 0
