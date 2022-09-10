echo "land Fastboot Tool Ver 5.0"

fastboot %* flash aboot %~dp0images\emmc_appsboot.mbn || @echo "Flash emmc_appsboot error" && exit /B 1

fastboot %* flash abootbak %~dp0images\emmc_appsboot.mbn || @echo "Flash abootbak error" && exit /B 1

fastboot %* reboot

pause
