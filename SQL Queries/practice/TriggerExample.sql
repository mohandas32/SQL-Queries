
USE MadanMohan342;

	--CREATING TRIGGER THAT WILL EXECUTE AFTER THE RECORD IS INSERTED INTO MDDepartment table
	CREATE TRIGGER InsertMSgDepartment
	ON MDDepartment
	AFTER INSERT
	AS 
	BEGIN
		SELECT 'Record is inserted in MDDepartment table' AS [MESSAGE];
	END;

	INSERT INTO MDDepartment(MDDepartmentName) VALUES('Designing');
	