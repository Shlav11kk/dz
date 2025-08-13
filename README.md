# 🐉 Логовый Хранитель | Backup Guardian Script

![Backup Guardian](https://yandex.kz/images/search?img_url=https%3A%2F%2Fi0.wp.com%2Fwww.pngfind.com%2Fpngs%2Fm%2F395-3953305_water-dragon-dragon-boss-pixel-art-hd-png.png&lr=213&pos=3&rpt=simage&text=simple%20pixel%20art%20dragon) <!-- Замени ссылку на реальный пиксель-арт -->

> _"Да пребудут твои логи в безопасности!"_ ✨

## 🌟 Особенности
```bash
- 📦 Автоматическое резервное копирование .log файлов
- 🗓️ Умное именование архивов с датой (backup-YYYY-MM-DD.tar.gz)
- 📊 Генерация отчетов с размером и количеством файлов
- 🛡️ Проверки ошибок на каждом этапе
- 🎯 Простота использования - один скрипт для всех задач

# 1. Скачай скрипт
wget https://your-domain.com/backup_logs.sh

# 2. Дай права на выполнение
chmod +x backup_logs.sh

# 3. Создай тестовую папку с логами
mkdir -p logs
echo "Тестовый лог" > logs/system.log

# 4. Запусти скрипт!
./backup_logs.sh


( •̀ ω •́ )✧ Запускаю резервное копирование...
[===               ] 20% - Поиск логов...
[=======           ] 50% - Архивирование...
[==============    ] 80% - Создание отчета...
[==================] 100% - Готово!

✅ Бэкап успешно создан: ~/backup/backup-2025-08-11.tar.gz
📊 Отчет сохранен: ~/backup/report.txt
