
echo "cereus fastboot flash tools"


fastboot $* getvar product 2>&1 | grep "^product: *cereus"
if [ $? -ne 0 ] ; then echo "Missmatching image and device"; exit 1; fi
SCRIPT_PATH=$(dirname $0)

handle_error()
{
    echo $@
    exit 2;
}


fastboot $* flash crclist ${SCRIPT_PATH}/images/crclist.txt || handle_error flash crclist error

fastboot $* flash sparsecrclist ${SCRIPT_PATH}/images/sparsecrclist.txt || handle_error flash sparsecrclist error

fastboot $* flash preloader ${SCRIPT_PATH}/images/preloader_cereus.bin || handle_error flash preloader error

fastboot $* flash logo ${SCRIPT_PATH}/images/logo.bin || handle_error flash logo error

fastboot $* flash tee1 ${SCRIPT_PATH}/images/tee.img || handle_error flash tee1 error

fastboot $* flash scp1 ${SCRIPT_PATH}/images/scp.img || handle_error flash scp1 error

fastboot $* flash sspm_1 ${SCRIPT_PATH}/images/sspm.img || handle_error flash sspm_1 error

fastboot $* flash lk ${SCRIPT_PATH}/images/lk.img || handle_error flash lk error

fastboot $* flash tee2 ${SCRIPT_PATH}/images/tee.img || handle_error flash tee2 error

fastboot $* flash scp2 ${SCRIPT_PATH}/images/scp.img || handle_error flash scp2 error

fastboot $* flash sspm_2 ${SCRIPT_PATH}/images/sspm.img || handle_error flash sspm_2 error

fastboot $* flash lk2 ${SCRIPT_PATH}/images/lk.img || handle_error flash lk2 error


fastboot $* flash odmdtbo ${SCRIPT_PATH}/images/odmdtbo.img || handle_error flash odmdtbo error

fastboot $* flash spmfw ${SCRIPT_PATH}/images/spmfw.img || handle_error flash spmfw error

fastboot $* flash md1img ${SCRIPT_PATH}/images/md1img.img || handle_error flash md1img error


fastboot $* flash vendor ${SCRIPT_PATH}/images/vendor.img || handle_error flash vendor error

fastboot $* flash system ${SCRIPT_PATH}/images/system.img || handle_error flash system error

fastboot $* flash cache ${SCRIPT_PATH}/images/cache.img || handle_error flash cache error

fastboot $* flash recovery ${SCRIPT_PATH}/images/recovery.img || handle_error flash recovery error

fastboot $* flash boot ${SCRIPT_PATH}/images/boot.img || handle_error flash boot error

fastboot $* flash cust ${SCRIPT_PATH}/images/cust.img || handle_error flash cust error

fastboot $* flash vbmeta ${SCRIPT_PATH}/images/vbmeta.img || handle_error flash vbmeta error





fastboot $* reboot
exit 0

