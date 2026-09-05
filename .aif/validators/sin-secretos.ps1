$ErrorActionPreference = 'Stop'
Set-Location $env:AIF_WORKSPACE

$patrones = @(
  '(?i)(api[_-]?key|secret|passwd|password|token)\s*[:=]\s*[''"][^''"]{8,}',
  'AKIA[0-9A-Z]{16}',
  '-----BEGIN [A-Z ]*PRIVATE KEY-----'
)

$dirs = @('src','web','test','docs','prototipo') | Where-Object { Test-Path $_ }
if (-not $dirs) { Write-Output 'Nada que barrer todavia.'; exit 0 }

$ficheros = @(Get-ChildItem -Recurse -File $dirs -ErrorAction SilentlyContinue)
if ($ficheros.Count -eq 0) { Write-Output "Nada que barrer todavia."; exit 0 }
$hits = @()
foreach ($p in $patrones) {
  $hits += Select-String -Path $ficheros.FullName -Pattern $p -ErrorAction SilentlyContinue
}

if ($hits.Count -gt 0) {
  foreach ($h in $hits) {
    $rel = Resolve-Path -Relative $h.Path
    Write-Output ("Posible secreto en " + $rel + ':' + $h.LineNumber)
  }
  Write-Output ''
  Write-Output 'Un secreto en un literal viaja en git para siempre, aunque se borre despues.'
  exit 1
}
Write-Output 'Sin secretos en literales.'
exit 0
