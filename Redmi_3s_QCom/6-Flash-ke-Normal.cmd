rem  Fastboot Flashing, HP Harus Fastboot MODE
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"

for %%A in ("%~dp0\land_global_images_V10.2.2.0.MALMIXM\images") Do set "_CSC_Dir=%%~fA"
for %%A in ("%~dp0\land_global_images_V10.2.2.0.MALMIXM\images\flash_all.bat") Do set "_CSC_exe=%%~fA"

call "%_Adb%" reboot bootloader

echo Flashing Global Redmi 3S
echo:
echo   HP Fastboot ijo
echo:

@echo off

"%_FBoot%" getvar product 2>&1 | findstr /r /x /c:"product: *land$" || echo Missmatching image and device
"%_FBoot%" getvar product 2>&1 | findstr /r /x /c:"product: *land$" || exit /B 1

"%_FBoot%" flash tz %_CSC_Dir%\tz.mbn || @echo "Flash tz error" && exit /B 1
"%_FBoot%" flash sbl1 %_CSC_Dir%\sbl1.mbn || @echo "Flash sbl1 error" && exit /B 1
"%_FBoot%" flash rpm %_CSC_Dir%\rpm.mbn || @echo "Flash rpm error" && exit /B 1
"%_FBoot%" flash aboot %_CSC_Dir%\emmc_appsboot.mbn || @echo "Flash emmc_appsboot error" && exit /B 1

"%_FBoot%" flash tzbak %_CSC_Dir%\tz.mbn || @echo "Flash tzbak error" && exit /B 1
"%_FBoot%" flash sbl1bak %_CSC_Dir%\sbl1.mbn || @echo "Flash sbl1bak error" && exit /B 1
"%_FBoot%" flash rpmbak %_CSC_Dir%\rpm.mbn || @echo "Flash uboot rpmbak" && exit /B 1
"%_FBoot%" flash abootbak %_CSC_Dir%\emmc_appsboot.mbn || @echo "Flash abootbak error" && exit /B 1

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

"%_FBoot%" erase boot
"%_FBoot%" erase mdtp

"%_FBoot%" flash modem %_CSC_Dir%\NON-HLOS.bin || @echo "Flash modem error" && exit /B 1
"%_FBoot%" flash system %_CSC_Dir%\system.img || @echo "Flash system error" && exit /B 1
"%_FBoot%" flash cache %_CSC_Dir%\cache.img || @echo "Flash cache error" && exit /B 1
"%_FBoot%" flash userdata %_CSC_Dir%\userdata.img || @echo "Flash userdata error" && exit /B 1
"%_FBoot%" flash recovery %_CSC_Dir%\recovery.img || @echo "Flash recovery error" && exit /B 1
"%_FBoot%" flash boot %_CSC_Dir%\boot.img || @echo "Flash boot error" && exit /B 1

"%_FBoot%" flash misc %_CSC_Dir%\misc.img || @echo "Flash misc error" && exit /B 1
"%_FBoot%" flash splash %_CSC_Dir%\splash.img || @echo "Flash splash error" && exit /B 1
"%_FBoot%" flash cust %_CSC_Dir%\cust.img || @echo "Flash cust error" && exit /B 1

"%_FBoot%" reboot

echo: 
echo Done....
echo: 

pause
exit 0