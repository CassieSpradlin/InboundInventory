CREATE DATABASE InboundInventory
GO

USE InboundInventory
GO

CREATE TABLE [dbo].[Managers] (
	[ManagerID] int PRIMARY KEY,
	[managerFirstName] varchar(50),
	[managerLastName] varchar(50),
	[Department] varchar(50)	
)

insert into [dbo].[Managers]([ManagerID], [managerFirstName], [managerLastName], [Department]) values (100, 'Jamie', 'Smith', 'Inventory');
insert into [dbo].[Managers]([ManagerID], [managerFirstName], [managerLastName], [Department]) values (110, 'Lisa', 'Redmond', 'Inventory');
insert into [dbo].[Managers]([ManagerID], [managerFirstName], [managerLastName], [Department]) values (120, 'William', 'Redd', 'Inventory');
insert into [dbo].[Managers]([ManagerID], [managerFirstName], [managerLastName], [Department]) values (131, 'Susan', 'Willis', 'Inbound');
insert into [dbo].[Managers]([ManagerID], [managerFirstName], [managerLastName], [Department]) values (122, 'Russell', 'Jones', 'Outbound');

CREATE TABLE [dbo].[auditErrors] (
	[ErrorID] int PRIMARY KEY,
	[ErrorType] varchar(50),
	[ErrorLevel] varchar(6),
	[ResDept] varchar (50)
)

insert into [dbo].[auditErrors] ([ErrorID], [ErrorType], [ErrorLevel], [ResDept]) values (0, 'No Error', 'na', 'na');
insert into [dbo].[auditErrors] ([ErrorID], [ErrorType], [ErrorLevel], [ResDept]) values (1, 'Wrong Location', 'High', 'Putaway');
insert into [dbo].[auditErrors] ([ErrorID], [ErrorType], [ErrorLevel], [ResDept]) values (2, 'Wrong [SKU]', 'High', 'Putaway');
insert into [dbo].[auditErrors] ([ErrorID], [ErrorType], [ErrorLevel], [ResDept]) values (3, 'Wrong Quantity', 'Medium', 'Inbound');
insert into [dbo].[auditErrors] ([ErrorID], [ErrorType], [ErrorLevel], [ResDept]) values (4, 'Messy Location', 'Low', 'Putaway');
insert into [dbo].[auditErrors] ([ErrorID], [ErrorType], [ErrorLevel], [ResDept]) values (5, 'Damaged Product', 'High', 'Inbound');

CREATE TABLE [dbo].[Auditors] (
	[AuditorID] int PRIMARY KEY,
	[auditorFirstName] varchar(50),
	[auditorLastName] varchar(50),
	[ManagerID] int FOREIGN KEY REFERENCES [dbo].[Managers]([ManagerID]),
	[EmployeeStatus] varchar(10),
	[HourlyRate] smallmoney
)


insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1000, 'Michel', 'Pauling', 100, 'Active', 14.50);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1001, 'Talbot', 'Rich', 110, 'Active', 12.00);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1002, 'Chris', 'Thynne', 110, 'Active', 13.50);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1003, 'Whitney', 'Addey', 100, 'Active', 15.25);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1004, 'Brian', 'Pugh', 120, 'Active', 12.37);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1005, 'Bennie', 'Dunham', 120, 'Active', 13.89);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1006, 'Adan', 'Waitland', 110, 'Active', 14.50);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1007, 'Renee', 'Heed', 100, 'Active', 15.23);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1008, 'Wesley', 'Smith', 100, 'Inactive', 12.98);
insert into [dbo].[Auditors] ([AuditorID], [auditorFirstName], [auditorLastName], [ManagerID], [EmployeeStatus], [HourlyRate]) values ( 1009, 'Gene', 'Watson', null, 'Active', 14.78);


CREATE TABLE [dbo].[locationAudits] (
	[auditID] int PRIMARY KEY,
	[WHSLoc] int,
	[SKU] int,
	[Client] varchar(50),
	[AuditorID] int FOREIGN KEY REFERENCES [dbo].[Auditors]([AuditorID]),
	[ExpQty] int,
	[CountedQty] int,
	[ErrorID] int FOREIGN KEY REFERENCES [dbo].[auditErrors]([ErrorID]),
	[AuditDate] DATETIME
)

insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10348, 1274, 18212577, 'Pillow Co', 1003, 27, 2, 1, '2020-10-05 16:22:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10813, 1274, 28577598, 'Dishes Ltd', 1005, 10, 10, 0, '2020-10-17 11:56:57');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10493, 1274, 32929374, 'Dishes Ltd', 1000, 32, 56, 2, '2020-11-01 00:19:36');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10859, 1274, 21543726, 'Pillow Co', 1004, 17, 25, 1, '2020-10-10 16:35:50');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10928, 1274, 32709406, 'Pillow Co', 1006, 12, 12, 0, '2020-10-10 04:51:15');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10303, 1274, 15595446, 'Dishes Ltd', 1001, 14, 67, 3, '2020-10-31 23:56:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11923, 1274, 23900376, 'Pillow Co', 1007, 17, 52, 1, '2020-10-22 00:50:10');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10492, 1274, 39077850, 'Candles R Us', 1003, 28, 54, 5, '2020-10-04 10:38:36');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11704, 1274, 37608697, 'Dog Supplies Inc', 1005, 13, 30, 5, '2020-10-08 02:32:45');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11918, 1274, 34787862, 'Beauty Products Inc', 1006, 41, 23, 2, '2020-10-30 13:20:27');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10290, 1274, 18344309, 'Dog Supplies Inc', 1005, 16, 16, 0, '2020-10-11 18:46:03');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11387, 1274, 21522420, 'Beauty Products Inc', 1006, 46, 71, 2, '2020-10-27 20:58:28');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11979, 1274, 16009995, 'Candles R Us', 1006, 36, 36, 0, '2020-10-25 02:25:28');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11091, 1274, 33752161, 'Beauty Products Inc', 1003, 50, 3, 2, '2020-10-12 12:18:22');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10459, 1274, 34844891, 'Candles R Us', 1000, 38, 43, 4, '2020-10-28 23:23:11');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10373, 1274, 13180286, 'Pillow Co', 1000, 28, 1, 1, '2020-10-27 14:25:19');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10545, 1274, 11521808, 'Candles R Us', 1001, 45, 4, 4, '2020-10-09 01:56:01');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10453, 1274, 18976335, 'Beauty Products Inc', 1004, 14, 14, 0, '2020-10-31 23:17:36');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11138, 1274, 17305770, 'Beauty Products Inc', 1003, 4, 4, 0, '2020-10-26 07:11:00');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10330, 1274, 13854992, 'Candles R Us', 1006, 7, 52, 4, '2020-10-16 18:52:08');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10149, 1274, 22321128, 'Beauty Products Inc', 1000, 20, 34, 5, '2020-10-11 13:39:45');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10993, 1274, 21707070, null, 1007, 11, 41, null, '2020-10-04 14:05:43');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11201, 1274, 32771135, 'Dishes Ltd', 1007, 29, 73, 3, '2020-10-08 12:34:48');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11683, 1274, 36839817, 'Dishes Ltd', 1000, 37, 64, 4, '2020-10-14 05:37:24');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10277, 1274, 16817513, 'Dishes Ltd', 1002, 25, 26, 4, '2020-10-12 14:37:44');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11332, 1274, 39982507, 'Dog Supplies Inc', 1003, 25, 55, 2, '2020-10-31 07:30:48');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11544, 1274, 31115735, 'Candles R Us', 1004, 2, 63, 1, '2020-10-08 01:06:52');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11385, 1274, 28437212, 'Candles R Us', 1002, 28, 64, 2, '2020-10-03 12:22:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10485, 1274, 11581358, 'Beauty Products Inc', 1004, 14, 6, 2, '2020-10-04 21:16:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10139, 1274, 13244575, 'Dishes Ltd', 1005, 40, 42, 5, '2020-10-24 10:19:06');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11258, 1274, 22534302, 'Dog Supplies Inc', 1002, 23, 23, 0, '2020-10-22 22:47:09');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11878, 1274, 14778295, 'Pillow Co', 1006, 38, 59, 1, '2020-10-28 04:33:39');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10189, 1274, 17148696, 'Dishes Ltd', 1007, 17, 46, 1, '2020-10-25 08:00:22');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11610, 1274, 25861510, 'Pillow Co', 1001, 24, 37, 1, '2020-10-21 04:51:26');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10202, 1274, 17957769, 'Pillow Co', 1003, 6, 30, 1, '2020-10-10 00:16:01');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11708, 1274, 30401200, 'Pillow Co', 1001, 30, 9, 5, '2020-10-17 12:10:54');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11188, 1274, 24808870, 'Dishes Ltd', 1006, 4, 42, 5, '2020-10-01 22:21:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10173, 1274, 33234213, 'Dishes Ltd', 1007, 47, 22, 1, '2020-10-09 20:50:09');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11785, 1274, 15602873, 'Pillow Co', 1005, 1, 50, 5, '2020-10-03 14:45:05');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11358, 1274, 36797368, 'Dishes Ltd', 1001, 21, 12, 4, '2020-10-11 11:34:56');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10691, 1274, 10917188, 'Candles R Us', 1002, 13, 71, 4, '2020-10-21 16:39:08');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10924, 1274, 36225145, 'Pillow Co', 1004, 33, 31, 1, '2020-10-03 18:32:55');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10389, 1274, 33237631, 'Beauty Products Inc', 1001, 14, 21, 3, '2020-10-16 00:26:41');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10737, 1274, 29418184, 'Pillow Co', 1004, 47, 20, 3, '2020-10-06 20:18:56');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11262, 1274, 25450699, 'Candles R Us', 1001, 41, 56, 2, '2020-10-24 18:01:18');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10561, 1274, 33621011, 'Pillow Co', 1001, 33, 36, 1, '2020-10-07 21:39:36');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10017, 1274, 25921168, 'Candles R Us', 1003, 19, 50, 1, '2020-10-14 08:57:53');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11915, 1274, 11601588, 'Beauty Products Inc', 1004, 4, 4, 0, '2020-10-28 00:30:27');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11811, 1274, 17553072, 'Pillow Co', 1000, 44, 24, 3, '2020-11-01 15:01:25');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11160, 1274, 26098688, 'Pillow Co', 1007, 27, 27, 0, '2020-10-23 21:34:33');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11513, 1274, 33458121, 'Beauty Products Inc', 1002, 23, 30, 1, '2020-10-14 14:11:03');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10223, 1274, 21869317, null, 1001, 25, 49, null, '2020-10-21 16:11:51');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11951, 1274, 20744042, 'Pillow Co', 1005, 37, 13, 1, '2020-10-10 23:59:16');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11478, 1274, 20067759, 'Candles R Us', 1002, 22, 68, 5, '2020-10-04 12:29:22');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11956, 1274, 20680084, 'Dishes Ltd', 1000, 18, 18, 0, '2020-10-23 05:29:32');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10995, 1274, 30010094, 'Beauty Products Inc', 1005, 6, 6, 0, '2020-10-16 17:27:27');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10585, 1274, 16040942, 'Dishes Ltd', 1001, 16, 23, 1, '2020-10-10 12:00:30');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10505, 1274, 12113904, 'Beauty Products Inc', 1006, 44, 67, 4, '2020-10-03 14:27:26');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11105, 1274, 37211387, 'Dog Supplies Inc', 1004, 27, 27, 0, '2020-10-01 23:49:52');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11191, 1274, 18976673, 'Beauty Products Inc', 1004, 22, 16, 1, '2020-10-24 12:58:04');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20003, 1274, 13478376, 'Beauty Products Inc', 1003, 18, 38, 5, '2020-10-17 16:24:21');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11524, 1274, 28078435, 'Dishes Ltd', 1000, 44, 41, 4, '2020-10-18 08:09:13');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10958, 1274, 26248078, 'Pillow Co', 1001, 24, 45, 5, '2020-10-24 09:38:23');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10054, 1274, 34066364, 'Dishes Ltd', 1007, 45, 45, 0, '2020-10-15 03:16:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10986, 1274, 19765799, 'Pillow Co', 1007, 13, 70, 5, '2020-10-14 15:47:43');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11768, 1274, 13519757, 'Beauty Products Inc', 1004, 44, 19, 1, '2020-10-29 17:06:14');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10996, 1274, 13996031, null, 1006, 30, 37, null, '2020-10-19 11:54:52');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11507, 1274, 36718874, 'Dog Supplies Inc', 1001, 27, 72, 1, '2020-10-07 16:46:36');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10618, 1274, 27981997, 'Pillow Co', 1005, 46, 34, 2, '2020-10-29 14:58:29');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10841, 1274, 36308943, 'Beauty Products Inc', 1002, 25, 25, 0, '2020-10-16 13:27:22');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10358, 1274, 21165694, 'Beauty Products Inc', 1003, 41, 64, 4, '2020-10-13 16:10:28');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11279, 1274, 26273579, 'Dog Supplies Inc', 1002, 30, 15, 2, '2020-10-31 22:41:33');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10562, 1274, 11380195, 'Dog Supplies Inc', 1005, 8, 61, 5, '2020-10-23 16:27:33');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11145, 1274, 27561794, null, 1001, 10, 37, null, '2020-10-25 12:15:57');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11420, 1274, 22326324, 'Beauty Products Inc', 1007, 11, 65, 5, '2020-10-31 02:11:13');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11711, 1274, 34990392, 'Candles R Us', 1005, 26, 61, 1, '2020-10-29 15:15:07');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10174, 1274, 21942097, 'Candles R Us', 1000, 32, 32, 0, '2020-10-23 23:00:59');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10832, 1274, 14134351, 'Dishes Ltd', 1006, 10, 8, 5, '2020-10-07 04:46:55');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11796, 1274, 11370550, 'Pillow Co', 1006, 28, 28, 3, '2020-10-04 16:09:16');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10201, 1274, 23957483, 'Dog Supplies Inc', 1001, 10, 31, 1, '2020-10-15 17:33:43');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10567, 1274, 36975453, 'Beauty Products Inc', 1006, 41, 67, 4, '2020-10-27 11:01:04');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10638, 1274, 27903560, 'Dishes Ltd', 1006, 34, 34, 0, '2020-10-15 11:16:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11990, 1274, 35046884, 'Beauty Products Inc', 1003, 15, 12, 3, '2020-10-21 20:47:16');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10683, 1274, 39254353, 'Dog Supplies Inc', 1000, 1, 22, 1, '2020-10-13 07:57:57');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11482, 1274, 15034621, 'Beauty Products Inc', 1005, 23, 2, 2, '2020-10-05 19:25:50');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10959, 1274, 24111301, 'Dishes Ltd', 1003, 11, 8, 5, '2020-10-14 03:47:08');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11748, 1274, 27771539, 'Beauty Products Inc', 1004, 23, 40, 2, '2020-10-28 09:15:02');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10785, 1274, 29321416, 'Dog Supplies Inc', 1002, 21, 21, 0, '2020-10-19 16:40:02');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11471, 1274, 27448243, 'Dishes Ltd', 1002, 22, 4, 2, '2020-10-30 08:39:09');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10868, 1274, 30649895, null, 1007, 42, 28, null, '2020-10-28 00:47:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10115, 1274, 35666518, 'Pillow Co', 1007, 46, 46, 0, '2020-10-30 08:43:00');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10531, 1274, 26271198, 'Dog Supplies Inc', 1001, 32, 33, 1, '2020-10-04 04:28:11');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10569, 1274, 11471988, 'Dishes Ltd', 1001, 23, 53, 1, '2020-11-01 12:46:41');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10339, 1274, 21512983, 'Dog Supplies Inc', 1004, 4, 21, 3, '2020-10-29 01:16:49');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10409, 1274, 24045276, 'Dog Supplies Inc', 1004, 50, 50, 0, '2020-10-02 17:41:11');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10480, 1274, 32931013, 'Dishes Ltd', 1004, 21, 21, 0, '2020-10-18 21:26:08');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10355, 1274, 33099187, 'Pillow Co', 1004, 33, 33, 0, '2020-11-01 12:32:25');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10242, 1274, 33249907, 'Dog Supplies Inc', 1007, 30, 28, 3, '2020-10-21 08:14:03');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20868, 1274, 21696144, 'Beauty Products Inc', 1000, 39, 45, 4, '2020-10-14 15:03:15');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11960, 1274, 17998943, 'Pillow Co', 1001, 27, 45, 1, '2020-10-03 06:58:30');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10414, 1274, 37916459, 'Dishes Ltd', 1007, 23, 16, 4, '2020-10-21 07:04:37');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11892, 1274, 14403823, 'Candles R Us', 1006, 16, 12, 2, '2020-10-02 03:42:56');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10275, 1274, 39770156, 'Pillow Co', 1007, 11, 11, 0, '2020-10-02 12:11:09');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20841, 1274, 35106388, 'Dog Supplies Inc', 1005, 31, 31, 0, '2020-10-08 02:25:32');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10383, 1274, 39443853, 'Pillow Co', 1005, 5, 5, 0, '2020-10-25 01:32:41');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10939, 1274, 34266660, 'Dishes Ltd', 1000, 20, 5, 5, '2020-10-21 12:07:43');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10238, 1274, 10345406, 'Dishes Ltd', 1004, 37, 58, 1, '2020-10-12 22:16:56');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10933, 1274, 10172823, 'Beauty Products Inc', 1001, 41, 53, 1, '2020-10-13 13:13:48');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11423, 1274, 11077722, 'Beauty Products Inc', 1001, 46, 58, 4, '2020-10-03 03:25:20');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (30841, 1274, 18302152, 'Dog Supplies Inc', 1007, 2, 75, 1, '2020-10-22 13:48:37');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10462, 1274, 14806039, 'Dishes Ltd', 1001, 50, 14, 1, '2020-10-24 21:29:07');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10678, 1274, 10631528, 'Candles R Us', 1000, 19, 19, 0, '2020-10-12 20:18:50');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11249, 1274, 23553909, 'Beauty Products Inc', 1002, 22, 22, 0, '2020-10-19 11:54:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10538, 1274, 19949872, 'Candles R Us', 1002, 5, 15, 2, '2020-10-24 23:05:55');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11913, 1274, 30129659, 'Beauty Products Inc', 1004, 37, 15, 5, '2020-10-10 19:12:17');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10154, 1274, 25794750, 'Candles R Us', 1006, 13, 41, 4, '2020-10-29 02:23:37');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10843, 1274, 38415896, 'Beauty Products Inc', 1004, 3, 43, 5, '2020-10-13 10:44:48');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10719, 1274, 18546446, 'Pillow Co', 1006, 18, 36, 4, '2020-10-17 05:21:23');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11607, 1274, 33183388, 'Candles R Us', 1004, 33, 33, 0, '2020-10-17 22:20:05');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11225, 1274, 28386888, 'Beauty Products Inc', 1003, 7, 56, 2, '2020-10-16 04:39:30');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11214, 1274, 31789485, 'Dog Supplies Inc', 1000, 18, 26, 5, '2020-10-24 20:58:28');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11932, 1274, 34920015, 'Candles R Us', 1005, 46, 64, 3, '2020-10-05 21:50:10');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10472, 1274, 39593001, 'Pillow Co', 1002, 32, 53, 4, '2020-10-30 22:44:27');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10655, 1274, 31944919, 'Candles R Us', 1002, 25, 4, 3, '2020-10-17 02:16:44');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11664, 1274, 28276312, 'Beauty Products Inc', 1005, 41, 41, 0, '2020-10-02 23:15:46');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10163, 1274, 30020123, 'Pillow Co', 1003, 43, 22, 5, '2020-10-30 21:55:21');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10140, 1274, 21061910, 'Dishes Ltd', 1005, 48, 3, 2, '2020-10-23 20:24:12');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10423, 1274, 20171369, 'Candles R Us', 1004, 26, 54, 3, '2020-10-19 08:50:35');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10340, 1274, 36881499, 'Candles R Us', 1007, 40, 32, 5, '2020-10-09 21:52:08');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11968, 1274, 29248116, 'Beauty Products Inc', 1000, 6, 6, 0, '2020-10-20 04:00:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10349, 1274, 30241168, 'Pillow Co', 1007, 29, 47, 4, '2020-10-25 22:02:28');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20485, 1274, 15756622, 'Pillow Co', 1001, 46, 64, 4, '2020-10-08 01:58:18');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10337, 1274, 32652938, 'Candles R Us', 1002, 37, 69, 1, '2020-10-15 02:55:05');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11707, 1274, 12272532, 'Dog Supplies Inc', 1003, 41, 47, 1, '2020-10-22 14:52:24');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10272, 1274, 27966270, 'Dishes Ltd', 1005, 47, 47, 0, '2020-10-05 00:58:20');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11901, 1274, 12419404, 'Beauty Products Inc', 1000, 50, 23, 5, '2020-10-29 22:27:00');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20683, 1274, 19674927, 'Pillow Co', 1000, 27, 42, 3, '2020-10-02 06:49:19');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11346, 1274, 20848963, 'Beauty Products Inc', 1000, 5, 6, 1, '2020-10-27 16:42:39');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11002, 1274, 39486135, 'Dog Supplies Inc', 1003, 8, 34, 1, '2020-10-03 22:42:14');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20139, 1274, 39056699, 'Dishes Ltd', 1005, 33, 71, 3, '2020-10-23 05:07:31');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10754, 1274, 39648980, 'Beauty Products Inc', 1004, 26, 26, 0, '2020-10-27 04:30:51');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20472, 1274, 29699127, 'Dishes Ltd', 1001, 11, 20, 4, '2020-10-03 19:25:45');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20933, 1274, 14028337, 'Candles R Us', 1000, 1, 47, 5, '2020-10-09 21:43:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11829, 1274, 14148904, 'Beauty Products Inc', 1004, 44, 7, 5, '2020-10-12 04:05:11');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10436, 1274, 18732360, 'Dog Supplies Inc', 1006, 10, 67, 4, '2020-10-09 17:40:26');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11804, 1274, 29655678, 'Dishes Ltd', 1002, 40, 5, 4, '2020-10-15 16:18:49');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11062, 1274, 20130702, 'Pillow Co', 1007, 42, 20, 5, '2020-10-22 09:17:16');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10126, 1274, 11278874, 'Pillow Co', 1006, 25, 33, 4, '2020-10-16 13:59:40');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11459, 1274, 23589809, 'Dishes Ltd', 1006, 32, 42, 4, '2020-10-27 17:58:17');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11559, 1274, 13723859, 'Pillow Co', 1002, 7, 29, 3, '2020-10-15 18:43:34');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10212, 1274, 27056419, 'Dog Supplies Inc', 1005, 17, 65, 2, '2020-10-08 09:26:24');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11730, 1274, 23203022, 'Beauty Products Inc', 1000, 5, 19, 1, '2020-10-29 05:21:58');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11436, 1274, 37730471, 'Dog Supplies Inc', 1007, 27, 36, 3, '2020-10-26 00:54:00');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11038, 1274, 14833463, 'Dog Supplies Inc', 1007, 31, 11, 1, '2020-11-01 15:04:51');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11302, 1274, 11392235, 'Pillow Co', 1003, 22, 69, 3, '2020-10-29 18:13:28');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11907, 1274, 22213944, 'Pillow Co', 1002, 14, 70, 5, '2020-10-31 18:42:54');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11223, 1274, 35408901, 'Dog Supplies Inc', 1005, 15, 15, 0, '2020-10-21 13:11:21');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21225, 1274, 26927372, 'Beauty Products Inc', 1005, 8, 34, 4, '2020-10-03 23:31:09');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10987, 1274, 13671183, 'Dishes Ltd', 1000, 15, 37, 5, '2020-10-30 15:44:31');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10953, 1274, 20823073, 'Candles R Us', 1000, 13, 19, 4, '2020-10-25 07:49:17');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11489, 1274, 37332876, 'Dishes Ltd', 1006, 4, 4, 0, '2020-10-19 08:04:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10368, 1274, 10615092, 'Dishes Ltd', 1001, 21, 56, 4, '2020-10-22 15:43:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11199, 1274, 33729515, 'Dishes Ltd', 1006, 46, 46, 0, '2020-10-27 01:41:39');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21471, 1274, 12598433, 'Pillow Co', 1003, 31, 34, 4, '2020-10-23 07:22:36');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10593, 1274, 14667428, 'Dog Supplies Inc', 1003, 20, 48, 2, '2020-10-28 15:23:46');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10910, 1274, 15371131, 'Beauty Products Inc', 1001, 46, 46, 0, '2020-10-02 07:34:30');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10386, 1274, 38624234, 'Dishes Ltd', 1002, 10, 44, 5, '2020-10-28 14:31:18');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11965, 1274, 19696845, 'Dog Supplies Inc', 1000, 21, 68, 4, '2020-10-13 10:58:40');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20569, 1274, 26605422, 'Dishes Ltd', 1000, 7, 37, 1, '2020-10-18 16:29:54');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11529, 1274, 38356337, 'Dishes Ltd', 1005, 19, 41, 3, '2020-10-16 06:59:53');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11620, 1274, 28894846, 'Pillow Co', 1006, 22, 17, 4, '2020-10-25 04:11:19');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10943, 1274, 31107579, 'Candles R Us', 1000, 48, 46, 5, '2020-10-03 14:41:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11442, 1274, 17736511, 'Candles R Us', 1003, 48, 48, 0, '2020-11-01 14:50:47');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21346, 1274, 14305267, 'Dishes Ltd', 1000, 13, 13, 0, '2020-10-25 02:46:40');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11809, 1274, 33031278, 'Dog Supplies Inc', 1000, 17, 16, 3, '2020-10-07 03:11:43');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10377, 1274, 10877516, 'Dishes Ltd', 1001, 16, 23, 4, '2020-10-10 22:05:57');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11255, 1274, 22827358, 'Candles R Us', 1000, 35, 32, 3, '2020-10-21 02:18:31');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11171, 1274, 20183204, 'Pillow Co', 1006, 37, 14, 3, '2020-11-01 21:04:47');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11308, 1274, 16196494, 'Pillow Co', 1004, 17, 16, 3, '2020-10-02 23:50:56');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11157, 1274, 27683834, 'Beauty Products Inc', 1001, 49, 50, 1, '2020-10-02 10:15:48');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10787, 1274, 10147698, 'Dog Supplies Inc', 1006, 17, 40, 2, '2020-10-31 07:21:33');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10069, 1274, 36755290, 'Dishes Ltd', 1007, 18, 16, 4, '2020-10-06 20:00:18');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11235, 1274, 15969747, 'Dishes Ltd', 1003, 8, 37, 3, '2020-10-08 18:24:03');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10157, 1274, 35041860, 'Beauty Products Inc', 1003, 4, 75, 3, '2020-10-12 21:38:52');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10296, 1274, 26580899, 'Dishes Ltd', 1000, 19, 1, 1, '2020-10-14 20:12:28');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10920, 1274, 37063374, 'Dog Supplies Inc', 1007, 45, 19, 4, '2020-10-21 23:30:30');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11742, 1274, 23526687, 'Pillow Co', 1000, 44, 45, 2, '2020-10-29 17:28:21');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10528, 1274, 18097906, 'Pillow Co', 1003, 49, 42, 1, '2020-10-05 22:36:12');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11229, 1274, 21179116, 'Candles R Us', 1000, 21, 21, 0, '2020-10-28 16:41:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11895, 1274, 21323502, 'Beauty Products Inc', 1004, 27, 26, 2, '2020-10-12 19:22:28');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11085, 1274, 11089315, 'Candles R Us', 1005, 47, 11, 1, '2020-11-01 00:28:48');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11653, 1274, 33786800, 'Candles R Us', 1003, 34, 65, 3, '2020-10-12 21:34:52');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21482, 1274, 19912474, 'Beauty Products Inc', 1003, 35, 35, 0, '2020-10-22 06:11:58');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11914, 1274, 21970241, 'Dishes Ltd', 1005, 21, 43, 2, '2020-10-24 09:03:01');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11891, 1274, 13441510, 'Beauty Products Inc', 1004, 36, 36, 0, '2020-10-03 09:00:20');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10726, 1274, 39332873, 'Beauty Products Inc', 1004, 49, 5, 1, '2020-10-27 00:44:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21704, 1274, 22306859, 'Beauty Products Inc', 1001, 36, 36, 0, '2020-10-24 09:41:45');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10111, 1274, 28471440, 'Candles R Us', 1000, 19, 42, 3, '2020-10-22 12:34:14');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11447, 1274, 13578101, 'Dog Supplies Inc', 1000, 14, 20, 1, '2020-10-20 23:43:56');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10393, 1274, 14051430, 'Dishes Ltd', 1007, 22, 8, 4, '2020-10-01 22:14:02');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10233, 1274, 31773643, 'Beauty Products Inc', 1006, 6, 19, 5, '2020-10-24 11:27:15');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21768, 1274, 26713990, 'Candles R Us', 1007, 26, 7, 2, '2020-10-31 04:21:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10152, 1274, 11030078, 'Dishes Ltd', 1003, 22, 48, 5, '2020-10-16 15:12:59');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11676, 1274, 19153621, 'Pillow Co', 1002, 4, 14, 1, '2020-10-02 22:32:57');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20386, 1274, 35716250, 'Dog Supplies Inc', 1006, 4, 66, 2, '2020-10-31 10:50:46');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10658, 1274, 39133015, 'Candles R Us', 1004, 13, 74, 5, '2020-10-03 14:41:30');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10535, 1274, 23791848, 'Dishes Ltd', 1003, 46, 32, 3, '2020-10-19 11:41:34');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10661, 1274, 17764404, 'Beauty Products Inc', 1002, 14, 24, 3, '2020-10-01 16:14:59');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11767, 1274, 32297640, 'Pillow Co', 1004, 25, 7, 1, '2020-10-06 15:46:53');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10380, 1274, 34552630, 'Beauty Products Inc', 1002, 38, 28, 1, '2020-11-01 17:43:18');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10609, 1274, 20799462, 'Dog Supplies Inc', 1004, 22, 50, 3, '2020-10-13 10:51:15');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11362, 1274, 15791508, 'Beauty Products Inc', 1004, 37, 54, 4, '2020-10-07 05:22:15');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10158, 1274, 35892976, 'Dishes Ltd', 1005, 13, 34, 4, '2020-10-08 21:44:12');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10350, 1274, 36036012, 'Beauty Products Inc', 1003, 24, 52, 5, '2020-10-29 23:42:31');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10548, 1274, 32504805, 'Dog Supplies Inc', 1003, 22, 29, 4, '2020-10-16 03:11:44');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10334, 1274, 21635594, 'Dishes Ltd', 1007, 26, 65, 5, '2020-10-28 12:34:29');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10195, 1274, 23109538, 'Pillow Co', 1001, 19, 22, 5, '2020-10-01 06:26:16');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11628, 1274, 33871329, 'Candles R Us', 1002, 23, 23, 0, '2020-10-21 19:03:22');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11018, 1274, 24745201, null, 1001, 19, 9, null, '2020-10-30 16:41:15');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21923, 1274, 19709358, 'Beauty Products Inc', 1003, 16, 22, 1, '2020-10-25 05:13:51');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11997, 1274, 28694493, 'Beauty Products Inc', 1003, 11, 32, 4, '2020-10-12 06:39:30');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10905, 1274, 17783788, 'Candles R Us', 1003, 37, 37, 0, '2020-10-18 08:23:17');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10906, 1274, 28004105, 'Beauty Products Inc', 1003, 7, 7, 0, '2020-10-20 06:26:50');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11798, 1274, 20434841, 'Candles R Us', 1003, 26, 51, 2, '2020-10-02 23:40:37');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11061, 1274, 35477634, 'Pillow Co', 1006, 26, 26, 0, '2020-10-13 11:44:21');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10529, 1274, 24831322, 'Candles R Us', 1007, 19, 74, 3, '2020-10-21 17:49:21');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10440, 1274, 21332530, 'Dishes Ltd', 1002, 4, 4, 0, '2020-10-12 13:00:03');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11008, 1274, 10645612, 'Candles R Us', 1007, 27, 19, 4, '2020-10-24 22:23:33');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10631, 1274, 37017522, 'Beauty Products Inc', 1007, 13, 16, 2, '2020-10-03 23:06:45');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11031, 1274, 11718903, 'Beauty Products Inc', 1000, 2, 16, 3, '2020-11-01 11:35:45');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11100, 1274, 21156110, 'Candles R Us', 1000, 49, 33, 1, '2020-10-01 14:01:34');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11470, 1274, 29520390, 'Candles R Us', 1005, 8, 62, 3, '2020-10-22 04:58:35');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21447, 1274, 33621727, 'Beauty Products Inc', 1002, 30, 70, 4, '2020-10-04 09:24:08');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11076, 1274, 18739058, 'Dog Supplies Inc', 1003, 4, 4, 0, '2020-10-31 17:45:24');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11174, 1274, 35542092, 'Beauty Products Inc', 1003, 9, 49, 2, '2020-10-26 08:20:37');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10406, 1274, 18679135, 'Pillow Co', 1002, 16, 17, 4, '2020-10-01 15:16:41');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10118, 1274, 16917389, 'Beauty Products Inc', 1003, 39, 45, 5, '2020-10-28 22:01:57');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11121, 1274, 10280318, 'Candles R Us', 1007, 8, 54, 3, '2020-10-11 21:46:26');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10983, 1274, 32480432, 'Candles R Us', 1001, 17, 17, 0, '2020-10-30 10:52:39');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10876, 1274, 34711573, 'Beauty Products Inc', 1004, 31, 60, 2, '2020-10-04 06:47:43');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21085, 1274, 22943548, 'Candles R Us', 1007, 50, 32, 4, '2020-10-16 13:24:39');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10743, 1274, 39470775, 'Candles R Us', 1001, 23, 23, 1, '2020-10-23 21:04:40');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11152, 1274, 19976169, 'Dishes Ltd', 1003, 36, 36, 0, '2020-10-20 13:12:04');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11425, 1274, 15707545, 'Candles R Us', 1002, 30, 30, 0, '2020-10-03 06:51:48');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10446, 1274, 28718798, 'Dishes Ltd', 1006, 18, 18, 5, '2020-10-29 00:52:19');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11805, 1274, 30339959, 'Dishes Ltd', 1004, 32, 32, 0, '2020-10-19 18:54:49');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21544, 1274, 16817562, 'Pillow Co', 1007, 12, 75, 1, '2020-10-08 17:52:05');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10239, 1274, 24974852, 'Dishes Ltd', 1001, 38, 66, 1, '2020-10-13 11:31:55');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11140, 1274, 16448889, 'Dishes Ltd', 1001, 46, 33, 2, '2020-10-31 04:37:21');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11090, 1274, 26647222, 'Dishes Ltd', 1001, 22, 48, 5, '2020-10-08 13:44:49');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10982, 1274, 38816801, 'Pillow Co', 1002, 30, 29, 1, '2020-10-17 01:28:31');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20272, 1274, 36225392, 'Beauty Products Inc', 1003, 6, 58, 3, '2020-10-15 09:53:04');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11212, 1274, 25603517, 'Dog Supplies Inc', 1002, 23, 7, 2, '2020-10-29 12:08:25');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10246, 1274, 29099865, 'Candles R Us', 1004, 31, 51, 4, '2020-10-09 02:01:52');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11005, 1274, 19876860, 'Dog Supplies Inc', 1003, 18, 55, 3, '2020-10-11 01:02:13');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10025, 1274, 12645057, 'Dog Supplies Inc', 1004, 28, 17, 3, '2020-10-10 22:05:42');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10744, 1274, 31728916, 'Dog Supplies Inc', 1004, 1, 65, 2, '2020-10-21 06:33:52');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (31085, 1274, 24769065, 'Pillow Co', 1004, 33, 24, 5, '2020-11-01 21:26:26');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10871, 1274, 39482917, 'Dishes Ltd', 1005, 2, 2, 0, '2020-10-07 11:04:09');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10442, 1274, 18580881, 'Beauty Products Inc', 1006, 30, 2, 1, '2020-10-14 09:42:16');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10269, 1274, 31274492, 'Dog Supplies Inc', 1000, 3, 3, 0, '2020-10-31 13:18:04');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11296, 1274, 18126934, 'Dog Supplies Inc', 1004, 28, 24, 3, '2020-10-20 10:41:29');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11095, 1274, 21097382, 'Dog Supplies Inc', 1000, 41, 41, 0, '2020-10-23 23:04:37');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11689, 1274, 18651584, 'Pillow Co', 1003, 14, 64, 2, '2020-10-07 11:22:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10429, 1274, 18924174, 'Beauty Products Inc', 1005, 27, 60, 4, '2020-10-23 21:13:38');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11338, 1274, 13694033, 'Beauty Products Inc', 1005, 50, 38, 5, '2020-10-30 23:06:02');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10318, 1274, 18495267, 'Dishes Ltd', 1006, 10, 10, 0, '2020-10-31 04:54:21');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20025, 1274, 31126609, 'Candles R Us', 1004, 33, 6, 3, '2020-10-05 10:59:31');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11629, 1274, 10914990, 'Dog Supplies Inc', 1007, 6, 58, 3, '2020-10-10 21:43:15');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (30272, 1274, 17830232, 'Pillow Co', 1002, 22, 22, 0, '2020-10-30 05:25:40');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10490, 1274, 16911640, 'Pillow Co', 1003, 23, 23, 0, '2020-10-26 01:26:41');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11193, 1274, 24356647, 'Dog Supplies Inc', 1007, 46, 68, 5, '2020-10-09 11:58:07');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21442, 1274, 22610107, 'Beauty Products Inc', 1004, 50, 1, 3, '2020-11-01 23:11:43');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21852, 1274, 17971908, 'Dishes Ltd', 1002, 18, 18, 0, '2020-10-20 00:50:29');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20233, 1274, 15844512, 'Beauty Products Inc', 1003, 46, 7, 3, '2020-10-16 13:26:30');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (20429, 1274, 36265956, 'Dog Supplies Inc', 1007, 4, 4, 0, '2020-10-07 15:58:17');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10799, 1274, 34145146, 'Beauty Products Inc', 1001, 46, 10, 4, '2020-10-25 15:18:25');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10455, 1274, 37584586, 'Pillow Co', 1001, 40, 34, 1, '2020-10-08 00:47:29');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10738, 1274, 38828609, 'Candles R Us', 1007, 11, 11, 0, '2020-10-07 04:24:10');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10771, 1274, 11321144, 'Beauty Products Inc', 1002, 46, 15, 2, '2020-10-29 00:56:04');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10616, 1274, 31958552, 'Candles R Us', 1002, 22, 46, 3, '2020-10-03 12:34:12');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10831, 1274, 10566454, 'Beauty Products Inc', 1002, 19, 47, 2, '2020-10-22 23:20:48');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (21529, 1274, 27532925, 'Candles R Us', 1004, 5, 5, 4, '2020-10-13 00:42:24');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10622, 1274, 16281854, 'Beauty Products Inc', 1007, 34, 59, 2, '2020-10-09 17:08:34');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10390, 1274, 28857670, 'Pillow Co', 1004, 26, 43, 4, '2020-10-17 19:29:13');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11747, 1274, 39513090, 'Dishes Ltd', 1006, 11, 66, 4, '2020-10-28 17:47:58');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11182, 1274, 15414617, 'Candles R Us', 1003, 21, 21, 0, '2020-10-12 05:45:27');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11001, 1274, 21959453, 'Candles R Us', 1007, 1, 72, 3, '2020-10-23 07:12:22');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (31105, 1274, 17081107, 'Beauty Products Inc', 1002, 12, 12, 0, '2020-10-19 19:30:35');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10264, 1274, 12703228, 'Pillow Co', 1002, 15, 15, 0, '2020-10-05 00:45:29');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (41346, 1274, 10882708, 'Dog Supplies Inc', 1003, 32, 32, 0, '2020-10-27 22:01:03');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (30699, 1274, 37046473, 'Dog Supplies Inc', 1001, 23, 32, 1, '2020-10-10 08:39:10');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10119, 1274, 30467935, 'Beauty Products Inc', 1003, 48, 1, 1, '2020-10-24 05:45:35');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10760, 1274, 35870818, null, 1007, 5, 55, null, '2020-10-05 01:01:29');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11164, 1274, 15888341, 'Dog Supplies Inc', 1001, 38, 38, 0, '2020-10-10 15:34:07');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10310, 1274, 14719543, null, 1007, 16, 40, null, '2020-11-01 07:07:29');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11238, 1274, 13901021, 'Dishes Ltd', 1001, 47, 14, 2, '2020-10-19 05:22:43');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (10539, 1274, 16521240, 'Dishes Ltd', 1001, 5, 75, 2, '2020-10-28 13:03:01');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11234, 1274, 21687158, 'Candles R Us', 1005, 40, 49, 4, '2020-11-01 23:47:17');
insert into [dbo].[locationAudits] ([auditID], [WHSLoc], [SKU], [Client], [AuditorID], [ExpQty], [CountedQty], [ErrorID], [AuditDate]) values (11437, 1274, 16697190, 'Dishes Ltd', 1004, 14, 59, 3, '2020-10-31 04:07:33');

CREATE TABLE [dbo].[employeeHours] (
	[AuditorID] int FOREIGN KEY REFERENCES [dbo].[Auditors]([AuditorID]),
	[dateWorked] Date,
	[hoursWorked] DECIMAL(6,2)
)

insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1000, '10/19/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1001, '10/19/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1002, '10/19/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1003, '10/19/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1004, '10/19/2020', 8.00);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1005, '10/19/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1006, '10/19/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1007, '10/19/2020', 10.00);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1000, '10/20/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1001, '10/20/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1002, '10/20/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1003, '10/20/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1004, '10/20/2020', 8.00);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1005, '10/20/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1006, '10/20/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1007, '10/20/2020', 10.00);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1000, '10/21/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1001, '10/21/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1002, '10/21/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1003, '10/21/2020', 9.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1004, '10/21/2020', 8.15);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1005, '10/21/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1006, '10/21/2020', 9.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1007, '10/21/2020', 10.00);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1000, '10/24/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1001, '10/24/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1002, '10/24/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1003, '10/24/2020', 9.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1004, '10/24/2020', 8.15);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1005, '10/24/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1006, '10/24/2020', 9.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1007, '10/24/2020', 10.00);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1000, '10/30/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1001, '10/30/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1002, '10/30/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1003, '10/30/2020', 9.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1004, '10/30/2020', 8.15);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1005, '10/30/2020', 10.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1006, '10/30/2020', 9.25);
insert into [dbo].[employeeHours] ([AuditorID], [dateWorked], [hoursWorked]) values (1007, '10/30/2020', 10.00);


--Write a SELECT query that uses a WHERE clause
SELECT *
FROM [dbo].[locationAudits]
WHERE [Client] = 'Pillow Co'

--Write a SELECT query that uses an OR and an AND operator
SELECT * 
FROM [dbo].[locationAudits]
WHERE [Client] = 'Dog Supplies Inc' AND ([AuditorID] = 1001 OR [AuditorID] =1003);

--Write a SELECT query that filters NULL rows using IS NOT NULL
SELECT [SKU], [Client], [ErrorID]
FROM [dbo].[locationAudits]
WHERE [ErrorID] IS NOT NULL;

--Write a DML statement that UPDATEs a set of rows with a WHERE clause.  The values used in the WHERE clause should be a variable
DECLARE @clientname varchar(50) = 'Beauty Products Inc'
UPDATE [dbo].[locationAudits]
SET [Client] = 'Beauty Inc'
WHERE [Client] = @clientname

--Write a DML statement that DELETEs a set of rows with a WHERE clause.  The values used in the WHERE clause should be a variable
DECLARE @inventory_managers varchar(50) = 'Inventory'
DELETE FROM [dbo].[Managers] WHERE [Department] <> @inventory_managers

--Write a DML statement that DELETEs rows from a table that another table references.  This script will have to also DELETE any records that reference these rows.  Both of the DELETE statements need to be wrapped in a single transaction.
BEGIN TRANSACTION
	DELETE FROM [dbo].[locationAudits]
	WHERE [AuditorID] = 1004

	DELETE FROM [dbo].[employeeHours]
	WHERE [AuditorID] = 1004

	DELETE FROM [dbo].[Auditors]
	WHERE [AuditorID] = 1004

COMMIT;


--Write a SELECT query that utilizes a JOIN
SELECT [dbo].[locationAudits].[auditID], [dbo].[Auditors].[auditorFirstName] + ' ' + [dbo].[Auditors].[auditorLastName] AS auditorFullName, [dbo].[locationAudits].[AuditDate]
FROM [dbo].[locationAudits]
JOIN [dbo].[Auditors] ON [dbo].[locationAudits].[AuditorID] = [dbo].[Auditors].[AuditorID]

--Write a SELECT query that utilizes a JOIN with 3 or more tables
SELECT la.[auditID], a.[auditorFirstName] + ' ' + a.[auditorLastName] AS auditorFullName, m.[managerFirstName] + '  ' + m.[managerLastName] AS managerFullName
FROM [dbo].[locationAudits] la
JOIN [dbo].[Auditors] a
ON la.[AuditorID] = a.[AuditorID]
JOIN [dbo].[Managers] m
ON m.[ManagerID] = a.[ManagerID]

--Write a SELECT query that utilizes a LEFT JOIN
SELECT a.[AuditorID], a.[auditorFirstName] + ' ' + a.[auditorLastName] AS auditorFullName, m.[managerFirstName] + ' ' + m.[managerLastName] AS managerFullName
FROM [dbo].[Auditors] a
LEFT JOIN [dbo].[Managers] m
ON a.[ManagerID] = m.[ManagerID]
WHERE m.[managerFirstName] = 'William' AND m.[managerLastName] = 'Redd'

--Write a SELECT query that utilizes a variable in the WHERE clause
DECLARE @good_audits int = 0
SELECT *
FROM [dbo].[locationAudits]
WHERE [ErrorID] = @good_Audits

--Write a SELECT query that utilizes a ORDER BY clause
SELECT * 
FROM [dbo].[locationAudits]
ORDER BY [AuditDate]

--Write a SELECT query that utlizies a GROUP BY clause along with an aggregate function
SELECT [ErrorID], COUNT(*) AS countofErrors
FROM [dbo].[locationAudits]
GROUP BY [ErrorID];

--Write a SELECT query that utilizes a CALCULATED FIELD
SELECT [auditID], [SKU], [ErrorID], [ExpQty], [CountedQty], ([CountedQty] - [ExpQty]) AS Adjustment
FROM [dbo].[locationAudits];


--Write a SELECT query that utilizes a SUBQUERY *will show employees earning below active employee average hourly wage
  SELECT [auditorFirstName] + ' ' + [auditorLastName] AS auditorFullName, [ManagerID], [HourlyRate]
  FROM [dbo].[Auditors]
  WHERE [HourlyRate] < (
	SELECT AVG([HourlyRate])
	FROM [dbo].[Auditors]
	WHERE [EmployeeStatus] = 'Active'
  )


--Write a SELECT query that utliizes a JOIN, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC) AND A GROUP BY clause with and aggregate function
SELECT la.[ErrorID], MAX(ae.[ErrorType]) AS [ErrorType], COUNT(la.[ErrorID]) AS countofErrors
FROM [dbo].[locationAudits] la
JOIN [dbo].[auditErrors] ae
ON la.[ErrorID] = ae.[ErrorID]
WHERE la.[AuditDate] >= '2020-10-22' and la.[AuditDate] < dateadd(day,1,'2020-10-22') AND la.[AuditorID] = '1007'
GROUP BY la.[ErrorID]


--Write a SELECT query that utilizes a JOIN with 3 or more tables, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC.) a GROUP BY clause with an aggregate function and a HAVING clause
SELECT la.[AuditorID], a.[auditorFirstName] + ' ' + a.[auditorLastName] AS AuditorFullName, COUNT(la.[AuditorID]) AS AuditsPerEmployee, m.[managerLastName]
FROM [dbo].[locationAudits] la
JOIN [dbo].[Auditors] a
ON la.[AuditorID] = a.[AuditorID]
JOIN [dbo].[Managers] m
ON m.[ManagerID] = a.[ManagerID]
WHERE la.[AuditDate] >= '2020-10-15' and la.[AuditDate] < dateadd(day,1,'2020-10-31 00:00')
GROUP BY la.[AuditorID], a.[auditorFirstName] + ' ' + a.[auditorLastName], m.[managerLastName]
HAVING COUNT(la.[AuditorID]) > 20

--Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the perfomance of one of the above queries
CREATE NONCLUSTERED INDEX IX_locationAudits_Client
ON [dbo].[locationAudits] ([Client])

--Design a NONCLUSTERED INDEX with TWO KEY COLUMNS that improves the performance of one of the above queries
CREATE NONCLUSTERED INDEX IX_Managers_fullname
ON [dbo].[Managers] ([managerFirstName], [managerLastName])

--Design a NONCLUSTERED INDEX with at least one key column and at least on included column that improves the performance of one of the above queries
CREATE NONCLUSTERED INDEX IX_Auditors_EmployeeStatus
ON [dbo].[Auditors] ([EmployeeStatus])
INCLUDE ([HourlyRate]);


DROP TABLE [dbo].[locationAudits]
DROP TABLE [dbo].[employeeHours]
DROP TABLE [dbo].[auditErrors]
DROP TABLE [dbo].[Auditors]
DROP TABLE [dbo].[Managers]




