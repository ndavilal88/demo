@echo off
REM Tres niveles, y cada uno responde a una pregunta distinta:
REM   unidad      - una funcion hace lo que dice
REM   integracion - dos piezas se entienden entre si
REM   e2e         - la herramienta completa, lanzada como la lanza una persona
setlocal enabledelayedexpansion
cd /d "%AIF_WORKSPACE%" || exit /b 3

set FALLOS=0
for %%N in (unidad integracion e2e) do (
  if not exist "test\%%N" (
    echo Falta test\%%N\
    set /a FALLOS+=1
  ) else (
    set CUENTA=0
    for %%F in ("test\%%N\*.test.js" "test\%%N\*.test.mjs") do set /a CUENTA+=1
    if !CUENTA! EQU 0 (
      echo test\%%N\ existe y no tiene ninguna prueba dentro.
      set /a FALLOS+=1
    )
  )
)

if !FALLOS! GTR 0 (
  echo.
  echo Los tres niveles hacen preguntas distintas y ninguno sustituye a otro:
  echo   unidad      una funcion hace lo que dice
  echo   integracion dos piezas se entienden entre si
  echo   e2e         la herramienta lanzada como la lanza una persona
  echo Un directorio vacio es peor que uno ausente: parece cubierto.
  exit /b 1
)

REM El E2E tiene que lanzar el proceso de verdad, no importar la funcion.
findstr /s /i /m /c:"child_process" "test\e2e\*" >nul 2>&1
if errorlevel 1 (
  echo Las pruebas de test\e2e\ no lanzan ningun proceso.
  echo Un E2E que importa la funcion y la llama es una prueba de integracion con
  echo otro nombre: tiene que ejecutar la herramienta como la ejecuta una persona.
  exit /b 1
)

echo Tres niveles presentes, y el E2E lanza el proceso de verdad.
exit /b 0
