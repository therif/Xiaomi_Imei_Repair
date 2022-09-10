
echo "cereus fastboot flash tools"

fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *cereus" || echo Missmatching image and device
fastboot %* getvar product 2>&1 | findstr /r /c:"^product: *cereus" || exit /B 1



fastboot %* flash crclist "%~dp0images\crclist.txt"  || @echo "Flash crclist error" && goto error

fastboot %* flash sparsecrclist "%~dp0images\sparsecrclist.txt"  || @echo "Flash sparsecrclist error" && goto error

fastboot %* flash preloader "%~dp0images\preloader_cereus.bin"  || @echo "Flash preloader error" && goto error

fastboot %* flash logo "%~dp0images\logo.bin"  || @echo "Flash logo error" && goto error

fastboot %* flash tee1 "%~dp0images\tee.img"  || @echo "Flash tee1 error" && goto error

fastboot %* flash scp1 "%~dp0images\scp.img"  || @echo "Flash scp1 error" && goto error

fastboot %* flash sspm_1 "%~dp0images\sspm.img"  || @echo "Flash sspm_1 error" && goto error

fastboot %* flash lk "%~dp0images\lk.img"  || @echo "Flash lk error" && goto error

fastboot %* flash tee2 "%~dp0images\tee.img"  || @echo "Flash tee2 error" && goto error

fastboot %* flash scp2 "%~dp0images\scp.img"  || @echo "Flash scp2 error" && goto error

fastboot %* flash sspm_2 "%~dp0images\sspm.img"  || @echo "Flash sspm_2 error" && goto error

fastboot %* flash lk2 "%~dp0images\lk.img"  || @echo "Flash lk2 error" && goto error


fastboot %* flash odmdtbo "%~dp0images\odmdtbo.img"  || @echo "Flash odmdtbo error" && goto error

fastboot %* flash spmfw "%~dp0images\spmfw.img"  || @echo "Flash spmfw error" && goto error

fastboot %* flash md1img "%~dp0images\md1img.img"  || @echo "Flash md1img error" && goto error


fastboot %* flash vendor "%~dp0images\vendor.img"  || @echo "Flash vendor error" && goto error

fastboot %* flash system "%~dp0images\system.img"  || @echo "Flash system error" && goto error

fastboot %* flash cache "%~dp0images\cache.img"  || @echo "Flash cache error" && goto error

fastboot %* flash recovery "%~dp0images\recovery.img"  || @echo "Flash recovery error" && goto error

fastboot %* flash boot "%~dp0images\boot.img"  || @echo "Flash boot error" && goto error

fastboot %* flash cust "%~dp0images\cust.img"  || @echo "Flash cust error" && goto error

fastboot %* flash vbmeta "%~dp0images\vbmeta.img"  || @echo "Flash vbmeta error" && goto error




fastboot %* reboot
pause
exit 0
:error
pause
exit /B 1


