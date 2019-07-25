#!/system/bin/sh
# Clarity Kernel Tweaks And Parameters

# Allows us to get init-rc-like style
write() { echo "$2" > "$1"; }

# CPU Values
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
write /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us 500
write /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us 20000
write /sys/devices/system/cpu/cpufreq/schedutil/iowait_boost_enable 0

# Power Efficient Workqueue
chmod 0644 /sys/module/workqueue/parameters/power_efficient
write /sys/module/workqueue/parameters/power_efficient Y

# Thermal Engine (Intelli Thermal v3)
chmod 0644 /sys/module/msm_thermal/parameters/enabled
write /sys/module/msm_thermal/parameters/enabled 1
chmod 0644 /sys/module/msm_thermal/core_control/enabled
write /sys/module/msm_thermal/core_control/enabled 0
chmod 0644 /sys/module/msm_thermal/vdd_restriction/enabled
write /sys/module/msm_thermal/vdd_restriction/enabled 0
write /sys/module/msm_thermal/parameters/core_limit_temp_degC 70
write /sys/module/msm_thermal/parameters/limit_temp_degc 60
write /sys/module/msm_thermal/parameters/temp_threshold 55
write /sys/module/msm_thermal/parameters/poll_ms 500

# GPU Values
write /sys/class/kgsl/kgsl-3d0/devfreq/governor "msm-adreno-tz"
write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000

# Switch to CFQ I/O scheduler
setprop sys.io.scheduler cfq

# Disable slice_idle on supported block devices
for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
    write /sys/block/$block/queue/iosched/slice_idle 0
done

# Set read ahead to 128 kb for external storage
# The rest are handled by qcom-post-boot
write /sys/block/mmcblk1/queue/read_ahead_kb 128
