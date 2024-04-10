#!/bin/bash

# For a Becode Project a script that prompt and  export into a txt file the system health status.

# WRITE DATAS

REPORT_FILE="system_health_report.txt"

echo "System Health Report for $(date)" > $REPORT_FILE
echo "---------------------------------" >> $REPORT_FILE

# CPU usage
echo -e "\nCPU Load:" >> $REPORT_FILE
uptime >> $REPORT_FILE

# Memory usage
echo -e "\nMemory Usage:" >> $REPORT_FILE
free -h >> $REPORT_FILE

# Disk usage
echo -e "\nDisk Usage:" >> $REPORT_FILE
df -h >> $REPORT_FILE

# 5 memory consuming processes
echo -e "\nTop 5 Memory-Consuming Processes:" >> $REPORT_FILE
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6 >> $REPORT_FILE

# Check for any failed system services
echo -e "\nFailed System Services:" >> $REPORT_FILE
systemctl --failed >> $REPORT_FILE

# Send the report by mail
#mail -s "System Health Report for $(date)" samiaibeche@gmail.com < $REPORT_FILE

echo "System health report save to $REPORT_FILE"


# DUMP DATAS

echo "System Health Report for $(date)"
echo "---------------------------------"
uptime
free -h
df -h
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
systemctl --failed

echo "System health report also saved to" >> $REPORT_FILE
