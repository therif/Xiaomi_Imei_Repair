rem  Fastboot Flashing, HP Harus Fastboot MODE
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"

for %%A in ("%~dp0\kenzo_global_images_V10.2.1.0.MHOMIXM") Do set "_CSC_Dir=%%~fA"
for %%A in ("%~dp0\kenzo_global_images_V10.2.1.0.MHOMIXM\_flash_all.bat") Do set "_CSC_exe=%%~fA"

call "%_Adb%" reboot bootloader

echo "%_CSC_Dir%"



@echo off

"%_FBoot%" getvar product 2>&1 | findstr /r /c:"^product: *kenzo" || echo Missmatching image and device
"%_FBoot%" getvar product 2>&1 | findstr /r /c:"^product: *kenzo" || exit /B 1
"%_FBoot%" flash tz %_CSC_Dir%\images\tz.mbn || @echo "Flash tz error" && exit /B 1
"%_FBoot%" flash sbl1 %_CSC_Dir%\images\sbl1.mbn || @echo "Flash sbl1 error" && exit /B 1
"%_FBoot%" flash rpm %_CSC_Dir%\images\rpm.mbn || @echo "Flash rpm error" && exit /B 1
"%_FBoot%" flash aboot %_CSC_Dir%\images\emmc_appsboot.mbn || @echo "Flash emmc_appsboot error" && exit /B 1
"%_FBoot%" flash hyp %_CSC_Dir%\images\hyp.mbn || @echo "Flash hyp error" && exit /B 1
"%_FBoot%" flash keymaster %_CSC_Dir%\images\keymaster.mbn || @echo "Flash keymaster error" && exit /B 1
"%_FBoot%" flash cmnlib %_CSC_Dir%\images\cmnlib.mbn || @echo "Flash cmnlib error" && exit /B 1

"%_FBoot%" flash tzbak %_CSC_Dir%\images\tz.mbn || @echo "Flash tzbak error" && exit /B 1
"%_FBoot%" flash sbl1bak %_CSC_Dir%\images\sbl1.mbn || @echo "Flash sbl1bak error" && exit /B 1
"%_FBoot%" flash rpmbak %_CSC_Dir%\images\rpm.mbn || @echo "Flash uboot rpmbak" && exit /B 1
"%_FBoot%" flash abootbak %_CSC_Dir%\images\emmc_appsboot.mbn || @echo "Flash abootbak error" && exit /B 1
"%_FBoot%" flash hypbak %_CSC_Dir%\images\hyp.mbn || @echo "Flash hypbak error" && exit /B 1
"%_FBoot%" flash keymasterbak %_CSC_Dir%\images\keymaster.mbn || @echo "Flash keymasterbak error" && exit /B 1
"%_FBoot%" flash cmnlibbak %_CSC_Dir%\images\cmnlib.mbn || @echo "Flash cmnlibbak error" && exit /B 1

"%_FBoot%" erase boot
"%_FBoot%" flash modem %_CSC_Dir%\images\NON-HLOS.bin || @echo "Flash modem error" && exit /B 1
"%_FBoot%" flash system %_CSC_Dir%\images\system.img || @echo "Flash system error" && exit /B 1
"%_FBoot%" flash cache %_CSC_Dir%\images\cache.img || @echo "Flash cache error" && exit /B 1
"%_FBoot%" flash userdata %_CSC_Dir%\images\userdata.img || @echo "Flash userdata error" && exit /B 1
"%_FBoot%" flash recovery %_CSC_Dir%\images\recovery.img || @echo "Flash recovery error" && exit /B 1
"%_FBoot%" flash boot %_CSC_Dir%\images\boot.img || @echo "Flash boot error" && exit /B 1

"%_FBoot%" flash sec %_CSC_Dir%\images\sec.dat || @echo "Flash sec error" && exit /B 1
"%_FBoot%" flash dsp %_CSC_Dir%\images\adspso.bin || @echo "Flash adspso error" && exit /B 1
"%_FBoot%" flash mdtp %_CSC_Dir%\images\mdtp.img || @echo "Flash mdtp error" && exit /B 1
"%_FBoot%" erase splash
"%_FBoot%" flash splash %_CSC_Dir%\images\splash.img || @echo "Flash splash error" && exit /B 1
"%_FBoot%" erase DDR

"%_FBoot%" flash cust %_CSC_Dir%\images\cust.img

"%_FBoot%" reboot


pause
exit 0