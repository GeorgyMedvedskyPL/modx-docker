sleep 10

TABLES=$(mysql -h mysql -u root -prootpassword modx_db -e "SHOW TABLES" | wc -l)
if [ "$TABLES" -gt 0 ]; then
    echo "🔄 Creating actual dump DB..."
    mysqldump -h mysql -u root -prootpassword modx_db > /backup/latest.sql
    echo "✅ Dump is completed: /backup/latest.sql"
fi