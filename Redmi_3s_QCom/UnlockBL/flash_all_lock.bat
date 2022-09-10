echo "land Fastboot Tool Ver 5.0"

fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *land" || echo Missmatching image and device
fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *land" || exit /B 1

fastboot %* flash aboot %~dp0images\emmc_appsboot.mbn || @echo "Flash emmc_appsboot error" && exit /B 1

fastboot %* flash abootbak %~dp0images\emmc_appsboot.mbn || @echo "Flash abootbak error" && exit /B 1

fastboot %* flash recovery %~dp0images\recovery.img || @echo "Flash recovery error" && exit /B 1

fastboot %* oem lock
fastboot %* reboot

pause
