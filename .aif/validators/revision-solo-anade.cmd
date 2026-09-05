@echo off
REM El revisor no arregla lo que revisa. Comprueba contra git que la fase solo
REM ANADIO ficheros y no modifico ni borro ninguno.
setlocal enabledelayedexpansion
cd /d "%AIF_WORKSPACE%" || exit /b 3

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo No es un worktree de git: no se puede comprobar que la revision no toco nada.
  exit /b 3
)

set TOCADOS=0
for /f "usebackq tokens=1,* delims=	 " %%A in (`git status --porcelain 2^>nul`) do (
  set "EST=%%A"
  set "FIC=%%B"
  if /i not "!EST!"=="??" (
    if /i not "!EST!"=="A" (
      echo Modificado o borrado por una fase de revision: !FIC!   ^(!EST!^)
      set /a TOCADOS+=1
    )
  )
)

if !TOCADOS! GTR 0 (
  echo.
  echo Una fase de revision solo puede ANADIR su informe. !TOCADOS! fichero^(s^)
  echo existentes cambiaron: encontrar y arreglar son dos actos, y juntarlos es
  echo como se cuelan los arreglos que nadie revisa.
  exit /b 1
)
echo La revision solo anadio ficheros nuevos.
exit /b 0
