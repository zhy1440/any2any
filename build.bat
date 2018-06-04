@echo off
@set cmd=Compiler\Ahk2Exe.exe

@set src=src\test.ahk
@set target=test.exe
@set out=bin\%target%
@set deploy=C:\hotKey\%target%

echo %src%

@echo .
@echo ---   init    ---
@taskkill /f /im %target%

@echo .
@echo ---   clean   ---
@del %out%
@md bin

@echo .
@echo ---   compile ---
"%cmd%" /in %src% /out %out%

@echo .
@echo ---   done    ---

pause
