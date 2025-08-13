#!/bin/bash

log_dir="logs"
backup_dir="$HOME/backup"
report_file="$backup_dir/report.txt"

if [ ! -d "logs" ]; then 
  echo "Error: Directory logs dose not exist!"
  exit 1 
fi 

mkdir -p "$backup_dir"

backup_file="backup-$(date +%Y-%m-%d).tar.gz"

if ! find "$log_dir" -name '*.log' -type f -print0 | tar -czvf "$backup_dir/$backup_file" --null -T -; then 
  echo "Error: field create to backup arhive" >&2
  exit 1
fi

file_count=$(tar -tf "$backup_dir/$backup_file" | wc -l)
archive_size=$(du -h "$backup_dir/$backup_file" | cut -f1)
{
echo "data: $(date)"
echo "arhiv: $backup_file"
echo "filov v arhive: $file_count"
echo "rasmer: $archive_size"
} > "$Report_file"
