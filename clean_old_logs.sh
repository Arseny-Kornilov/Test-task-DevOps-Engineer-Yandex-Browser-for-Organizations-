!/bin/bash

if [ $# -ne 2 ]; then
    echo "Использование: $0 /путь/к/директории количество_дней"
    exit 1
fi

LOG_DIR="$1"
DAYS="$2"

if [ ! -d "$LOG_DIR" ]; then
    echo "Директория '$LOG_DIR' не существует"
    exit 1
fi

OLD_LOGS=$(find "$LOG_DIR" -maxdepth 1 -type f -name "*.log" -mtime +"$DAYS")

if [ -z "$OLD_LOGS" ]; then
    echo "Файлы не найдены"
    exit 0
fi

echo "Найдены файлы:"
echo "$OLD_LOGS"
echo ""
read -p "Удалить эти файлы? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$OLD_LOGS" | xargs rm -f
    echo "Файлы удалены"
fi
