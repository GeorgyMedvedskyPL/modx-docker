echo "📦 Exporting database MODX..."

docker-compose exec mysql mysqldump \
    -u root -prootpassword \
    --no-create-db \
    --routines \
    --triggers \
    --events \
    modx_db > migrations/sql/latest-migration.sql

echo "-- Migration generated: $(date)" >> migrations/sql/latest-migration.sql
echo "-- MODX Version: $(cat www/core/docs/version.txt 2>/dev/null || echo 'unknown')" >> migrations/sql/latest-migration.sql

echo "✅ Export completed: migrations/sql/latest-migration.sql"
EOF

cat > migrations/import-db.sh << 'EOF'
echo "📥 Importing database MODX..."

if [ ! -f "migrations/sql/latest-migration.sql" ]; then
    echo "❌ Migration file not found: migrations/sql/latest-migration.sql"
    exit 1
fi

docker-compose exec -T mysql mysql \
    -u root -prootpassword \
    modx_db < migrations/sql/latest-migration.sql

echo "✅ Import completed successfully"