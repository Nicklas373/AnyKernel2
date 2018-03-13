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
device.name1=nicki
device.name2=C1904
device.name3=C1905
device.name4=C2004
device.name5=c2005
device.name6=lineage_nicki

# Required for possible inline kernel flashing
if [ ! -f /recovery ] ; then
    alias gunzip="/tmp/anykernel/tools/busybox gunzip";
    alias cpio="/tmp/anykernel/tools/busybox cpio";
fi

} # end properties

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
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

# init.qcom.rc
# Add init.matsuura.rc
insert_line init.qcom.rc "init.matsuura.rc" after "init.target.rc" "import init.matsuura.rc";

# Disable mpdecision and thermald on boot
replace_section init.qcom.rc "start mpdecision" "start mpdecision\n"
replace_section init.target.rc "service thermald" "group root" "service thermald /system/bin/thermald\n    class main\n    user root\n	group root\n    disabled";
replace_section init.target.rc "service mpdecision" "group root system" "service mpdecision /system/bin/mpdecision --avg_comp\n    class main\n    user root\n    group root system\n";

# end ramdisk changes

write_boot;

## end install

