#!/system/bin/sh
# Clarity Kernel Tweaks And Parameters

# Allows us to get init-rc-like style
write() { echo "$2" > "$1"; }

# CPU Values
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 652000
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "schedutil"
write /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us 500
write /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us 20000
write /sys/devices/system/cpu/cpufreq/schedutil/iowait_boost_enable 0

# Power Efficient Workqueue
chmod 0644 /sys/module/workqueue/parameters/power_efficient
write /sys/module/workqueue/parameters/power_efficient Y

# set default schedTune value for foreground/top-app (Only Affect on EAS Based ROM)
write /dev/stune/background/schedtune.prefer_idle 0
write /dev/stune/foreground/schedtune.prefer_idle 0
write /dev/stune/schedtune.boost 0
write /dev/stune/rt/schedtune.prefer_idle 0
write /dev/stune/top-app/schedtune.prefer_idle 0
write /dev/stune/top-app/schedtune.boost 0
write /dev/stune/foreground/schedtune.boost 0
write /dev/stune/schedtune.prefer_idle 0
write /dev/cpuset/background/cpus "0-7"
write /dev/cpuset/foreground/cpus "0-7"
write /dev/cpuset/restricted/cpus "0-7"
write /dev/cpuset/system-background/cpus "0-7"
write /dev/cpuset/top-app/cpus "0-7"

# GPU Values
write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 0
write /sys/class/kgsl/kgsl-3d0/devfreq/governor "msm-adreno-tz"
write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000

# Thermal Engine
chmod 0644 /sys/module/msm_thermal/parameters/enabled
write /sys/module/msm_thermal/parameters/enabled 1
chmod 0644 /sys/module/msm_thermal/core_control/enabled
write /sys/module/msm_thermal/core_control/enabled 0
chmod 0644 /sys/module/msm_thermal/vdd_restriction/enabled
write /sys/module/msm_thermal/vdd_restriction/enabled 0
write /sys/module/msm_thermal/parameters/core_limit_temp_degC 70
write /sys/module/msm_thermal/parameters/temp_threshold 60
write /sys/module/msm_thermal/parameters/poll_ms 1000

# Battery
write /sys/kernel/fast_charge/force_fast_charge 0
write /sys/class/power_supply/battery/allow_hvdcp3 0

# Set 128 KB readahead value for external storage
write /sys/block/mmcblk1/queue/read_ahead_kb 128

# Switch to CFQ I/O scheduler
setprop sys.io.scheduler cfq

# Disable slice_idle on supported block devices
for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
    write /sys/block/$block/queue/iosched/slice_idle 0
done

# Low Memory Killer
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
write /sys/module/process_reclaim/parameters/enable_process_reclaim 0
write /sys/module/lowmemorykiller/parameters/debug_level 0
