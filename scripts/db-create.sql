CREATE DATABASE IF NOT EXISTS shila_dev_d8;
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES
  ON shila_dev_d8.*
  TO 'shila'@'localhost' IDENTIFIED BY 'shila';
