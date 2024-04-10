#!/bin/bash

# For a Becode Project a script that write that can be used for a weekly report

RECIPIENT="samiaibeche@gmail.com"

LOG_FILE="/var/log/system_performance.log"

# Define the report file
REPORT_FILE="/var/log/weekly_system_report.txt"

# Compile the report
echo "Weekly System Performance Report for $(date +"%Y-%m-%d")" > "$REPORT_FILE"
echo "============================================================" >> "$REPORT_FILE"
cat "LOG_FILE" >> "$REPORT_FILE"

# Send the report via email
mail -s "Weekly System Report for $(hostname)" "$RECIPIENT" < "$REPORT_FILE"

# WIP - Clear the data file for the next week
> "LOG_FILE"
