CREATE DATABASE IF NOT EXISTS modx_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'modx_user'@'%' IDENTIFIED BY 'modx_password';

GRANT ALL PRIVILEGES ON modx_db.* TO 'modx_user'@'%';

FLUSH PRIVILEGES;
