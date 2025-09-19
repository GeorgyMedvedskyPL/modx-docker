-- Создаем базу данных для MODX
CREATE DATABASE IF NOT EXISTS modx_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Создаем пользователя для MODX
CREATE USER IF NOT EXISTS 'modx_user'@'%' IDENTIFIED BY 'modx_password';

-- Даем пользователю все права на базу данных MODX
GRANT ALL PRIVILEGES ON modx_db.* TO 'modx_user'@'%';

-- Применяем изменения прав
FLUSH PRIVILEGES;

-- Создаем тестовую таблицу для проверки (опционально)
-- USE modx_db;
-- CREATE TABLE IF NOT EXISTS test_table (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(50) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
