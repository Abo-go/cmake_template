cmake -H. -Bbuild -G"Visual Studio 16 2019" -A x64 

@echo off
:Wait
set /a n+=1
if %n% gtr 6 goto End
ping -n 2 127.0.0.1>nul
echo .
goto Wait
:End