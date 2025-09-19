echo "👀 Мониторинг изменений БД MODX..."

# Ждем запуска MySQL
sleep 10

PREV_CHECKSUM=""
while true; do
    # Получаем текущий чексумм структуры БД
    CURRENT_CHECKSUM=$(mysql -h mysql -u root -prootpassword modx_db -e "
        SELECT 
            MD5(GROUP_CONCAT(
                CONCAT_WS('|', TABLE_NAME, COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_DEFAULT)
                ORDER BY TABLE_NAME, ORDINAL_POSITION
            )) 
        FROM information_schema.COLUMNS 
        WHERE TABLE_SCHEMA = 'modx_db'
    " -s 2>/dev/null)
    
    if [ "$CURRENT_CHECKSUM" != "$PREV_CHECKSUM" ] && [ "$PREV_CHECKSUM" != "" ]; then
        echo "🔄 Обнаружены изменения в структуре БД"
        mysqldump -h mysql -u root -prootpassword modx_db > /backup/latest.sql
        echo "✅ Дамп обновлен: /backup/latest.sql"
    fi
    
    PREV_CHECKSUM="$CURRENT_CHECKSUM"
    sleep 60  # Проверяем каждую минуту
done