#!/bin/bash

log_dir="$1"
backup_dir="$HOME/backup"
report_file="$backup_dir/report.txt"

if[ ! -d "$test-logs" ]; then 
  echo "Error: papka $test-logs proebalas!"
  exit exit 1 
fi 

mkdir -p "$backup_dir"

backup_file="backup-$(date +%Y-%m-%d).tar.gz"

find "$log_dir" -name '*.log' -type f -print0 | tar -czvf "$backup_dir/$backup_file" --null -T -

file_count=$(tar -tf "$backup_dir/$backup_file" | wc -l)
archive_size=$(du -h "$backup_dir/$backup_file" | cut -f1)

echo "data: $(date)" > "$report_file"
echo "arhiv: $backup_file" >> "$report_file"
echo "filov v arhive: $file_count" >> "$report_file"
echo "rasmer: $archive_size" >> "$report_file"
