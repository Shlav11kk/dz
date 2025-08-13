#!/bin/bash

#ass 
log_dir="logs"
backup_dir="$HOME/backup"
report_file="$backup_dir/report.txt"
backup_file="backup-$(date +%Y-%m-%d).tar.gz"

if [ ! -d "logs" ]; then 
  echo "Error: Directory logs dose not exist!" >&2
  exit 1 
fi 

mkdir -p "$backup_dir" || {
  echo "Error: Faild to create backup directory '$backup_dir'" >&2 
  exit 1
}

 
if ! find "$log_dir" -name '*.log' -type f -print0 | tar -czvf "$backup_dir/$backup_file" --null -T -; then 
  echo "Error: field create to backup arhive" >&2
  exit 1
fi

file_count=$(tar -tf "$backup_dir/$backup_file" | wc -l)
archive_size=$(du -h "$backup_dir/$backup_file" | awk '{print $1}')
{
echo "=== Backup Report ==="
echo "Date: $(date +"%Y-%m-%d %H:%M:%S")"
echo "Arhive: $backup_file" 
echo "Files in archive: $file_count"
echo "Size $archive_size"
} > "$report_file" || {
echo "Error: to create report_file" >&2
exit 1
}
echo "Backup completed successfully. Report: $report_file"

#fich Support for parameter for log folder "needs some work"
if [ "$#" -eq 1 ]; then 
  log_dir="$1"
elif [ "$#" -eq 1 ]; then 
  echo "Usage: $0 [log_dir]" >&2
  exit 1
fi 

#fich cheking empty logs
log_files=$(find "logs" -name '*.log' -type f | wc -l )
if [ "$log_files" -eq 0 ]; then
  echo "Warning: No log filse in 'logs'" >&2
fi 
