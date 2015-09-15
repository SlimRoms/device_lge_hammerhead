#!/system/bin/sh
#--------------------------------------------------
# Yank555.lu - generated kernel options init script
#--------------------------------------------------

log_file="/data/kernel-boot.log"

echo "----------------------------------------------------" >$log_file
echo "Yank555.lu - execution of kernel options init script" >>$log_file
echo "----------------------------------------------------" >>$log_file
echo "Kernel version : `uname -a`" >>$log_file
echo "Busybox used   : `which busybox`" >>$log_file

echo `date +"%F %R:%S : Checking for Yank555.lu kernel..."` >>$log_file

if [ "`uname -r | grep Yank555.lu`" == "" ]
  then
    echo `date +"%F %R:%S : No Yank555.lu kernel found, skip executing the config file"` >>$log_file
    exit
fi;

echo `date +"%F %R:%S : Yank555.lu kernel found, continue executing the config file..."` >>$log_file

echo `date +"%F %R:%S : Waiting for Android to start..."` >>$log_file

# Wait until we see some android processes to consider boot is more or less complete (credits to AndiP71)
while ! pgrep com.android ; do
  sleep 1
done

echo `date +"%F %R:%S : Android is starting up, let's wait another 10 seconds..."` >>$log_file

# Now that is checked, let's just wait another tiny little bit
sleep 30

echo `date +"%F %R:%S : Starting kernel configuration..."` >>$log_file

#----------------------------------------------------

# - SELinux Enforcine
setenforce 1
echo `date +"%F %R:%S : SELinux set to enforcing."` >>$log_file

# - init.d support by kernel/ramdisk not installed
echo `date +"%F %R:%S : Init.d script execution support disabled."` >>$log_file
ls -al /system/etc/init.d >>$log_file

# Set Userspace DVFS access to ignore
echo 1 > /sys/kernel/cpufreq_hardlimit/userspace_dvfs_lock
echo `date +"%F %R:%S : Userspace DVFS access set to ignore."` >>$log_file

# Set CPU Governor
echo "intellimm" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu1/online
echo "intellimm" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu2/online
echo "intellimm" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu3/online
echo "intellimm" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
# Disable in-governor touchboost
echo "300000,300000,300000,300000" > /sys/devices/system/cpu/cpufreq/intellimm/input_event_min_freq
echo `date +"%F %R:%S : CPU governor set to intellimm by faux123."` >>$log_file

# Set CPU min. screen on frequency
echo 300000 > /sys/kernel/cpufreq_hardlimit/scaling_min_freq_screen_on
echo `date +"%F %R:%S : CPU min. screen on frequency hardlimit set to 0.30GHz."` >>$log_file

# Set CPU min. screen off frequency
echo 300000 > /sys/kernel/cpufreq_hardlimit/scaling_min_freq_screen_off
echo `date +"%F %R:%S : CPU min. screen off frequency hardlimit set to 0.30GHz."` >>$log_file

# Set CPU max. screen on frequency hardlimit
echo 2265600 > /sys/kernel/cpufreq_hardlimit/scaling_max_freq_screen_on
echo `date +"%F %R:%S : CPU max. screen on frequency hardlimit set to 2.26GHz."` >>$log_file

# Set CPU max. screen off frequency hardlimit
echo 1497600 > /sys/kernel/cpufreq_hardlimit/scaling_max_freq_screen_off
echo `date +"%F %R:%S : CPU max. screen off frequency hardlimit set to 1.50GHz."` >>$log_file

# Set CPU min. wakeup kick frequency
echo 1958400 > /sys/kernel/cpufreq_hardlimit/wakeup_kick_freq
echo `date +"%F %R:%S : CPU min. wakeup kick frequency set to 1.96GHz."` >>$log_file

# Set CPU min. wakeup kick delay
echo 2000 > /sys/kernel/cpufreq_hardlimit/wakeup_kick_delay
echo `date +"%F %R:%S : CPU min. wakeup kick delay set to 2 seconds."` >>$log_file

# Set CPU min. touchboost delay
echo 750 > /sys/kernel/cpufreq_hardlimit/touchboost_delay
echo `date +"%F %R:%S : CPU min. touchboost delay set to 0.75 seconds."` >>$log_file

# Set CPU min. touchboost eventcount
echo 3 > /sys/kernel/cpufreq_hardlimit/touchboost_eventcount
echo `date +"%F %R:%S : CPU min. touchboost eventcount set to 3."` >>$log_file

# Set CPU touchboost low frequency
echo 883200 > /sys/kernel/cpufreq_hardlimit/touchboost_lo_freq
echo `date +"%F %R:%S : CPU min. touchboost low frequency set to 0.88GHz."` >>$log_file

# Set CPU touchboost high frequency
echo 1267200 > /sys/kernel/cpufreq_hardlimit/touchboost_hi_freq
echo `date +"%F %R:%S : CPU min. touchboost high frequency set to 1.27GHz."` >>$log_file

# Set CPU Hotplug driver
stop mpdecision
echo 1 > /sys/module/intelli_plug/parameters/intelli_plug_active
echo 0 > /sys/module/intelli_plug/parameters/touch_boost_active
echo `date +"%F %R:%S : CPU Hotplug driver set to IntelliPlug."` >>$log_file

# Set CPU Hotplug driver
echo 2 > /sys/module/intelli_plug/parameters/nr_run_profile_sel
echo `date +"%F %R:%S : IntelliPlug Profile set to Conservative."` >>$log_file

# Set CPU Hotplug driver
echo 8 > /sys/module/intelli_plug/parameters/nr_run_hysteresis
echo `date +"%F %R:%S : IntelliPlug Hysteresis set to average (8)."` >>$log_file

# Set CPU Hotplug driver
echo 1000 > /sys/module/intelli_plug/parameters/cpu_nr_run_threshold
echo `date +"%F %R:%S : IntelliPlug Runqueue Threshold set to fast (1000)."` >>$log_file

# Set CPU Thermal driver
stop thermal-engine
echo 1 > /sys/module/msm_thermal_v2/parameters/enabled
echo 12 > /sys/module/msm_thermal_v2/parameters/core_control_mask
echo 15 > /sys/module/msm_thermal_v2/parameters/freq_control_mask
echo `date +"%F %R:%S : CPU Thermal driver set to IntelliThermal."` >>$log_file

# Set CPU Thermal driver
echo 80 > /sys/module/msm_thermal_v2/parameters/limit_temp_degC
echo `date +"%F %R:%S : IntelliThermal Frequency Throttle limit set to 80 degrees."` >>$log_file

# Set CPU Thermal driver
echo 85 > /sys/module/msm_thermal_v2/parameters/core_limit_temp_degC
echo `date +"%F %R:%S : IntelliThermal Core Throttle limit set to 85 degrees."` >>$log_file

# This is now an option in the ROM under Other Sounds settings
# - Vibrator strength
#echo 63 > /sys/class/timed_output/vibrator/amp
#echo `date +"%F %R:%S : Vibrator strength set to normal (63)."` >>$log_file

# - Enable custom current forced fast charge
echo 2 > /sys/kernel/fast_charge/force_fast_charge
echo `date +"%F %R:%S : Fast Charge - Custom Current Mode enabled."` >>$log_file
echo 1000 > /sys/kernel/fast_charge/usb_charge_level
echo `date +"%F %R:%S : Fast Charge - USB charge level set to 1000mA/h."` >>$log_file
echo 1800 > /sys/kernel/fast_charge/ac_charge_level
echo `date +"%F %R:%S : Fast Charge - AC charge level set to 1800mA/h."` >>$log_file

# Wait for everything to become ready
echo `date +"%F %R:%S : Waiting 60 seconds..."` >>$log_file
sleep 60
# Internal MMC readahead buffer size
echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
echo `date +"%F %R:%S : Internal MMC Readahead set to 512Kb."` >>$log_file

# Internal MMC I/O scheduler
echo "fiops" > /sys/block/mmcblk0/queue/scheduler
echo `date +"%F %R:%S : Internal MMC scheduler set to FIOPS."` >>$log_file

# - Enable dynamic deferred file sync (by faux123)
#     While screen is on, file sync is temporarily deferred, when screen
#     is turned off, a flush is called to synchronize all outstanding writes.
#     Turn on powersuspend before starting to use dynamic fsync !
echo 1 > /sys/kernel/dyn_fsync/Dyn_fsync_active
echo `date +"%F %R:%S : Dynamic Deferred File Sync enabled."` >>$log_file

# - zSwap activation - 768Mb
if [ -e /sys/block/vnswap0/disksize ] ; then
  swapoff /dev/block/vnswap0
  echo 805306368 > /sys/block/vnswap0/disksize
  mkswap /dev/block/vnswap0
  swapon /dev/block/vnswap0
fi
echo `date +"%F %R:%S : 768Mb zSwap support enabled."` >>$log_file

# - swappiness set to 80
echo 80 > /proc/sys/vm/swappiness;
echo `date +"%F %R:%S : Swappiness set to 80."` >>$log_file

echo `date +"%F %R:%S : Finished kernel configuration."` >>$log_file

chmod 644 $log_file

#--------------------------------------------------
# End of generated script
#--------------------------------------------------
