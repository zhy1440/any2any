@echo off
@set cmd=Compiler\Ahk2Exe.exe

@set src=src\Any2Any.ahk
@set target=any2any.exe
@set out=bin\%target%
@set deploy=C:\port\software\portable\%target%

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
