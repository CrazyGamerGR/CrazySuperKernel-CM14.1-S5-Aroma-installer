#!/sbin/sh

#Build config file
CONFIGFILE="/tmp/init.crazysuperkernel.rc"
BACKUP="/sdcard/.crazysuperkernel.backup"

echo "on boot" > $CONFIGFILE
echo "" >> $CONFIGFILE

#DT2W
DT2W=`grep "item.1.5" /tmp/aroma/gest.prop | cut -d '=' -f2`
DT2WH=`grep "item.2.3" /tmp/aroma/gest.prop | cut -d '=' -f2`
if [ $DT2W = 1 ] && [ $DT2WH = 1 ]; then
  echo "write /sys/android_touch/doubletap2wake 1" >> $CONFIGFILE
elif [ $DT2W = 1 ] && [ $DT2WH = 0 ]; then
  echo "write /sys/android_touch/doubletap2wake 2" >> $CONFIGFILE
else
  echo "write /sys/android_touch/doubletap2wake 0" >> $CONFIGFILE
fi

#USB Fastcharge
FC=`grep "item.0.1=" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $FC = 1 ]; then
  echo "write /sys/kernel/fast_charge/force_fast_charge 1" >> $CONFIGFILE
fi

#Max screen off frequency
MAXSCROFF=`grep "item.0.2" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $MAXSCROFF = 1 ]; then
  echo "write /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max 0" >> $CONFIGFILE
fi

#fsync
FSYNC=`grep "item.0.6" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $FSYNC = 1 ]; then
  echo "write /sys/module/sync/parameters/fsync_enabled 0" >> $CONFIGFILE
fi

#i/o scheduler
SCHED=`grep selected.1 /tmp/aroma/disk.prop | cut -d '=' -f2`
if [ $SCHED = 1 ]; then
  echo "write /sys/block/mmcblk0/queue/scheduler cfq"  >> $CONFIGFILE
elif [ $SCHED = 2 ]; then
  echo "write /sys/block/mmcblk0/queue/scheduler row"  >> $CONFIGFILE
elif [ $SCHED = 3 ]; then
  echo "write /sys/block/mmcblk0/queue/scheduler deadline"  >> $CONFIGFILE
elif [ $SCHED = 4 ]; then
  echo "write /sys/block/mmcblk0/queue/scheduler fiops"  >> $CONFIGFILE
elif [ $SCHED = 5 ]; then
  echo "write /sys/block/mmcblk0/queue/scheduler tripndroid"  >> $CONFIGFILE
elif [ $SCHED = 5 ]; then
  echo "write /sys/block/mmcblk0/queue/scheduler sio"  >> $CONFIGFILE
elif [ $SCHED = 6 ]; then
  echo "write /sys/block/mmcblk0/queue/scheduler bfq"  >> $CONFIGFILE
elif [ $SCHED = 7 ]; then
  echo "write /sys/block/mmcblk0/queue/scheduler zen"  >> $CONFIGFILE
fi

#Readahead buffer size
READAHEAD=`grep selected.2 /tmp/aroma/disk.prop | cut -d '=' -f2`
if [ $READAHEAD = 1 ]; then
  echo "write /sys/block/mmcblk0/queue/read_ahead_kb 128" >> $CONFIGFILE
elif [ $READAHEAD = 2 ]; then
  echo "write /sys/block/mmcblk0/queue/read_ahead_kb 256" >> $CONFIGFILE
elif [ $READAHEAD = 3 ]; then
  echo "write /sys/block/mmcblk0/queue/read_ahead_kb 512" >> $CONFIGFILE
elif [ $READAHEAD = 4 ]; then
  echo "write /sys/block/mmcblk0/queue/read_ahead_kb 1024" >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE

#reinstall options
echo -e "\n\n\n\n##### Reinstall Options #####" > $BACKUP
echo -e "# These settings are only applied if you run the express installer" >> $BACKUP

#Maximum CPU freqs
CPU0=$(cat /tmp/aroma/freq0.prop | cut -d '=' -f2)
if [ ! -e /tmp/aroma/freq1.prop ]; then
  cp /tmp/aroma/freq0.prop /tmp/aroma/freq1.prop;
  cp /tmp/aroma/freq0.prop /tmp/aroma/freq2.prop;
  cp /tmp/aroma/freq0.prop /tmp/aroma/freq3.prop;
fi
CPU1=$(cat /tmp/aroma/freq1.prop | cut -d '=' -f2)
CPU2=$(cat /tmp/aroma/freq2.prop | cut -d '=' -f2)
CPU3=$(cat /tmp/aroma/freq3.prop | cut -d '=' -f2)
echo -e "\n\n##### Max CPU Frequncies #####" >> $BACKUP
echo -e "# 1=1498MHz 2=1728MHz 3=1958MHz" >> $BACKUP
echo -e "# 4=2266MHz 5=2342MHz 6=2419MHz" >> $BACKUP
echo -e "# 7=2496MHz" .. $BACKUP
echo "CPU0=$CPU0" >> $BACKUP;
echo "CPU1=$CPU1" >> $BACKUP;
echo "CPU2=$CPU2" >> $BACKUP;
echo "CPU3=$CPU3" >> $BACKUP;

#END
