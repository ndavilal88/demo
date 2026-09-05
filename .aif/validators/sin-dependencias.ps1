$ErrorActionPreference = 'Stop'
Set-Location $env:AIF_WORKSPACE
$fallos = 0

if (Test-Path 'node_modules') {
  Write-Output 'Hay node_modules/. El proyecto arranca sin npm install: eso es un Constrain.'
  $fallos++
}

if (Test-Path 'package.json') {
  $p = Get-Content 'package.json' -Raw | ConvertFrom-Json
  $d = @()
  if ($p.PSObject.Properties.Name -contains 'dependencies' -and $p.dependencies) {
    $d += $p.dependencies.PSObject.Properties.Name
  }
  if ($p.PSObject.Properties.Name -contains 'devDependencies' -and $p.devDependencies) {
    $d += $p.devDependencies.PSObject.Properties.Name
  }
  if ($d.Count -gt 0) {
    Write-Output ("package.json declara dependencias: " + ($d -join ', '))
    $fallos++
  }
}

$std = @('fs','path','url','os','util','assert','test','crypto','readline','process',
         'events','stream','string_decoder','buffer','timers','child_process','node:test')

$dirs = @('src','test','web') | Where-Object { Test-Path $_ }
if ($dirs) {
  $ficheros = Get-ChildItem -Recurse -File $dirs -Include *.js,*.mjs -ErrorAction SilentlyContinue
  $malos = @()
  foreach ($f in $ficheros) {
    $texto = Get-Content $f.FullName -Raw
    $mods = @()
    $mods += ([regex]::Matches($texto, "require\(\s*['""]([^'""]+)")     | ForEach-Object { $_.Groups[1].Value })
    $mods += ([regex]::Matches($texto, "from\s+['""]([^'""]+)['""]"))    | ForEach-Object { $_.Groups[1].Value }
    foreach ($m in $mods) {
      if ($m -like '.*' -or $m.StartsWith('.') -or $m.StartsWith('node:')) { continue }
      if ($std -notcontains $m) { $malos += ($f.Name + ' -> ' + $m) }
    }
  }
  foreach ($m in ($malos | Sort-Object -Unique)) {
    Write-Output ('Import fuera de la stdlib: ' + $m)
    $fallos++
  }
}

if ($fallos -gt 0) {
  Write-Output ''
  Write-Output 'Constrain 1 de OBJETIVO.md: solo la biblioteca estandar de Node.'
  exit 1
}
Write-Output 'Cero dependencias externas.'
exit 0
