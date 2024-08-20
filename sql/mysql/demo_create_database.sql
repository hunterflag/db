-- ANSI.SQL (預設)
-- ORACLE
-- MySQL
-- SQL Server
/* 慣用:
	1. 關鍵字: 不區分大小寫, 習慣統一用一種; ORACLE 全大寫、或 MySQL 全小寫
    2. 自訂名稱: 全小寫, 以 _ 分隔 (搭配 myBatis), , 不宜使用 駝峰式
*/

DROP DATABASE IF EXISTS lab_db;
CREATE DATABASE IF NOT EXISTS lab_db;
USE lab_db;
SHOW TABLE STATUS;
