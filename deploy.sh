echo "🚀 Launching MODX..."

docker-compose down
docker-compose up -d
sleep 10

if [ -f "migrations/sql/latest-migration.sql" ]; then
    ./migrations/import-db.sh
else
    echo "ℹ️ Migration file not found, starting a clean install"
fi

echo "✅ Deployment complete! The project is available at http://localhost"