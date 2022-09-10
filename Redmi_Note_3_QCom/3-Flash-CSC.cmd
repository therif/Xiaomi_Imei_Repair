
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"

for %%A in ("%~dp0\CSC_qualcom_kenzo") Do set "_CSC_Dir=%%~fA"
for %%A in ("%~dp0\CSC_qualcom_kenzo\_8976_fastboot_all_images.bat") Do set "_CSC_exe=%%~fA"

echo Reboot dari Normal ke Fastboot MODE
call "%_Adb%" reboot-bootloader
echo:
echo Proses Flashing CSC
echo   Fastboot Flashing, HP Harus Fastboot MODE
echo:  
echo for not erase modemst1 and modemst2
echo: 

rem fastboot flash partition gpt_both0.bin 
"%_FBoot%" flash tz %_CSC_Dir%\tz.mbn
"%_FBoot%" flash sbl1 %_CSC_Dir%\sbl1.mbn
"%_FBoot%" flash rpm %_CSC_Dir%\rpm.mbn
"%_FBoot%" flash aboot %_CSC_Dir%\emmc_appsboot.mbn
"%_FBoot%" flash hyp %_CSC_Dir%\hyp.mbn
"%_FBoot%" flash tzbak %_CSC_Dir%\tz.mbn
"%_FBoot%" flash sbl1bak %_CSC_Dir%\sbl1.mbn
"%_FBoot%" flash rpmbak %_CSC_Dir%\rpm.mbn
"%_FBoot%" flash abootbak %_CSC_Dir%\emmc_appsboot.mbn
"%_FBoot%" flash hypbak %_CSC_Dir%\hyp.mbn
"%_FBoot%" flash keymaster %_CSC_Dir%\keymaster.mbn
"%_FBoot%" flash cmnlib %_CSC_Dir%\cmnlib.mbn
"%_FBoot%" flash keymasterbak %_CSC_Dir%\keymaster.mbn
"%_FBoot%" flash cmnlibbak %_CSC_Dir%\cmnlib.mbn

rem fastboot flash fsg fs_image.tar.gz.mbn.img
rem fastboot flash modemst1 dummy.bin
rem fastboot flash modemst2 dummy.bin
rem fastboot flash persist persist.img

"%_FBoot%" erase boot
"%_FBoot%" flash modem %_CSC_Dir%\NON-HLOS.bin
"%_FBoot%" flash system %_CSC_Dir%\system.img
"%_FBoot%" flash cache %_CSC_Dir%\cache.img
"%_FBoot%" flash userdata %_CSC_Dir%\userdata.img
"%_FBoot%" flash recovery %_CSC_Dir%\recovery.img
"%_FBoot%" flash boot %_CSC_Dir%\boot.img
rem fastboot flash sec sec.dat
"%_FBoot%" flash dsp %_CSC_Dir%\adspso.bin
"%_FBoot%" flash mdtp %_CSC_Dir%\mdtp.img
"%_FBoot%" erase splash
"%_FBoot%" flash splash %_CSC_Dir%\splash.img
"%_FBoot%" erase DDR

"%_FBoot%" reboot


pause
exit 0