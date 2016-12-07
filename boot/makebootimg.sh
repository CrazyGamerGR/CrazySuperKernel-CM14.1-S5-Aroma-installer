#!/sbin/sh
echo \#!/sbin/sh > /tmp/createnewboot.sh
echo /tmp/mkbootimg --kernel /tmp/crazy.zImage --ramdisk /tmp/boot.img-ramdisk.gz --cmdline \"$(cat /tmp/cmdline1.cfg)\" --base 0x$(cat /tmp/boot.img-base) --pagesize 2048 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000 --output /tmp/newboot.img >> /tmp/createnewboot.sh
chmod 777 /tmp/createnewboot.sh
/tmp/createnewboot.sh
return $?
