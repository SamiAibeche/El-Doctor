#!/bin/bash

# For a Becode Project a script that write in a log file that will be used for a weekly report

# Define the file where data will be stored
DATA_FILE="/scripts/var/log/system_performance.log"

# Append data to the file
{
    echo "Timestamp: $(date)"
    echo "System Uptime:"
    uptime
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -h
    echo "Top Processes:"
    ps -eo %cpu,%mem,cmd --sort=-%cpu | head
    echo "---------------------------------"
} >> "$DATA_FILE"
