@echo off
REM El modelo de amenazas existe, nombra su frontera de confianza, tiene SEC- y
REM dice lo que NO mitiga.
setlocal enabledelayedexpansion
cd /d "%AIF_WORKSPACE%" || exit /b 3

set M=docs\03-seguridad\modelo-de-amenazas.md
if not exist "%M%" (
  echo Falta %M%.
  exit /b 1
)

set FALLOS=0
findstr /i /c:"frontera de confianza" "%M%" >nul 2>&1
if errorlevel 1 (
  echo No nombra la FRONTERA DE CONFIANZA. Sin decir quien esta dentro y quien
  echo fuera, "seguro" no significa nada.
  set /a FALLOS+=1
)
findstr /r /c:"SEC-[0-9]" "%M%" >nul 2>&1
if errorlevel 1 (
  echo No hay ninguna mitigacion identificada como SEC-n. Sin identificador no
  echo se puede trazar despues hasta el codigo.
  set /a FALLOS+=1
)
findstr /i /c:"NO se mitiga" "%M%" >nul 2>&1
if errorlevel 1 (
  echo Falta el apartado "Lo que NO se mitiga y por que". Un riesgo aceptado y
  echo escrito es una decision; uno no mencionado es un descuido.
  set /a FALLOS+=1
)
if !FALLOS! GTR 0 exit /b 1
echo Modelo de amenazas completo: frontera, SEC- y riesgos aceptados.
exit /b 0
