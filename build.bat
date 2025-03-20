@echo off

if not exist bin mkdir bin
if not exist bin\SDL3.dll copy ext\sdl\SDL3.dll bin\SDL3.dll > nul

call C:\BuildTools\devcmd.bat

odin build src -debug -out:bin/experiment.exe -collection:ext=ext -vet -strict-style -show-timings

if %errorlevel%==0 (
  pushd bin
  call experiment.exe
  popd
)