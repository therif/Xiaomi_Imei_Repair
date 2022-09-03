
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fb-edl.exe") Do set "_FBootEDL=%%~fA"

for %%A in ("%~dp0\UnlockBL\images") Do set "_CSC_Dir=%%~fA"

echo Unlock Bootloader - EDL Mode
echo   EDL Flashing
echo   HP Harus Kondisi OFF/Mati, Colok Kabel EDL dengan Tekan Tombol di Kabel
echo:

echo:
echo Step Proses Unlocking OEM
echo: 

setlocal EnableDelayedExpansion
set /P inputcom="Isi COM Port Number : "

echo %inputcom%| findstr /r "^[1-9][0-9]*$">nul

if %ERRORLEVEL% == 0 (
    echo COM Dipilih : %inputcom%
    echo:
) else (
    echo Error, Com Port Harus Nomor! 
    echo:

    pause
    exit 0
)

set comno=\\.\COM%inputcom%
set fileraw0=%_CSC_Dir%\rawprogram0.xml
set filepath0=%_CSC_Dir%\patch0.xml

echo Changing Directory...
echo: 
cd /D %_CSC_Dir%
echo %cd%

QSaharaServer -p %comno% -s 13:prog_emmc_firehose_8937_ddr.mbn

fh_loader --port=%comno% --sendxml=%fileraw0% --search_path="%_CSC_Dir%" --noprompt --showpercentagecomplete --zlpawarehost=1 --memoryname=emmc  
rem fh_loader --port=%comno% --sendxml=%filepath0% --search_path="%_CSC_Dir%""
rem fh_loader --port=%comno% --setactivepartition=0 --noprompt --showpercentagecomplete --zlpawarehost=1 --memoryname=emmc 

echo: 
echo Silahkan Lanjutkan ke Flashing CSC
echo: 


pause
exit 0