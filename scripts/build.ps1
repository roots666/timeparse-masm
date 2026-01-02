param(
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'

if ($Clean -and (Test-Path 'build')) {
    Remove-Item -Recurse -Force 'build'
}

New-Item -ItemType Directory -Force -Path 'build' | Out-Null

Write-Host 'Assembling (ml64)...'
ml64 /nologo /c /Fo build\convert_time.obj src\convert_time.asm
if ($LASTEXITCODE -ne 0) {
    throw "ml64 failed with exit code $LASTEXITCODE"
}

Write-Host 'Compiling (cl)...'
cl /nologo /W4 /TC /O2 /I include /c /Fo:build\main.obj src\main.c
if ($LASTEXITCODE -ne 0) {
    throw "cl failed with exit code $LASTEXITCODE"
}

Write-Host 'Linking (link)...'
link /nologo /SUBSYSTEM:CONSOLE /OUT:build\timeparse.exe build\main.obj build\convert_time.obj
if ($LASTEXITCODE -ne 0) {
    throw "link failed with exit code $LASTEXITCODE"
}

Write-Host 'Running smoke test...'
if (-not (Test-Path '.\build\timeparse.exe')) {
    throw "Smoke test binary not found: .\build\timeparse.exe"
}
.\build\timeparse.exe

Write-Host 'Done.'
