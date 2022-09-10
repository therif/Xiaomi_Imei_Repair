
@echo off&setlocal
for %%A in ("%~dp0..\") Do set "_MainDir=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\adb.exe") Do set "_Adb=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fastboot.exe") Do set "_FBoot=%%~fA"
for %%A in ("%~dp0..\ADB_Fastboot\fb-edl.exe") Do set "_FBootEDL=%%~fA"

for %%A in ("%~dp0\UnlockBL\firm") Do set "_CSC_Dir=%%~fA"

echo PATCHING BOOTLOADER
echo:
echo Jawab Isian, kemudian Enter.
echo: 
echo Posisi HP Sekarang ?
echo 1. Nyala Normal (ADB OK)    2. Fastboot   3. Sudah EDL
echo:
echo Isian, isi kemudian tekan enter
echo: 
setlocal EnableDelayedExpansion
set /P inputmode="Isikan Nomor Pilihan : "

set res=n
if "%inputmode%" == "1" goto ModeNormalAdb
if "%inputmode%" == "2" goto ModeFastboot
if "%inputmode%" == "3" goto ModeEDL

:ModeNormalAdb
echo Reboot dari Normal ke Fastboot MODE
call "%_Adb%" reboot-bootloader
echo:
echo   Fastboot Flashing, HP Harus Fastboot MODE
echo:

echo Tunggu Sampai selesai masuk ke Fastboot Mode (Gambar Ijo)
echo:
pause

:ModeFastboot
echo Reboot dari Fastboot Mode ke EDL Mode
echo:

"%_FBootEDL%" reboot-edl

echo:
echo:
echo Step Proses Unlocking OEM
echo:


:ModeEDL
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

QSaharaServer -p %comno% -s 13:prog_emmc_firehose_8976_ddr.mbn

fh_loader --port=%comno% --sendxml=%fileraw0% --search_path="%_CSC_Dir%" --noprompt --showpercentagecomplete --zlpawarehost=1 --memoryname=emmc  
fh_loader --port=%comno% --sendxml=%filepath0% --search_path="%_CSC_Dir%""
fh_loader --port=%comno% --setactivepartition=0 --noprompt --showpercentagecomplete --zlpawarehost=1 --memoryname=emmc 



:EndProses
echo: 
echo: 
echo: 
echo Proses End.
echo: 

pause
exit 0