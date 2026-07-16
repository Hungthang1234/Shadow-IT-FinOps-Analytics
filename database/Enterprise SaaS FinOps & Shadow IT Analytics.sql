-- 1. Khởi tạo Database
DROP DATABASE IF EXISTS FinOps_ShadowIT;
CREATE DATABASE FinOps_ShadowIT;
USE FinOps_ShadowIT;
-- 2. Tạo bảng Danh mục phần mềm
CREATE TABLE SaaS_Catalog (
    AppID INT PRIMARY KEY,
    AppName VARCHAR(100),
    Category VARCHAR(50),
    ApprovedStatus VARCHAR(20),
    MonthlyCostPerUser DECIMAL(10, 2)
);
-- 3. Tạo bảng Nhân sự
CREATE TABLE HR_Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    Role VARCHAR(50),
    Status VARCHAR(20)
);
CREATE TABLE SSO_Login_Log (
LogID INT Primary key auto_increment,
EmpID int,
AppID int,
Timestamp Datetime,
ActionType varchar(100),
Foreign key (EmpID) References HR_Employees(EmpID),
foreign key (AppID) references SaaS_Catalog(AppID)
);
-- thêm dữ liệu 
INSERT INTO SaaS_Catalog (AppID, AppName, Category, ApprovedStatus, MonthlyCostPerUser)
VALUES 
    (1, 'Microsoft 365', 'Productivity', 'Approved', 20.00),
    (2, 'Zoom', 'Communication', 'Approved', 15.00),
    (3, 'Jira', 'Project Management', 'Approved', 10.00),
    (4, 'Canva Pro', 'Design', 'Unapproved', 12.00), -- Shadow IT
    (5, 'Slack', 'Communication', 'Approved', 8.00);
-- kiểm tra dữ liệu
Select *
from SaaS_Catalog;
-- 1. Tạm tắt chế độ bảo vệ (Safe Updates)
SET SQL_SAFE_UPDATES = 0;

-- 2. Xóa sạch dữ liệu (Xóa bảng con log trước, bảng cha nhân sự sau)
DELETE FROM sso_login_log;
DELETE FROM hr_employees;

-- 3. Bật lại chế độ bảo vệ cho an toàn
SET SQL_SAFE_UPDATES = 1;
-- Sinh dữ liệu Nhân sự

DELIMITER //

DROP PROCEDURE IF EXISTS GenerateEmployees //

CREATE PROCEDURE GenerateEmployees()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 200 DO
        INSERT INTO hr_employees (EmpID, FullName, Department, Role, Status)
        VALUES (
            i,
            CONCAT('Employee_', i),
            -- Trộn ngẫu nhiên phòng ban
            ELT(FLOOR(1 + (RAND() * 5)), 'Marketing', 'IT', 'Sales', 'HR', 'Finance'),
            -- Trộn ngẫu nhiên chức vụ
            ELT(FLOOR(1 + (RAND() * 3)), 'Manager', 'Specialist', 'Staff'),
            -- 5% nhân viên đã nghỉ việc
            IF(RAND() > 0.05, 'Active', 'Resigned')
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

-- Gọi thủ tục để tạo nhân viên
CALL GenerateEmployees();

-- Lưu vĩnh viễn
COMMIT;

-- Sinh Nhật ký hoạt động có chứa kịch bản Shadow IT
DELIMITER //

DROP PROCEDURE IF EXISTS GenerateLoginLogs //

CREATE PROCEDURE GenerateLoginLogs()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_emp INT;
    DECLARE current_dept VARCHAR(50);
    DECLARE current_status VARCHAR(20);
    DECLARE login_count INT;
    DECLARE j INT;
    
    -- Lấy tổng số nhân viên hiện có
    SELECT MAX(EmpID) INTO max_emp FROM hr_employees;
    
    WHILE i <= max_emp DO
        SELECT Department, Status INTO current_dept, current_status 
        FROM hr_employees WHERE EmpID = i;
        
        -- Chỉ sinh log cho nhân viên đang làm việc (Active)
        IF current_status = 'Active' THEN
            
            -- 1. Sinh log cho Microsoft 365 (Sử dụng bình thường)
            SET login_count = FLOOR(5 + (RAND() * 35));
            SET j = 1;
            WHILE j <= login_count DO
                INSERT INTO sso_login_log (EmpID, AppID, Timestamp, ActionType)
                VALUES (i, 1, DATE_ADD('2026-04-01 08:00:00', INTERVAL FLOOR(RAND() * 90) DAY), 'Edit_Document');
                SET j = j + 1;
            END WHILE;

            -- 2. Sinh log cho Zoom (Họp trực tuyến)
            SET login_count = FLOOR(2 + (RAND() * 15));
            SET j = 1;
            WHILE j <= login_count DO
                INSERT INTO sso_login_log (EmpID, AppID, Timestamp, ActionType)
                VALUES (i, 2, DATE_ADD('2026-04-01 08:30:00', INTERVAL FLOOR(RAND() * 90) DAY), 'Join_Meeting');
                SET j = j + 1;
            END WHILE;

            -- 3. Sinh log Shadow IT cho phòng Marketing (Sử dụng Canva Pro trái phép)
            IF current_dept = 'Marketing' AND RAND() > 0.2 THEN
                SET login_count = FLOOR(10 + (RAND() * 20));
                SET j = 1;
                WHILE j <= login_count DO
                    INSERT INTO sso_login_log (EmpID, AppID, Timestamp, ActionType)
                    VALUES (i, 4, DATE_ADD('2026-04-01 09:00:00', INTERVAL FLOOR(RAND() * 90) DAY), 'Export_Design');
                    SET j = j + 1;
                END WHILE;
            END IF;
            
        END IF;
        
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

-- Thực thi thủ tục để sinh log vào bảng
CALL GenerateLoginLogs();

-- Lưu toàn bộ log vĩnh viễn
COMMIT;
-- kiểm tra dữ liệu 
SELECT COUNT(*) FROM hr_employees;
CALL GenerateLoginLogs();
COMMIT;
SELECT COUNT(*) FROM sso_login_log;
-- Thêm bảng Hóa đơn
CREATE TABLE saas_invoices (
    InvoiceID VARCHAR(50) PRIMARY KEY,
    InvoiceDate DATE,
    AppID INT,
    TotalLicenses INT,
    TotalAmount DECIMAL(12, 2),
    PaidByDepartment VARCHAR(50),
    FOREIGN KEY (AppID) REFERENCES saas_catalog(AppID)
);

-- Thêm một vài dòng dữ liệu giả lập (đại diện cho dữ liệu LLM sẽ bóc tách được)
INSERT INTO saas_invoices (InvoiceID, InvoiceDate, AppID, TotalLicenses, TotalAmount, PaidByDepartment)
VALUES 
    ('INV-202604-M365', '2026-04-05', 1, 150, 3000.00, 'IT'),
    ('INV-202604-ZOOM', '2026-04-10', 2, 100, 1500.00, 'IT'),
    ('INV-202604-CANVA', '2026-04-12', 4, 30, 360.00, 'Marketing'); -- Hóa đơn Shadow IT do Marketing tự trả

COMMIT;
-- kiểm tra dữ liệu 
select * from saas_invoices;
-- Tạo View (Khung nhìn) cho Power BI 

CREATE OR REPLACE VIEW vw_user_software_activity AS
SELECT 
    e.EmpID,
    e.FullName,
    e.Department,
    e.Status,
    c.AppName,
    c.ApprovedStatus,
    c.MonthlyCostPerUser,
    COUNT(l.LogID) AS TotalLogins,
    MAX(l.Timestamp) AS LastLoginDate
FROM hr_employees e
JOIN sso_login_log l ON e.EmpID = l.EmpID
JOIN saas_catalog c ON l.AppID = c.AppID
GROUP BY 
    e.EmpID, e.FullName, e.Department, e.Status, c.AppName, c.ApprovedStatus, c.MonthlyCostPerUser;
SELECT * FROM vw_user_software_activity;
-- Viết Stored Procedure báo cáo nhanh Lãng Phí
DELIMITER //

DROP PROCEDURE IF EXISTS sp_ReportShadowIT_Cost //

CREATE PROCEDURE sp_ReportShadowIT_Cost()
BEGIN
    SELECT 
        e.Department AS 'Phòng Ban',
        c.AppName AS 'Phần mềm',
        COUNT(DISTINCT e.EmpID) AS 'Số người dùng lậu',
        SUM(c.MonthlyCostPerUser) AS 'Opex Lãng phí/Tháng ($)'
    FROM hr_employees e
    JOIN sso_login_log l ON e.EmpID = l.EmpID
    JOIN saas_catalog c ON l.AppID = c.AppID
    WHERE c.ApprovedStatus = 'Unapproved'
    GROUP BY e.Department, c.AppName
    ORDER BY SUM(c.MonthlyCostPerUser) DESC;
END //

DELIMITER ;
CALL sp_ReportShadowIT_Cost();
-- Kiểm tra "sức khỏe" dữ liệu (Data Quality Check)
-- 1. Kiểm tra tổng quát số lượng
SELECT 
    (SELECT COUNT(*) FROM hr_employees) AS Total_Employees,
    (SELECT COUNT(*) FROM sso_login_log) AS Total_Logs;

-- 2. Kiểm tra xem View tổng hợp đã hoạt động trơn tru chưa
SELECT * FROM vw_user_software_activity LIMIT 10;

-- 3. Kiểm tra kịch bản Shadow IT (Phải có dòng trả về phòng Marketing dùng Canva)
SELECT Department, AppID, ActionType, COUNT(*) as Total_Actions
FROM sso_login_log l
JOIN hr_employees e ON l.EmpID = e.EmpID
WHERE AppID = 4 
GROUP BY Department, AppID, ActionType;