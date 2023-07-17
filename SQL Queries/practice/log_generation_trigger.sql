--CREATING THE LOG FOR THE TABLE MDEMPLOYEE AND MDDEPARTMENT INSERT AND DELETE ONLY
select * from mdemployee;
select * from mddepartment;

CREATE TABLE LogTable
(
	date_time as current_timestamp,
	messageTxt NVARCHAR(MAX)
);
drop table logtable

ALTER TRIGGER insert_log
ON MDDepartment
AFTER INSERT
AS 
BEGIN
DECLARE
	@ID INT;
	SELECT @ID = MDDepartmentID FROM INSERTED;
	INSERT INTO LogTable(messageTxt) VALUES(CONCAT('Record inserted with department id ',@ID));

END;

--AFTER DELETE TRIGGER
ALTER TRIGGER delete_log
ON MDDepartment
AFTER DELETE
AS 
BEGIN
DECLARE
	@ID INT;
	SELECT @ID = MDDepartmentID FROM DELETED;
	INSERT INTO LogTable(messageTxt) VALUES(CONCAT('Record deleted department id ',@ID));

END;
INSERT INTO MDDepartment VALUES('Architecture')

select * from logtable;