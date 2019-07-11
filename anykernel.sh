# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Clarity Kernel for Xiaomi Redmi Note 4(x) Snapdragon
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=mido
supported.versions=9
'; } # end properties

# shell variables
block=/dev/block/platform/soc/7824900.sdhci/by-name/boot;
is_slot_device=0;
ramdisk_compression=gz;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;
# set init clarity as executable script
chmod 755 $ramdisk/init.clarity.sh;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.rc

# end ramdisk changes

write_boot;
## end install

