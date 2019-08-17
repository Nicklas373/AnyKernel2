#!/system/bin/sh
# Clarity Kernel Tweaks And Parameters

# Allows us to get init-rc-like style
write() { echo "$2" > "$1"; }

# Only apply this when boot is completed
if [[ $(getprop sys.boot_completed) -eq 1 ]]; then

# SchedTune Permissions
for group in background foreground rt top-app; do
         chmod 0644 /dev/stune/$group/*
    done

# CPU Values
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 652800
write /sys/devices/system/cpu/cpufreq/schedutil/iowait_boost_enable 0

# Power Efficient Workqueue
chmod 0644 /sys/module/workqueue/parameters/power_efficient
write /sys/module/workqueue/parameters/power_efficient Y

# GPU Values
write /sys/class/kgsl/kgsl-3d0/devfreq/governor "msm-adreno-tz"
write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000

# Switch to CFQ I/O scheduler
write /sys/block/mmcblk0/queue/scheduler cfq
write /sys/block/mmcblk1/queue/scheduler cfq

# Disable slice_idle on supported block devices
for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
    write /sys/block/$block/queue/iosched/slice_idle 0
done

# Set read ahead to 128 kb for internal & 512kb for storage
write /sys/block/mmcblk0/queue/read_ahead_kb 128
write /sys/block/mmcblk1/queue/read_ahead_kb 512

fi
