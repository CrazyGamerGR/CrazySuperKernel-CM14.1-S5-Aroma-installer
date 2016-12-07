#!/sbin/sh

#set max_oc
val0=$(cat /tmp/aroma/freq0.prop | cut -d '=' -f2)

case $val0 in

	1)
	  max_oc0="max_oc0=1497600"
	  ;;
	2)
	  max_oc0="max_oc0=1728000"
	  ;;
	3)
	  max_oc0="max_oc0=1958400"
	  ;;
	4)
	  max_oc0="max_oc0=2265600"
	  ;;
  	5)
	  max_oc0="max_oc0=2342400"
	  ;;
  	6)
	  max_oc0="max_oc0=2419200"
	  ;;
	7)
	  max_oc0="max_oc0=2496000"
	  ;;
esac

if [ ! -e /tmp/aroma/freq1.prop ]; then
	cp /tmp/aroma/freq0.prop /tmp/aroma/freq1.prop;
	cp /tmp/aroma/freq0.prop /tmp/aroma/freq2.prop;
	cp /tmp/aroma/freq0.prop /tmp/aroma/freq3.prop;
fi

val1=$(cat /tmp/aroma/freq1.prop | cut -d '=' -f2)
case $val1 in

	1)
	  max_oc1="max_oc1=1497600"
	  ;;
	2)
	  max_oc1="max_oc1=1728000"
	  ;;
	3)
	  max_oc1="max_oc1=1958400"
	  ;;
	4)
	  max_oc1="max_oc1=2265600"
	  ;;
  	5)
	  max_oc1="max_oc1=2342400"
	  ;;
  	6)
	  max_oc1="max_oc1=2419200"
	  ;;
	7)
	  max_oc1="max_oc1=2496000"
	  ;;
esac

val2=$(cat /tmp/aroma/freq2.prop | cut -d '=' -f2)
case $val2 in

	1)
	  max_oc2="max_oc2=1497600"
	  ;;
	2)
	  max_oc2="max_oc2=1728000"
	  ;;
	3)
	  max_oc2="max_oc2=1958400"
	  ;;
	4)
	  max_oc2="max_oc2=2265600"
	  ;;
  	5)
	  max_oc2="max_oc2=2342400"
	  ;;
  	6)
	  max_oc2="max_oc2=2419200"
	  ;;
	7)
	  max_oc2="max_oc2=2496000"
	  ;;
esac

val3=$(cat /tmp/aroma/freq3.prop | cut -d '=' -f2)
case $val3 in

	1)
	  max_oc3="max_oc3=1497600"
	  ;;
	2)
	  max_oc3="max_oc3=1728000"
	  ;;
	3)
	  max_oc3="max_oc3=1958400"
	  ;;
	4)
	  max_oc3="max_oc3=2265600"
	  ;;
  	5)
	  max_oc3="max_oc3=2342400"
	  ;;
  	6)
	  max_oc3="max_oc3=2419200"
	  ;;
	7)
	  max_oc3="max_oc3=2496000"
	  ;;
esac

echo "cmdline = console=null androidboot.hardware=qcom user_debug=31 maxcpus=2" $max_oc0 $max_oc1 $max_oc2 $max_oc3 > /tmp/cmdline1.cfg
