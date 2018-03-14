# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers
# Nicklas Van Dam @ XDA
# プロジェクト　ラブライブ | Project Matsuura (2018)

## AnyKernel setup
# begin properties
properties() {
kernel.string=Matsuura Kernel by Nicklas Van Dam @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=D2202
device.name2=D2203
device.name3=D2243
device.name4=D2212
device.name5=flamingo

# Required for possible inline kernel flashing
if [ ! -f /recovery ] ; then
    alias gunzip="/tmp/anykernel/tools/busybox gunzip";
    alias cpio="/tmp/anykernel/tools/busybox cpio";
fi

} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


ui_print "======================================";
ui_print "|                                    |";
ui_print "|            Matsuura Kernel         |";
ui_print "|                                    |";
ui_print "======================================";
ui_print "            XDA - Developers          ";

## AnyKernel install
dump_boot;

# Ramdisk Modifications
# init.flamingo.rc
insert_line init.flamingo.rc "init.matsuura.rc" after "init.common.rc" "init.common.usb.rc" "init.yukon.pwr.rc";
replace_line init.yukon.pwr.rc "start mpdecision" "stop mpdecision";

# Disable mpdecision and thermald on boot
replace_section init.common.rc "service thermal-engine" "group root" "service thermal-engine /vendor/bin/thermal-engine\n    class main\n    user root\n		group root\n	writepid /dev/cpuset/system-background/task";
replace_section init.target.rc "service mpdecision" "group root system" "service mpdecision /vendor/bin/mpdecision --avg_comp\n    class main\n    user root\n    group root	system\n	disabled	writepid /dev/cpuset/system-background/task";

# end ramdisk changes

write_boot;

## end install

