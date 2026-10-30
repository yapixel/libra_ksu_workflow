# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Kernel
kernel.branch=lineage-18.1 branch
kernel.compiler=clang
kernel.ksuver=v2.0.0+
kernel.cpuoc=??
kernel.gpuoc=??
kernel.memoc=??
kernel.made=xx
message.word=AnyKernel3
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=libra
device.name2=aqua
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

mount -o remount,rw /vendor

# Check if old scripts are present, if so remove them
sed -i '/revvz_exec/d' /vendor/bin/init.qcom.sh 2>/dev/null || true
sed -i '/revvz_exec/d' /vendor/bin/init.qcom.post_boot.sh 2>/dev/null || true
sed -i '/sleepy_exec.sh/d' /vendor/bin/init.qcom.sh 2>/dev/null || true
sed -i '/sleepy_exec.sh/d' /vendor/bin/init.qcom.post_boot.sh 2>/dev/null || true
rm -rf /vendor/bin/revvz_exec.sh /vendor/bin/sleepy_exec.sh 2>/dev/null || true

## AnyKernel boot install
dump_boot;
write_boot;
## end boot install
