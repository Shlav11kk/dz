#!/bin/bash

# Создаем папку для логов
mkdir -p test-logs

# Генерация app.log (логи приложения)
for i in {1..50}; do
  timestamp=$(date -d "-$((RANDOM % 10)) days -$((RANDOM % 24)) hours -$((RANDOM % 60)) minutes" "+%Y-%m-%d %H:%M:%S")
  log_level=("INFO" "WARN" "ERROR")
  random_level=${log_level[$RANDOM % ${#log_level[@]}]}
  
  case $random_level in
    "INFO")
      echo "[$timestamp] INFO: User action completed successfully - sessionID: $RANDOM" >> logs/app.log
      ;;
    "WARN")
      echo "[$timestamp] WARN: Resource usage high - memory: $((70 + RANDOM % 30))%" >> logs/app.log
      ;;
    "ERROR")
      echo "[$timestamp] ERROR: Failed to load module 'payment_gateway' - retrying ($((RANDOM % 3 + 1))/3" >> logs/app.log
      ;;
  esac
done

# Генерация server.log (логи сервера)
for i in {1..50}; do
  timestamp=$(date -d "-$((RANDOM % 5)) days -$((RANDOM % 24)) hours" "+%Y-%m-%d %H:%M:%S")
  ip="192.168.$((RANDOM % 256)).$((RANDOM % 256))"
  method=("GET" "POST" "PUT" "DELETE")
  endpoint=("/api/users" "/products" "/orders" "/auth/login" "/payment/process")
  status=("200" "404" "500" "302" "401")
  
  echo "$timestamp $ip ${method[$RANDOM % 5]} ${endpoint[$RANDOM % 5]} HTTP/1.1 ${status[$RANDOM % 5]} $((RANDOM % 1500))ms" >> logs/server.log
done

# Генерация dB.log (логи базы данных)
for i in {1..30}; do
  timestamp=$(date -d "-$((RANDOM % 2)) days -$((RANDOM % 12)) hours" "+%Y-%m-%d %H:%M:%S")
  operation=("SELECT" "INSERT" "UPDATE" "DELETE")
  table=("users" "products" "orders" "transactions")
  
  echo "[$timestamp] DB ${operation[$RANDOM % 4]} on ${table[$RANDOM % 4]} completed in $((10 + RANDOM % 500))ms" >> logs/dB.log
done

echo "Файлы логов успешно созданы в папке logs!"
