$ErrorActionPreference = 'Stop'
Set-Location $env:AIF_WORKSPACE
if (-not (Test-Path 'docs')) { Write-Output 'Todavia no hay docs/.'; exit 0 }

$rotos = 0
foreach ($f in Get-ChildItem -Recurse -File 'docs' -Filter *.md) {
  $texto = Get-Content $f.FullName -Raw
  foreach ($m in [regex]::Matches($texto, '\]\(([^)#\s]+\.md)')) {
    $destino = Join-Path $f.DirectoryName $m.Groups[1].Value
    if (-not (Test-Path $destino)) {
      $rel = Resolve-Path -Relative $f.FullName
      Write-Output ("Enlace roto en " + $rel + "  ->  " + $m.Groups[1].Value)
      $rotos++
    }
  }
}

if ($rotos -gt 0) {
  Write-Output ''
  Write-Output "$rotos enlace(s) apuntan a documentos que no existen."
  Write-Output 'Un enlace roto en el indice es un documento que nadie va a encontrar.'
  exit 1
}
Write-Output 'Todos los enlaces relativos de docs/ resuelven.'
exit 0
