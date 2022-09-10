@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"

echo:
echo Check HP Normal, is ADB Ready ?

"%_Adb%" %* devices 2>&1 | findstr /r /c:"^.*device$" || @echo ADB Error! || goto error

if %ERRORLEVEL% == 0 (
    echo:
    echo ADB Check OK! Lanjutkan...!
) else (
    echo Ada Error, Cek!
)

pause
exit 0
