
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"

echo Reboot dari Normal ke Fastboot MODE
call "%_Adb%" reboot-bootloader
echo:
echo   Fastboot Flashing, HP Harus Fastboot MODE
echo:

echo Tunggu Sampai selesai masuk ke Fastboot Mode (Gambar Ijo)
echo Kemudian Tekan Enter
echo:
pause

echo:
echo:
echo Checking Product Name...

"%_FBoot%" getvar product 2>&1 | findstr /r /x /c:"product: *cereus" /c:"product: *cactus" || echo Missmatching image and device
"%_FBoot%" getvar product 2>&1 | findstr /r /x /c:"product: *cereus" /c:"product: *cactus" || exit /B 1


echo Apakah NVData Sudah di backup waktu normal mode ?
echo Do at your own risk!
echo:
echo Isian, isi kemudian tekan enter
echo: 
setlocal EnableDelayedExpansion
set /P inputcom="Erase NV Data ? [Y/N] : "

if "%inputcom%" == "y" (
    echo Apakah NVData Sudah di backup waktu normal mode ?
    echo Do at your own risk!
    echo:
    "%_FBoot%" erase nvdata  || @echo "erase nvdata error"
    "%_FBoot%" erase nvram  || @echo "erase nvram error"
)
if "%inputcom%" == "Y" (
    echo Apakah NVData Sudah di backup waktu normal mode ?
    echo Do at your own risk!
    echo:
    "%_FBoot%" erase nvdata  || @echo "erase nvdata error"
    "%_FBoot%" erase nvram  || @echo "erase nvram error"
)

"%_FBoot%" reboot


echo: 
echo: 
echo: 
echo Silahkan Lanjutkan ke Ganti....
echo: 

pause
exit 0