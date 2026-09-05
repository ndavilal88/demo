@echo off
REM Toda fase deja documentacion: docs/ existe, tiene indice, y ningun .md vacio.
setlocal enabledelayedexpansion
cd /d "%AIF_WORKSPACE%" || (echo No se pudo entrar en el workspace & exit /b 3)

if not exist "docs" (
  echo docs/ no existe. Esta fase tiene que dejar su documentacion en docs/.
  exit /b 1
)
if not exist "docs\README.md" (
  echo Falta docs/README.md, que es el indice del expediente y el mapa de todo.
  exit /b 1
)

set VACIOS=0
for /r "docs" %%F in (*.md) do (
  for %%S in ("%%F") do if %%~zS LSS 40 (
    echo Documento practicamente vacio: %%F
    set /a VACIOS+=1
  )
)
if !VACIOS! GTR 0 (
  echo.
  echo !VACIOS! documento^(s^) sin contenido. Un apartado que no se puede
  echo completar se deja escrito como pregunta abierta, no como fichero vacio.
  exit /b 1
)
echo docs/ presente, con indice y sin documentos vacios.
exit /b 0
