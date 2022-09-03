@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"

for %%A in ("%~dp0\land_global_images_V10.2.2.0.MALMIXM\images") Do set "_CSC_Dir=%%~fA"
for %%A in ("%~dp0\land_global_images_V10.2.2.0.MALMIXM\images\flash_all.bat") Do set "_CSC_exe=%%~fA"

echo Fastboot Flashing, HP Harus Fastboot MODE

@echo off

"%_FBoot%" getvar product 2>&1 | findstr /r /c:"product: *cereus" /c:"product: *cactus" > nul

if errorlevel 1 (
    echo Missmatching image and device
    pause
    exit 0
    
) ELSE (
    "%_FBoot%" getvar product 2>&1 | findstr /r /c:"product: *cereus"
    if errorlevel 1 (
        SET _prdName=cactus
    ) ELSE (
        SET _prdName=cereus
    )
)
echo %_prdName%

pause
exit 0