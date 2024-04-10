#!/bin/bash

# For a BeCode project, we monitor automatically the system health status, and alert the administrator if limit is almost reached

MEMORY_THRESHOLD=500  # MB
DISK_THRESHOLD=80     # %
CPU_THRESHOLD=70      # %

SUBJECT="System Alert on $(hostname)"
TO="samiaibeche@gmail.com"
BODY=""

# Check memory
FREE_MEMORY=$(free -m | grep -i mem | awk '{print $4}')
if [ "$FREE_MEMORY" -lt "$MEMORY_THRESHOLD" ]; then
    BODY+="Warning: Memory is running low. Free memory: ${FREE_MEMORY} MB\n"
fi

# Check disk usage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    BODY+="Warning: Disk usage is high. Usage: ${DISK_USAGE}%\n"
fi

# Check CPU load
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
if (( $(echo "$CPU_LOAD > $CPU_THRESHOLD" | bc -l) )); then
    BODY+="Warning: CPU load is high. Current load: ${CPU_LOAD}%\n"
fi

# Send email if any thresholds were exceeded
if [ ! -z "$BODY" ]; then
    echo -e "$BODY" | mail -s "$SUBJECT" "$TO"
fi
