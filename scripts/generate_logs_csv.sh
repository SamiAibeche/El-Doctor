#!/bin/bash

# For a BeCode project, make a report to export in a CSV File

CSV_FILE="./system_health_data.csv"

# Check if CSV file exists
if [ ! -f "$CSV_FILE" ]; then
    echo "Date,Time,CPU Load (%),Memory Free (MB),Disk Usage (%),Top Process" > "$CSV_FILE"
fi

# Collect data
DATE=$(date "+%Y-%m-%d")
TIME=$(date "+%H:%M:%S")
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEMORY_FREE=$(free -m | grep Mem | awk '{print $4}')
DISK_USAGE=$(df / | grep / | awk '{ print $5 }')
TOP_PROCESS=$(ps -eo %cpu,command --sort=-%cpu | head -n 2 | tail -n 1 | awk '{$1=""; print $0}')

# Append data to CSV
echo "$DATE,$TIME,$CPU_LOAD,$MEMORY_FREE,$DISK_USAGE,\"$TOP_PROCESS\"" >> "$CSV_FILE"
