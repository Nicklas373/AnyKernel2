#!/system/bin/sh
# Clarity Kernel Tweaks And Parameters

# Allows us to get init-rc-like style
write() { echo "$2" > "$1"; }

# SchedTune Permissions
for group in background foreground rt top-app audio-app; do
         chmod 0644 /dev/stune/$group/*
    done

# SchedTune
write /dev/stune/top-app/schedtune.boost 0

# Thermal Engine (Intelli Thermal v3)
chmod 0644 /sys/module/msm_thermal/core_control/enabled
write /sys/module/msm_thermal/core_control/enabled 0
chmod 0644 /sys/module/msm_thermal/vdd_restriction/enabled
write /sys/module/msm_thermal/vdd_restriction/enabled 0

# GPU Values
write /sys/class/kgsl/kgsl-3d0/devfreq/governor "msm-adreno-tz"
write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000

# Switch to CFQ I/O scheduler
write /sys/block/mmcblk0/queue/scheduler cfq
write /sys/block/mmcblk1/queue/scheduler cfq

# Battery
write /sys/kernel/fast_charge/force_fast_charge 0

# Disable slice_idle on supported block devices
for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
    write /sys/block/$block/queue/iosched/slice_idle 0
done

# Set read ahead to 128 kb for internal & 512kb for storage
write /sys/block/mmcblk0/queue/read_ahead_kb 128
write /sys/block/mmcblk1/queue/read_ahead_kb 512

# Low Memory Killer
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/process_reclaim/parameters/enable_process_reclaim 0
write /sys/module/lowmemorykiller/parameters/debug_level 0
