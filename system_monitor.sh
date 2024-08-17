#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name:     system_monitor.sh
# Description:     This script monitors system resources such as CPU, memory,
#                  and disk usage. If the CPU, Memory, and Disk usage is more
#                  than the threshold then it shows the actual usage in the 
#                  standard output.
#
# Maintainer:      Piyush Bagani (piyushbagani15@gmail.com)
# Date:            August 17, 2024
# Version:         1.0
# -----------------------------------------------------------------------------

# Set the debug mode and error mode
set -xe 
set -o pipefail

# Set thresholds for CPU, memory, and disk usage
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90

# Check CPU usage
# Extract the CPU usage from the 'top' command output and compare it with the threshold
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "High CPU usage: $CPU_USAGE%"
fi

# Check memory usage
# Extract memory usage using the 'free' command and compare it with the threshold
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
    echo "High Memory usage: $MEM_USAGE%" 
fi

# Check disk usage
# Get the disk usage percentage of the root directory and compare it with the threshold
DISK_USAGE=$(df -h / | grep / | awk '{ print $5 }' | sed 's/%//g')
if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
    echo "High Disk usage: $DISK_USAGE%"
fi

# End of script
