USE MadanMohan342;
CREATE TABLE STUDENT(
	StuID INT IDENTITY(1,1) NOT NULL,
	StuName VARCHAR(100),
	StuMarks1 TINYINT,
	StuMarks2 TINYINT,
	StuMarks3 TINYINT,
	);

	ALTER TABLE STUDENT ADD CONSTRAINT check_marks1 CHECK(StuMarks1 >=0 AND StuMarks1 <=100);
	ALTER TABLE STUDENT ADD CONSTRAINT check_marks2 CHECK(StuMarks2 >=0 AND StuMarks2 <=100);
	ALTER TABLE STUDENT ADD CONSTRAINT check_marks3 CHECK(StuMarks3 >=0 AND StuMarks3 <=100);
	

--CREATING TRIIGER THAT WILL FIRE AFTER INSRTING THE RECORD IN TABLE AND CALCULATE THE PERCENTAGE OF STUDENT
alter TRIGGER getPercentage
ON STUDENT
AFTER INSERT
AS
BEGIN
	SELECT * FROM STUDENT;
	SELECT StuName AS 'Student Name', CONCAT((StuMarks1+StuMarks2+StuMarks3)/3,'%') 
	AS 
	'Percentage Of Newly Inserted Student' FROM INSERTED;
END;
--"INSERTED" is a keyword used in trigger to get the inserted values

INSERT INTO STUDENT VALUES('Jatin',10,20,30);