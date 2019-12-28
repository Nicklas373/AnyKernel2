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
supported.versions=10
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/soc/7824900.sdhci/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# end ramdisk changes

write_boot;
## end install

