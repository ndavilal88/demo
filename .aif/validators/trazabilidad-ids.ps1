$ErrorActionPreference = 'Stop'
Set-Location $env:AIF_WORKSPACE

$fichReq = 'docs/01-requisitos/requisitos.md'
if (-not (Test-Path $fichReq)) {
  Write-Output "Todavia no hay ${fichReq}: nada que trazar en esta fase."
  exit 0
}

function Ids($ruta, $patron) {
  if (-not (Test-Path $ruta)) { return @() }
  $t = Get-Content $ruta -Raw
  return ([regex]::Matches($t, $patron) | ForEach-Object { $_.Value } | Sort-Object -Unique)
}

$rf  = Ids $fichReq '\bRF-\d+'
$rnf = Ids $fichReq '\bRNF-\d+'
$sec = Ids 'docs/03-seguridad/modelo-de-amenazas.md' '\bSEC-\d+'
$conocidos = @($rf) + @($rnf) + @($sec)

$trazas = @()
$dirs = @('src','web','test') | Where-Object { Test-Path $_ }
if ($dirs) {
  foreach ($f in Get-ChildItem -Recurse -File $dirs -ErrorAction SilentlyContinue) {
    $t = Get-Content $f.FullName -Raw
    $trazas += ([regex]::Matches($t, '@trace\s+((?:RF|RNF|SEC)-\d+)') | ForEach-Object { $_.Groups[1].Value })
  }
}
$trazas = $trazas | Sort-Object -Unique

$fallos = 0

foreach ($t in $trazas) {
  if ($conocidos -notcontains $t) {
    Write-Output "@trace $t apunta a un requisito que no existe"
    $fallos++
  }
}

if (Test-Path 'src') {
  foreach ($r in $rf) {
    if ($trazas -notcontains $r) {
      Write-Output "$r no tiene ningun @trace en el codigo"
      $fallos++
    }
  }
  foreach ($s in $sec) {
    if ($trazas -notcontains $s) {
      Write-Output "$s es una mitigacion declarada y sin sitio en el codigo"
      $fallos++
    }
  }
}

if ($fallos -gt 0) {
  Write-Output ''
  Write-Output "$fallos problema(s) de trazabilidad."
  Write-Output 'Un requisito sin codigo y un codigo sin requisito son las dos caras del'
  Write-Output 'mismo defecto, y por eso se pregunta en los dos sentidos.'
  exit 1
}
Write-Output ("Trazabilidad coherente: " + $rf.Count + " RF, " + $sec.Count + " SEC, " + $trazas.Count + " @trace.")
exit 0
