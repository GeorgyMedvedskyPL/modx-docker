echo "👀 Monitoring database changes MODX..."

PREV_CHECKSUM=""
while true; do
    CURRENT_CHECKSUM=$(docker-compose exec mysql mysql -u root -prootpassword modx_db -e "
        SELECT 
            MD5(GROUP_CONCAT(
                CONCAT_WS('|', TABLE_NAME, COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_DEFAULT)
                ORDER BY TABLE_NAME, ORDINAL_POSITION
            )) 
        FROM information_schema.COLUMNS 
        WHERE TABLE_SCHEMA = 'modx_db'
    " -s)
    
    if [ "$CURRENT_CHECKSUM" != "$PREV_CHECKSUM" ] && [ "$PREV_CHECKSUM" != "" ]; then
        echo "🔄 Changes in the structure were detected"
        ./migrations/export-db.sh
    fi
    
    PREV_CHECKSUM="$CURRENT_CHECKSUM"
    sleep 60
done