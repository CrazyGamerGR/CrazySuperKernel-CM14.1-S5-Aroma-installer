#!/sbin/sh

mkdir /tmp/ramdisk
cp /tmp/boot.img-ramdisk.gz /tmp/ramdisk/
cd /tmp/ramdisk/
gunzip -c /tmp/ramdisk/boot.img-ramdisk.gz | cpio -i
rm /tmp/ramdisk/boot.img-ramdisk.gz
rm /tmp/boot.img-ramdisk.gz

#Start crazysuperkernel script
if [ $(grep -c "import /init.crazysuperkernel.rc" /tmp/ramdisk/init.rc) == 0 ]; then
   sed -i "/import \/init\.trace\.rc/aimport /init.crazysuperkernel.rc" /tmp/ramdisk/init.rc
fi

#copy crazysuperkernel scripts
cp /tmp/init.crazysuperkernel.rc /tmp/ramdisk/init.crazysuperkernel.rc
chmod 0750 /tmp/ramdisk/init.crazysuperkernel.rc

#copy crazysuperkernel scripts
rm /tmp/ramdisk/sbin/crazysuperkernel.sh
cp /tmp/init.crazysuperkernel.rc /tmp/ramdisk/init.crazysuperkernel.rc
chmod 0750 /tmp/ramdisk/init.crazysuperkernel.rc

find . | cpio -o -H newc | gzip > /tmp/boot.img-ramdisk.gz
rm -r /tmp/ramdisk

