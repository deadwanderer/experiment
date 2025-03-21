@echo off

if not exist bin mkdir bin
if not exist bin\SDL3.dll copy ext\sdl\SDL3.dll bin\SDL3.dll > nul
xcopy assets\ bin\  /S /Q /Y /D /I >nul

call C:\BuildTools\devcmd.bat

call compile_shaders.bat

odin build src -debug -out:bin/experiment.exe -collection:ext=ext -vet -strict-style -show-timings

if %errorlevel%==0 (
  pushd bin
  call experiment.exe
  popd
)