CREATE DATABASE InboundInventory
GO

USE InboundInventory
GO

--One-To-Many table - one manager to many employees
CREATE TABLE Managers (
	ManagerID int PRIMARY KEY,
	managerFirstName varchar(50),
	managerLastName varchar(50),
	Department varchar(50)
	
)

insert into Managers (ManagerID, managerFirstName, managerLastName, Department) values (100, 'Jamie', 'Smith', 'Inventory');
insert into Managers (ManagerID, managerFirstName, managerLastName, Department) values (110, 'Lisa', 'Redmond', 'Inventory');
insert into Managers (ManagerID, managerFirstName, managerLastName, Department) values (120, 'William', 'Redd', 'Inventory');
insert into Managers (ManagerID, managerFirstName, managerLastName, Department) values (131, 'Susan', 'Willis', 'Inbound');
insert into Managers (ManagerID, managerFirstName, managerLastName, Department) values (122, 'Russell', 'Jones', 'Outbound');

CREATE TABLE auditErrors (
	ErrorID int PRIMARY KEY,
	ErrorType varchar(50),
	ErrorLevel varchar(6),
	ResDept varchar (50)
)

insert into auditErrors (ErrorID, ErrorType, ErrorLevel, ResDept) values (0, 'No Error', 'na', 'na');
insert into auditErrors (ErrorID, ErrorType, ErrorLevel, ResDept) values (1, 'Wrong Location', 'High', 'Putaway');
insert into auditErrors (ErrorID, ErrorType, ErrorLevel, ResDept) values (2, 'Wrong SKU', 'High', 'Putaway');
insert into auditErrors (ErrorID, ErrorType, ErrorLevel, ResDept) values (3, 'Wrong Quantity', 'Medium', 'Inbound');
insert into auditErrors (ErrorID, ErrorType, ErrorLevel, ResDept) values (4, 'Messy Location', 'Low', 'Putaway');
insert into auditErrors (ErrorID, ErrorType, ErrorLevel, ResDept) values (5, 'Damaged Product', 'High', 'Inbound');

CREATE TABLE Auditors (
	AuditorID int PRIMARY KEY,
	auditorFirstName varchar(50),
	auditorLastName varchar(50),
	ManagerID int FOREIGN KEY REFERENCES Managers(ManagerID),
	EmployeeStatus varchar(10),
	HourlyRate smallmoney
)


insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1000, 'Michel', 'Pauling', 100, 'Active', 14.50);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1001, 'Talbot', 'Rich', 110, 'Active', 12.00);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1002, 'Chris', 'Thynne', 110, 'Active', 13.50);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1003, 'Whitney', 'Addey', 100, 'Active', 15.25);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1004, 'Brian', 'Pugh', 120, 'Active', 12.37);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1005, 'Bennie', 'Dunham', 120, 'Active', 13.89);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1006, 'Adan', 'Waitland', 110, 'Active', 14.50);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1007, 'Renee', 'Heed', 100, 'Active', 15.23);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1008, 'Wesley', 'Smith', 100, 'Inactive', 12.98);
insert into Auditors (AuditorID, auditorFirstName, auditorLastName, ManagerID, EmployeeStatus, HourlyRate) values ( 1009, 'Gene', 'Watson', null, 'Active', 14.78);


CREATE TABLE locationAudits (
	auditID int PRIMARY KEY,
	WHSLoc int,
	SKU int,
	Client varchar(50),
	AuditorID int FOREIGN KEY REFERENCES Auditors(AuditorID),
	ExpQty int,
	CountedQty int,
	ErrorID int FOREIGN KEY REFERENCES auditErrors(ErrorID),
	AuditDate DATETIME
)

insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19129, 1274, 448281252, 'Dishes Ltd', 1007, 18, 23, 3, '2019-11-12 06:41:07');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11088, 1274, 567122382, 'Candles R Us', 1006, 68, 89, 2, '2020-10-03 18:44:34');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (14101, 1274, 303917835, 'Dog Supplies Inc', 1001, 52, 85, 2, '2020-02-22 19:28:40');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10749, 1274, 871286207, 'Beauty Products Inc', 1006, 6, 70, 3, '2019-12-19 20:24:53');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (14838, 1274, 301068451, 'Candles R Us', 1006, 34, 81, 2, '2020-05-20 15:54:07');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (13118, 1274, 165260852, 'Dishes Ltd', 1003, 58, 41, 5, '2020-07-25 02:36:03');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11831, 1274, 746659300, 'Beauty Products Inc', 1004, 47, 80, 1, '2020-02-07 07:09:57');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (13410, 1274, 123206910, 'Pillow Co', 1007, 22, 32, 5, '2020-10-09 12:59:26');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16794, 1274, 549456571, 'Candles R Us', 1003, 52, 23, 5, '2020-01-05 04:21:22');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10929, 1274, 225647727, 'Dishes Ltd', 1007, 23, 39, 5, '2019-11-11 09:02:57');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (18420, 1274, 850264070, 'Dog Supplies Inc', 1000, 31, 15, 5, '2019-12-19 18:21:16');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11325, 1274, 453294211, 'Dishes Ltd', 1007, 9, 100, 5, '2019-12-05 13:39:38');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (18438, 1274, 733148140, 'Beauty Products Inc', 1002, 52, 67, 4, '2020-09-13 21:14:44');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12863, 1274, 882442365, 'Pillow Co', 1000, 73, 23, 2, '2020-01-07 03:43:03');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11121, 1274, 726636670, 'Candles R Us', 1002, 30, 86, 1, '2020-04-02 09:33:12');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12509, 1274, 902305538, 'Pillow Co', 1004, 99, 15, null, '2020-01-18 19:35:19');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16957, 1274, 411820893, 'Dog Supplies Inc', 1001, 51, 11, 3, '2019-12-12 23:14:17');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (15907, 1274, 222792841, 'Beauty Products Inc', 1003, 1, 82, 5, '2020-03-31 03:00:50');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12231, 1274, 581486263, 'Pillow Co', 1006, 37, 47, 2, '2020-04-29 04:40:21');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19640, 1274, 150602228, 'Dog Supplies Inc', 1006, 55, 37, 3, '2020-09-29 22:14:47');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (13400, 1274, 179305856, 'Dog Supplies Inc', 1003, 39, 39, 0, '2020-08-28 17:58:49');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12372, 1274, 881435166, 'Beauty Products Inc', 1002, 92, 55, 2, '2020-07-22 03:55:31');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10269, 1274, 793725626, 'Pillow Co', 1001, 97, 88, 5, '2020-08-17 02:27:09');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19700, 1274, 027821821, 'Pillow Co', 1003, 95, 61, 3, '2019-11-23 10:52:00');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11689, 1274, 681025264, 'Dishes Ltd', 1006, 31, 71, 5, '2020-05-05 17:16:22');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19367, 1274, 106806681, 'Pillow Co', 1003, 48, 48, 0, '2019-12-05 06:16:37');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19228, 1274, 681490651, 'Dishes Ltd', 1000, 19, 83, 4, '2020-10-31 13:15:07');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (15712, 1274, 182218331, 'Beauty Products Inc', 1001, 58, 35, 2, '2020-10-10 01:13:08');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (18037, 1274, 462478319, 'Beauty Products Inc', 1004, 33, 87, 4, '2020-10-12 18:44:51');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19187, 1274, 211359221, 'Dishes Ltd', 1001, 84, 4, 2, '2020-07-17 15:52:31');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16245, 1274, 266398974, 'Dishes Ltd', 1003, 90, 45, 5, '2020-01-08 05:18:50');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11214, 1274, 137957957, 'Dishes Ltd', 1006, 49, 1, 5, '2020-08-21 03:02:47');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (14439, 1274, 939720388, 'Beauty Products Inc', 1006, 15, 30, 3, '2019-11-12 13:19:47');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11759, 1274, 507354629, 'Candles R Us', 1000, 35, 72, 5, '2020-05-16 11:56:08');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (15350, 1274, 937848507, 'Dishes Ltd', 1007, 57, 4, 5, '2019-12-10 14:35:17');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (13460, 1274, 940997183, 'Dog Supplies Inc', 1006, 59, 18, 4, '2020-10-11 06:03:25');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10885, 1274, 840218339, 'Pillow Co', 1002, 65, 66, 5, '2020-04-29 15:34:50');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12675, 1274, 190749696, 'Beauty Products Inc', 1002, 100, 22, 2, '2019-11-18 00:24:27');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16169, 1274, 559342832, 'Candles R Us', 1003, 27, 73, 1, '2020-08-19 02:05:19');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12667, 1274, 818975221, 'Pillow Co', 1005, 49, 66, 1, '2020-01-04 13:37:10');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12101, 1274, 565817533, 'Beauty Products Inc', 1005, 86, 74, 2, '2020-09-03 11:31:53');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (13599, 1274, 276648119, 'Dog Supplies Inc', 1004, 62, 64, 2, '2020-03-23 02:18:44');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (18101, 1274, 499825512, 'Beauty Products Inc', 1001, 58, 43, 2, '2020-07-17 09:46:02');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12343, 1274, 647868293, 'Pillow Co', 1004, 17, 15, 2, '2020-02-02 18:17:52');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11458, 1274, 156197149, 'Pillow Co', 1000, 23, 16, 3, '2020-06-30 10:02:11');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12642, 1274, 977684788, 'Dishes Ltd', 1004, 30, 35, 2, '2019-12-07 07:58:38');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (17529, 1274, 325837843, 'Dishes Ltd', 1001, 92, 24, 2, '2020-10-14 04:13:59');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (14710, 1274, 425636086, 'Dishes Ltd', 1000, 33, 8, 2, '2019-12-22 02:36:29');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10825, 1274, 473143238, 'Dishes Ltd', 1007, 31, 77, 2, '2020-04-13 21:35:10');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11243, 1274, 894188416, 'Candles R Us', 1006, 6, 6, 0, '2020-07-17 09:12:30');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19587, 1274, 250538738, 'Dog Supplies Inc', 1007, 21, 99, 1, '2020-02-17 06:53:40');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (18214, 1274, 665303399, 'Beauty Products Inc', 1002, 83, 91, 4, '2020-08-03 10:56:47');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16755, 1274, 423409204, 'Dog Supplies Inc', 1004, 19, 24, 2, '2020-09-20 19:29:32');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19441, 1274, 602644637, 'Beauty Products Inc', 1002, 24, 24, 0, '2020-05-26 16:54:48');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16170, 1274, 431001769, 'Dishes Ltd', 1007, 3, 3, 0, '2020-10-29 04:34:48');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (15738, 1274, 502324887, 'Dog Supplies Inc', 1001, 63, 63, 0, '2020-01-16 18:19:56');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (13436, 1274, 427316380, 'Pillow Co', 1004, 60, 86, 2, '2020-01-24 13:39:23');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (15745, 1274, 597602830, 'Beauty Products Inc', 1001, 64, 9, 4, '2020-07-15 16:40:17');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11131, 1274, 889944107, 'Beauty Products Inc', 1004, 15, 15, 0, '2019-12-01 23:06:05');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (14703, 1274, 496185762, 'Dog Supplies Inc', 1003, 4, 73, 2, '2020-10-16 12:59:03');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (17942, 1274, 481783817, 'Candles R Us', 1005, 57, 93, 3, '2020-09-23 14:09:43');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11197, 1274, 249978498, 'Dog Supplies Inc', 1001, 27, 49, 2, '2019-12-03 15:56:58');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12013, 1274, 437808630, 'Dog Supplies Inc', 1006, 72, 88, 1, '2020-06-22 12:26:00');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16684, 1274, 465588839, 'Pillow Co', 1003, 55, 15, 4, '2020-02-18 21:19:43');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (17429, 1274, 334287775, 'Dog Supplies Inc', 1004, 28, 43, 1, '2020-01-30 16:08:00');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (17866, 1274, 857200410, 'Pillow Co', 1007, 64, 89, 5, '2019-11-07 02:09:09');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10284, 1274, 739808952, 'Dishes Ltd', 1004, 47, 53, 2, '2020-02-28 02:04:25');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11406, 1274, 659716469, 'Beauty Products Inc', 1003, 35, 37, 3, '2020-01-06 05:51:56');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16391, 1274, 354287939, 'Dog Supplies Inc', 1001, 83, 74, 5, '2020-03-03 20:43:30');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (18477, 1274, 335591692, 'Candles R Us', 1002, 91, 6, 3, '2020-10-05 17:46:24');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (18175, 1274, 702185073, 'Beauty Products Inc', 1001, 43, 43, 0, '2020-09-03 12:03:45');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12999, 1274, 924658723, 'Dog Supplies Inc', 1004, 47, 13, 3, '2020-07-11 20:12:27');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16455, 1274, 358549457, 'Dog Supplies Inc', 1002, 56, 56, 0, '2020-03-22 12:56:01');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11799, 1274, 632151331, 'Candles R Us', 1004, 20, 58, null, '2020-01-28 04:42:30');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16347, 1274, 171966551, 'Beauty Products Inc', 1005, 51, 99, 3, '2020-05-29 14:57:36');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10369, 1274, 377349632, 'Dog Supplies Inc', 1001, 24, 12, 3, '2020-02-07 04:04:13');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12860, 1274, 365432374, 'Dishes Ltd', 1005, 36, 36, 0, '2020-09-04 01:58:51');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (17193, 1274, 889667387, 'Beauty Products Inc', 1003, 61, 61, 0, '2020-06-24 20:21:39');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19808, 1274, 684150022, 'Candles R Us', 1000, 74, 78, 3, '2020-06-06 01:49:20');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16213, 1274, 200791791, 'Candles R Us', 1004, 13, 6, 1, '2019-11-11 12:27:51');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (17617, 1274, 754576589, 'Dog Supplies Inc', 1001, 76, 6, 2, '2020-01-20 10:08:01');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19928, 1274, 908653544, 'Beauty Products Inc', 1005, 8, 51, 3, '2019-12-30 08:26:40');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (13146, 1274, 798510328, 'Candles R Us', 1004, 87, 87, 0, '2020-10-25 11:35:00');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (14353, 1274, 871393448, 'Dishes Ltd', 1004, 93, 91, 4, '2020-08-06 11:18:07');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16554, 1274, 706629965, 'Candles R Us', 1003, 62, 94, 4, '2019-11-14 06:25:05');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10345, 1274, 745114436, 'Candles R Us', 1006, 21, 21, 0, '2019-11-16 09:28:15');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11410, 1274, 218176531, 'Dog Supplies Inc', 1001, 15, 82, 4, '2020-06-23 21:54:34');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (11793, 1274, 515234125, 'Dog Supplies Inc', 1003, 14, 86, 4, '2019-11-12 01:18:15');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (10024, 1274, 308842592, 'Beauty Products Inc', 1003, 79, 61, 1, '2020-08-27 00:21:28');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12155, 1274, 879364429, 'Dog Supplies Inc', 1004, 32, 68, 5, '2019-12-18 03:39:44');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (13916, 1274, 159404719, 'Dog Supplies Inc', 1002, 97, 62, 2, '2020-07-03 00:07:17');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (14474, 1274, 832994431, 'Dog Supplies Inc', 1004, 13, 15, 1, '2020-10-05 15:56:13');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (16125, 1274, 347178011, 'Candles R Us', 1003, 94, 94, 0, '2020-07-21 23:20:27');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (15718, 1274, 458279630, 'Pillow Co', 1006, 88, 24, 2, '2020-01-10 19:17:01');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (17144, 1274, 409919565, 'Dog Supplies Inc', 1004, 63, 4, 1, '2020-01-25 18:29:48');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19856, 1274, 509305016, 'Candles R Us', 1001, 59, 94, 1, '2020-03-16 02:04:50');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (12087, 1274, 455361366, 'Pillow Co', 1005, 34, 100, 3, '2020-10-09 09:15:00');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19707, 1274, 911509316, 'Dog Supplies Inc', 1000, 30, 60, 1, '2020-01-23 10:06:02');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (17103, 1274, 835713654, 'Beauty Products Inc', 1004, 85, 42, 4, '2019-12-02 20:27:00');
insert into locationAudits (auditID, WHSLoc, SKU, Client, AuditorID, ExpQty, CountedQty, ErrorID, AuditDate) values (19233, 1274, 299224252, 'Beauty Products Inc', 1004, 18, 8, 1, '2020-05-09 06:15:37');

--Write a SELECT query that uses a WHERE clause
SELECT *
FROM locationAudits
WHERE Client = 'Pillow Co'

--Write a SELECT query that uses an OR and an AND operator
SELECT * FROM locationAudits
WHERE Client = 'Dog Supplies Inc' AND (AuditorID = 1001 OR AuditorID =1003);

--Write a SELECT query that filters NULL rows using IS NOT NULL
SELECT SKU, Client, ErrorID
FROM locationAudits
WHERE ErrorID IS NOT NULL;

--Write a DML statement that UPDATEs a set of rows with a WHERE clause.  The values used in the WHERE clause should be a variable
DECLARE @clientname varchar(50) = 'Beauty Products Inc'
UPDATE locationAudits
SET Client = 'Beauty Inc'
WHERE Client = @clientname

--Write a DML statement that DELETEs a set of rows with a WHERE clause.  The values used in the WHERE clause should be a variable
DECLARE @inventory_managers varchar(50) = 'Inventory'
DELETE FROM Managers WHERE Department <> @inventory_managers 

--Write a DML statement that DELETEs rows from a table that another table references.  This script will have to also DELETE any records that reference these rows.  Both of the DELETE statements need to be wrapped in a single transaction.
--**REVIEW - better choice for this one?

BEGIN TRANSACTION
	DELETE FROM locationAudits
	WHERE AuditorID = 1004

	DELETE FROM Auditors
	WHERE AuditorID = 1004

COMMIT;

--Write a SELECT query that utilizes a JOIN
SELECT locationAudits.auditID, Auditors.auditorFirstName + ' ' + Auditors.auditorLastName, locationAudits.AuditDate
FROM locationAudits
JOIN Auditors ON locationAudits.AuditorID = Auditors.AuditorID

--Write a SELECT query that utilizes a JOIN with 3 or more tables
SELECT la.auditID, a.auditorFirstName + ' ' + a.auditorLastName, m.managerFirstName + '  ' + m.managerLastName
FROM locationAudits la
JOIN Auditors a
ON la.AuditorID = a.AuditorID
JOIN Managers m
ON m.ManagerID = a.ManagerID

--Write a SELECT query that utilizes a LEFT JOIN
SELECT a.AuditorID, a.auditorFirstName + ' ' + a.auditorLastName, m.ManagerFirstName + ' ' + m.ManagerLastName
FROM Auditors a
LEFT JOIN Managers m
ON a.ManagerID = m.ManagerID

--Write a SELECT query that utilizes a variable in the WHERE clause
DECLARE @good_audits int = 0
SELECT *
FROM locationAudits
WHERE ErrorID = @good_Audits

--Write a SELECT query that utilizes a ORDER BY clause
SELECT * 
FROM locationAudits
ORDER BY AuditDate

--Write a SELECT query that utlizies a GROUP BY clause along with an aggregate function
SELECT ErrorID, COUNT(*)
FROM locationAudits
GROUP BY ErrorID;

--Write a SELECT query that utilizes a CALCULATED FIELD
SELECT auditID, SKU, ErrorID, ExpQty, CountedQty, (CountedQty - ExpQty) AS Adjustment
FROM locationAudits;


--Write a SELECT query that utilizes a SUBQUERY *will show employees earning below active employee average hourly wage
  SELECT auditorFirstName + ' ' + auditorLastName, ManagerID, HourlyRate
  FROM Auditors
  WHERE HourlyRate < (
	SELECT AVG(HourlyRate)
	FROM Auditors
	WHERE EmployeeStatus = 'Active'
  )


--Write a SELECT query that utliizes a JOIN, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC) AND A GROUP BY clause with and aggregate function
SELECT m.ManagerID, la.auditID, la.SKU, la.AuditorID
FROM locationAudits la
JOIN Managers m

Select *
FROM Auditors

--Write a SELECT query that utilizes a JOIN with 3 or more tables, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC.) a GROUP BY clause with an aggregate function and a HAVING clause
--Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the perfomance of one of the above queries
--Design a NONCLUSTERED INDEX with TWO KEY COLUMNS that improves the performance of one of the above queries
--Design a NONCLUSTERED INDEX with at least one key column and at least on included column that improves the performance of one of the above queries








