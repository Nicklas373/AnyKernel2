#!/system/bin/sh
# Clarity Kernel Tweaks And Parameters

# Allows us to get init-rc-like style
write() { echo "$2" > "$1"; }

# set default schedTune value for foreground/top-app (Syberia Prop Override)
write /dev/stune/top-app/schedtune.boost 1

# CPU Values
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
write /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us 500
write /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us 20000
write /sys/devices/system/cpu/cpufreq/schedutil/iowait_boost_enable 0

# Power Efficient Workqueue
chmod 0644 /sys/module/workqueue/parameters/power_efficient
write /sys/module/workqueue/parameters/power_efficient Y

# GPU Values
write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 0
write /sys/class/kgsl/kgsl-3d0/devfreq/governor "msm-adreno-tz"
write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000

# Battery
write /sys/class/power_supply/battery/allow_hvdcp3 0

# Switch to CFQ I/O scheduler
setprop sys.io.scheduler bfq
