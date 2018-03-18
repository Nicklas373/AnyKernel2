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
ramdisk_compression=gz;


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
# Try to push custom init to available init file when used on recovery (TWRP)
backup_file init.rc;
insert_line init.rc "init.matsuura.rc" before "import /init.usb.rc" "import init.matsuura.rc";

# Try to disable mpdecision on boot
replace_string init.yukon.pwr.rc "#start mpdecision" "start mpdecision" "#start mpdecision";
replace_string init.common.rc "#service mpdecision /system/vendor/bin/mpdecision --avg_comp" "service mpdecision /system/vendor/bin/mpdecision --avg_comp" "#service mpdecision /system/vendor/bin/mpdecision --avg_comp";
replace_string init.common.rc "#user root" "user root" "#user root";
replace_string init.common.rc "#group root system" "group root system" "#group root system";
replace_string init.common.rc "#disabled" "disabled" "#disabled";
replace_string init.common.rc "#writepid /dev/cpuset/system-background/tasks" "writepid /dev/cpuset/system-background/tasks" "#writepid /dev/cpuset/system-background/tasks"

# end ramdisk changes

write_boot;

## end install

