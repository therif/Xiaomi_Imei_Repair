
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"

for %%A in ("%~dp0\Redmi_6_6A_Engineering_Build_S98507_20180605_V039\images") Do set "_CSC_Dir=%%~fA"

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


"%_FBoot%" flash crclist "%_CSC_Dir%\crclist.txt"  || @echo "Flash crclist error" && goto error

"%_FBoot%" flash sparsecrclist "%_CSC_Dir%\sparsecrclist.txt"  || @echo "Flash sparsecrclist error" && goto error

"%_FBoot%" flash logo "%_CSC_Dir%\logo.bin"  || @echo "Flash logo error" && goto error

"%_FBoot%" flash tee1 "%_CSC_Dir%\tee.img"  || @echo "Flash tee1 error" && goto error

"%_FBoot%" flash scp1 "%_CSC_Dir%\scp.img"  || @echo "Flash scp1 error" && goto error

"%_FBoot%" flash sspm_1 "%_CSC_Dir%\sspm.img"  || @echo "Flash sspm_1 error" && goto error

"%_FBoot%" flash tee2 "%_CSC_Dir%\tee.img"  || @echo "Flash tee2 error" && goto error

"%_FBoot%" flash scp2 "%_CSC_Dir%\scp.img"  || @echo "Flash scp2 error" && goto error

"%_FBoot%" flash sspm_2 "%_CSC_Dir%\sspm.img"  || @echo "Flash sspm_2 error" && goto error


"%_FBoot%" flash odmdtbo "%_CSC_Dir%\odmdtbo.img"  || @echo "Flash odmdtbo error" && goto error

"%_FBoot%" flash spmfw "%_CSC_Dir%\spmfw.img"  || @echo "Flash spmfw error" && goto error

"%_FBoot%" flash md1img "%_CSC_Dir%\md1img.img"  || @echo "Flash md1img error" && goto error


"%_FBoot%" flash vendor "%_CSC_Dir%\vendor.img"  || @echo "Flash vendor error" && goto error

"%_FBoot%" flash system "%_CSC_Dir%\system.img"  || @echo "Flash system error" && goto error

"%_FBoot%" flash cache "%_CSC_Dir%\cache.img"  || @echo "Flash cache error" && goto error

"%_FBoot%" flash recovery "%_CSC_Dir%\recovery.img"  || @echo "Flash recovery error" && goto error

"%_FBoot%" flash boot "%_CSC_Dir%\boot.img"  || @echo "Flash boot error" && goto error

"%_FBoot%" flash cust "%_CSC_Dir%\cust.img"  || @echo "Flash cust error" && goto error

"%_FBoot%" flash vbmeta "%_CSC_Dir%\vbmeta.img"  || @echo "Flash vbmeta error" && goto error

"%_FBoot%" flash userdata "%_CSC_Dir%\userdata.img"  || @echo "Flash userdata error" && goto error

echo Apakah NVData Sudah di backup waktu normal mode ?
echo Do at your own risk!
echo:
echo Isian, isi kemudian tekan enter
echo: 
setlocal EnableDelayedExpansion
set /P inputcom="Erase NV Data ? [Y/N] : "

if "%inputcom%" == "y" (
    
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