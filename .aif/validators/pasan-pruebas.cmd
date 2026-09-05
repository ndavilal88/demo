@echo off
REM Ejecuta las pruebas de verdad. Un validator que solo comprueba que el
REM fichero de test existe no comprueba nada.
setlocal
cd /d "%AIF_WORKSPACE%" || exit /b 3

if not exist "test" (
  echo No hay directorio test/. Esta fase tiene que dejar pruebas.
  exit /b 1
)

where node >nul 2>&1
if errorlevel 1 (
  echo Node no esta en el PATH: no se pueden ejecutar las pruebas.
  echo Esto NO es un veredicto sobre el trabajo, es una instalacion incompleta.
  exit /b 3
)

echo Ejecutando node --test test/ ...
node --test test/
if errorlevel 1 (
  echo.
  echo Hay pruebas en rojo. Lo de arriba es la salida completa del ejecutor.
  exit /b 1
)
echo Todas las pruebas pasan.
exit /b 0
