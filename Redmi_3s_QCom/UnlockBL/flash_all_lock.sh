echo "land Fastboot Tool Ver 5.0"

fastboot $* getvar product 2>&1 | grep "^product: land"

if [ $? -ne 0 ] ; then echo "Missmatching image and device"; exit 1; fi

fastboot $* flash aboot `dirname $0`/images/emmc_appsboot.mbn

fastboot $* flash abootbak `dirname $0`/images/emmc_appsboot.mbn

fastboot $* flash recovery `dirname $0`/images/recovery.img

fastboot $* oem lock
fastboot $* reboot
