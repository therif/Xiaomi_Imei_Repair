
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fb-edl.exe") Do set "_FBootEDL=%%~fA"

for %%A in ("%~dp0\CSC_Qualcomm_land\images") Do set "_CSC_Dir=%%~fA"

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
echo Step Proses Flashing CSC
echo: 

rem fastboot flash modemst1 modemst1.img

"%_FBoot%" getvar product 2>&1 | findstr /r /x /c:"product: *land$" || echo Missmatching image and device
"%_FBoot%" getvar product 2>&1 | findstr /r /x /c:"product: *land$" || exit /B 1

"%_FBoot%" flash partition %_CSC_Dir%\gpt_both0.bin || @echo "Flash tz error" && exit /B 1

"%_FBoot%" flash tz %_CSC_Dir%\tz.mbn || @echo "Flash tz error" && exit /B 1
"%_FBoot%" flash sbl1 %_CSC_Dir%\sbl1.mbn || @echo "Flash sbl1 error" && exit /B 1
"%_FBoot%" flash rpm %_CSC_Dir%\rpm.mbn || @echo "Flash rpm error" && exit /B 1
rem "%_FBoot%" flash aboot %_CSC_Dir%\emmc_appsboot.mbn

"%_FBoot%" flash tzbak %_CSC_Dir%\tz.mbn || @echo "Flash tzbak error" && exit /B 1
"%_FBoot%" flash sbl1bak %_CSC_Dir%\sbl1.mbn || @echo "Flash sbl1bak error" && exit /B 1
"%_FBoot%" flash rpmbak %_CSC_Dir%\rpm.mbn || @echo "Flash uboot rpmbak" && exit /B 1
rem "%_FBoot%" flash abootbak %_CSC_Dir%\emmc_appsboot.mbn 

"%_FBoot%" flash devcfg %_CSC_Dir%\devcfg.mbn || @echo "Flash devcfg error" && exit /B 1
"%_FBoot%" flash lksecapp %_CSC_Dir%\lksecapp.mbn || @echo "Flash lksecapp error" && exit /B 1
"%_FBoot%" flash cmnlib %_CSC_Dir%\cmnlib.mbn || @echo "Flash cmnlib error" && exit /B 1
"%_FBoot%" flash cmnlib64 %_CSC_Dir%\cmnlib64.mbn || @echo "Flash cmnlib64 error" && exit /B 1
"%_FBoot%" flash keymaster %_CSC_Dir%\keymaster.mbn || @echo "Flash keymaster error" && exit /B 1

"%_FBoot%" flash devcfgbak %_CSC_Dir%\devcfg.mbn || @echo "Flash devcfgbak error" && exit /B 1
"%_FBoot%" flash lksecappbak %_CSC_Dir%\lksecapp.mbn || @echo "Flash lksecappbak error" && exit /B 1
"%_FBoot%" flash cmnlibbak %_CSC_Dir%\cmnlib.mbn || @echo "Flash cmnlibbak error" && exit /B 1
"%_FBoot%" flash cmnlib64bak %_CSC_Dir%\cmnlib64.mbn || @echo "Flash cmnlib64bak error" && exit /B 1
"%_FBoot%" flash keymasterbak %_CSC_Dir%\keymaster.mbn || @echo "Flash keymasterbak error" && exit /B 1

"%_FBoot%" flash dsp %_CSC_Dir%\adspso.bin || @echo "Flash dsp error" && exit /B 1
"%_FBoot%" flash persist %_CSC_Dir%\persist.img || @echo "Flash persist error" && exit /B 1

"%_FBoot%" erase boot
"%_FBoot%" erase mdtp

rem "%_FBoot%" flash modem %_CSC_Dir%\NON-HLOS.bin

"%_FBoot%" flash system %_CSC_Dir%\system.img || @echo "Flash system error" && exit /B 1
"%_FBoot%" flash cache %_CSC_Dir%\cache.img || @echo "Flash cache error" && exit /B 1
"%_FBoot%" flash userdata %_CSC_Dir%\userdata.img || @echo "Flash userdata error" && exit /B 1
"%_FBoot%" flash recovery %_CSC_Dir%\recovery.img || @echo "Flash recovery error" && exit /B 1
"%_FBoot%" flash boot %_CSC_Dir%\boot.img || @echo "Flash boot error" && exit /B 1

"%_FBoot%" flash splash %_CSC_Dir%\splash.img || @echo "Flash splash error" && exit /B 1
"%_FBoot%" flash cust %_CSC_Dir%\cust.img || @echo "Flash cust error" && exit /B 1

"%_FBoot%" reboot

echo: 
echo Silahkan Lanjutkan ke Ganti....
echo: 

pause
exit 0