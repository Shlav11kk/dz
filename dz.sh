#!/bin/bash

#ass
log_dir="logs"
backup_dir="$HOME/backup"
report_file="$backup_dir/report.txt"
backup_file="backup-$(date +%Y-%m-%d).tar.gz"
EMAIL=""
USE_INTARAKTIVE_EMAIL=true

send_email_report() {
  local email_to=$1
  if [ -n "$email_to" ] && command -v mail &> /dev/null; then
            if mail -s "Backup Report $(date +%F)" "$email_to" < "$report_file"; then  
            echo "Report sent to: $email_to"
        else
            echo "Error sending to: $email_to" >&2
        fi
    elif [ -n "$email_to" ]; then
        echo "Mail client not installed" >&2
    fi  
}


if [ "$#" -eq 1 ]; then 
    log_dir="$1"
elif [ "$#" -gt 1 ]; then 
    echo "Usage: $0 [log_dir]" >&2
    exit 1
fi 


if [ ! -d "$log_dir" ]; then 
    echo "Error: Directory '$log_dir' does not exist!" >&2
    exit 1 
fi 


log_files=$(find "$log_dir" -name '*.log' -type f | wc -l)  
if [ "$log_files" -eq 0 ]; then
    echo "Warning: No log files in '$log_dir'" >&2 
fi


mkdir -p "$backup_dir" || {
    echo "Error: Failed to create backup directory '$backup_dir'" >&2 
    exit 1
}


counter=1
original_name="$backup_file"
while [ -f "$backup_dir/$backup_file" ]; do
    backup_file="${original_name%.*}_$counter.tar.gz" 
    counter=$((counter+1))
done


if ! find "$log_dir" -name '*.log' -type f -print0 | tar -czvf "$backup_dir/$backup_file" --null -T -; then 
    echo "Error: Failed to create backup archive" >&2  # Fixed typo
    exit 1
fi


file_count=$(tar -tf "$backup_dir/$backup_file" | wc -l)
archive_size=$(du -h "$backup_dir/$backup_file" | awk '{print $1}')
{
    echo "=== Backup Report ==="
    echo "Date: $(date +"%Y-%m-%d %H:%M:%S")"
    echo "Archive: $backup_file"  
    echo "Files in archive: $file_count"
    echo "Size: $archive_size"  
} > "$report_file" || {
    echo "Error: Failed to create report file" >&2  
    exit 1
}

echo "Backup completed successfully. Report: $report_file"


for arg in "$@"; do 
    if [[ "$arg" == "--email="* ]]; then
        EMAIL="${arg#*=}"
        echo "Using email from parameter: $EMAIL"
    fi 
done

if [ "$USE_INTERACTIVE_EMAIL" = true ] && [ -z "$EMAIL" ]; then  
    read -p "Send report to email? (leave empty to skip): " user_email  
    if [ -n "$user_email" ]; then
        EMAIL="$user_email"  # Fixed: removed space around =
    fi
fi

if [ -z "$EMAIL" ] && [ -f "$backup_dir/.backup_email" ]; then
    EMAIL=$(head -n 1 "$backup_dir/.backup_email")
    echo "Using saved email: $EMAIL"
fi


if [ -n "$EMAIL" ]; then
    send_email_report "$EMAIL"
    
    # Offer to save email for future use
    if [ ! -f "$backup_dir/.backup_email" ]; then
        read -p "Save this email for future backups? [y/N]: " save_choice
        if [[ "$save_choice" =~ ^[Yy] ]]; then
            echo "$EMAIL" > "$backup_dir/.backup_email"
            echo "Email saved for future use"
        fi
    fi
fi
