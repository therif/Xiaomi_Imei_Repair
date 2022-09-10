rem  Fastboot Flashing, HP Harus Fastboot MODE
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"

call "%_Adb%" reboot bootloader


echo Fastboot Flashing, HP Harus Fastboot MODE
echo:

@echo off
"%_FBoot%" getvar product 2>&1 | findstr /r /c:"product: *cereus" /c:"product: *cactus" > nul

if errorlevel 1 (
    echo Missmatching image and device
    echo:
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

if "%_prdName%" == "cereus" (
    SET _CSC_Dir=%~dp0cereus_global_images_V9.6.11.0\images
)
if "%_prdName%" == "cactus" (
    SET _CSC_Dir=%~dp0cactus_global_images_9.6.20\images
)

echo Firmware Dir : %_CSC_Dir%
echo:

"%_FBoot%" flash crclist "%_CSC_Dir%\crclist.txt"  || @echo "Flash crclist error" && goto error

"%_FBoot%" flash sparsecrclist "%_CSC_Dir%\sparsecrclist.txt"  || @echo "Flash sparsecrclist error" && goto error

REM preloader

"%_FBoot%" flash logo "%_CSC_Dir%\logo.bin"  || @echo "Flash logo error" && goto error

"%_FBoot%" flash tee1 "%_CSC_Dir%\tee.img"  || @echo "Flash tee1 error" && goto error

"%_FBoot%" flash scp1 "%_CSC_Dir%\scp.img"  || @echo "Flash scp1 error" && goto error

"%_FBoot%" flash sspm_1 "%_CSC_Dir%\sspm.img"  || @echo "Flash sspm_1 error" && goto error

REM lk lk.img

"%_FBoot%" flash tee2 "%_CSC_Dir%\tee.img"  || @echo "Flash tee2 error" && goto error

"%_FBoot%" flash scp2 "%_CSC_Dir%\scp.img"  || @echo "Flash scp2 error" && goto error

"%_FBoot%" flash sspm_2 "%_CSC_Dir%\sspm.img"  || @echo "Flash sspm_2 error" && goto error

REM lk2 lk.img


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


"%_FBoot%" reboot


pause
exit 0