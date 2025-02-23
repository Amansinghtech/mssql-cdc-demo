CREATE DATABASE gimbooks;

USE gimbooks;

EXEC sys.sp_cdc_enable_db;

SELECT name, is_cdc_enabled FROM sys.databases;

CREATE TABLE dbo.users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME NULL
);

EXEC sys.sp_cdc_enable_table  
    @source_schema = 'dbo',  
    @source_name   = 'users',  
    @role_name     = NULL;  -- Set a role if needed for access control

EXEC xp_servicecontrol N'QUERYSTATE', 'SQLServerAgent';

EXEC xp_servicecontrol N'START', 'SQLServerAgent';


INSERT INTO gimbooks.dbo.users (username,email,created_at,updated_at) VALUES
	 (N'aman',N'aman@gmail.com','2025-02-23 15:48:22.937',NULL);
