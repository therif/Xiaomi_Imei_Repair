
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fb-edl.exe") Do set "_FBootEDL=%%~fA"

for %%A in ("%~dp0\UnlockBL\images") Do set "_CSC_Dir=%%~fA"

echo Reboot dari Normal ke Fastboot MODE
call "%_Adb%" reboot-bootloader
echo:
echo   Fastboot Flashing, HP Harus Fastboot MODE
echo:

echo Tunggu Sampai selesai masuk ke Fastboot Mode (Gambar Ijo)
echo:
pause

echo:
echo:
echo Step Proses Unlocking OEM
echo: 

"%_FBoot%" getvar product 2>&1 | findstr /r /c:"^product: *land" || echo Missmatching image and device
"%_FBoot%" getvar product 2>&1 | findstr /r /c:"^product: *land" || exit /B 1

"%_FBoot%" flash aboot %_CSC_Dir%\emmc_appsboot.mbn

"%_FBoot%" flash abootbak %_CSC_Dir%\emmc_appsboot.mbn

"%_FBoot%" reboot

echo: 
echo: 
echo: 
echo Silahkan Lanjutkan ke Flashing CSC
echo: 


pause
exit 0