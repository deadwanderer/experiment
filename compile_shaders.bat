@echo off

if not exist bin mkdir bin

pushd bin
del /s shaders\*.dxil >nul 2>&1
del /s shaders\*.spv >nul 2>&1
del /s shaders\*.hlsl >nul 2>&1
if not exist shader_compiler.exe (
 odin build ..\tools -out:shader_compiler.exe
)

if %ERRORLEVEL% == 0 call shader_compiler.exe
popd