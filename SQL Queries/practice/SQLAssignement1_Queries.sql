-- 1). creating database MD342MadanMohanDas

	CREATE DATABASE MD342MadanMohanDas

-- 2). creating table MDEmployee342
	USE MadanMohan342

	CREATE TABLE MDEmployee(

		MDEmployeeID INT IDENTITY(1,1),
		MDEmployeeFirstName VARCHAR(50),
		MDEmployeeLastName VARCHAR(50),
		MDEmployeeGender VARCHAR(6),
		MDEmployeeADDress NVARCHAR(max),
		MDEmployeeDOB DATE,
		MDEmployeeAge TINYINT, -- age should not be more than 255
		MDEmployeeCountryCode VARCHAR(10),
		MDEmployeeMobileNumber1 VARCHAR(15), --across globle Mnumber not more than 15
		MDEmployeeMobileNumber2 VARCHAR(15),
		MDEmployeeEmailID VARCHAR(100),
		MDEmployeeCity VARCHAR(20),
		MDEmployeePincode VARCHAR(6),
		MDEmployeeDOJ DATE,
		MDEmployeeDepartmentID INT, 
		MDEmployeeDesignation VARCHAR(50),
		MDEmployeeSalary DECIMAL(10,2), --after DECIMAL 2 digit
	);

-- 3). performing alter command on table

	ALTER TABLE MDEmployee ADD CreatedON DATETIME;  -- adding CreatedON column
	ALTER TABLE MDEmployee ADD CreatedBY VARCHAR(50); -- adding CreatedBY column
	ALTER TABLE MDEmployee ADD UpdatedON DATETIME; --adding UpdatedON column
	ALTER TABLE MDEmployee ADD UpdatedBY VARCHAR(50); --adding UpdatedBY column
	ALTER TABLE MDEmployee ALTER COLUMN MDEmployeePincode VARCHAR(12); --changing size of pincode to 12
	EXEC sp_RENAME 'MDEmployee.MDEmployeeADDress', 'MDEmployeeAddress', 'COLUMN' --changing column name

-- 4). applying constraints on column using alter command
	
	--a) NOT NULL
		ALTER TABLE MDEmployee ALTER COLUMN MDEmployeeID INT NOT NULL;
		ALTER TABLE MDEmployee ALTER COLUMN MDEmployeeFirstName VARCHAR(50) NOT NULL;
		ALTER TABLE MDEmployee ALTER COLUMN MDEmployeeLastName VARCHAR(50) NOT NULL;
		ALTER TABLE MDEmployee ALTER COLUMN MDEmployeeGender VARCHAR(6) NOT NULL;
		ALTER TABLE MDEmployee ALTER COLUMN MDEmployeeDOB DATE NOT NULL;
		ALTER TABLE MDEmployee ALTER COLUMN MDEmployeeEmailID VARCHAR(100) NOT NULL;
	

	--b) UNIQUE
		ALTER TABLE MDEmployee ADD CONSTRAINT u_email UNIQUE(MDEmployeeEmailID);

	--c)DEFAULT
		ALTER TABLE MDEmployee ADD DEFAULT 'MohanDas' FOR CreatedBY; --Adding DEFAULT value to CreatedBY COLUMN
		ALTER TABLE MDEmployee ADD DEFAULT current_timestamp FOR CreateddON;  --Adding DEFAULT value to CreatedON COLUMN
		ALTER TABLE MDEmployee ADD DEFAULT '2023-01-23' FOR MDEmployeeDOJ;

	--d)CHECK
		ALTER TABLE MDEmployee ADD CHECK (MDEmployeeAge > 18 AND MDEmployeeAge < 80);
		
	--e)PRIMARY KEY
		ALTER TABLE MDEmployee ADD PRIMARY KEY (MDEmployeeID) --ADDing PRIMARY KEY to MDEmployeeID

	--d)FOREIGN KEY
		CREATE TABLE MDDepartment(

			MDDepartmentID INT IDENTITY(1,1) PRIMARY KEY,
			MDDepartmentName VARCHAR(100)
			);

		--assigning Foreign key to MDEmployeeDepartmentID
		ALTER TABLE MDEmployee ADD FOREIGN KEY(MDEmployeeDepartmentID) REFERENCES MDDepartment(MDDepartmentID);

--5). Inserting records in tables
	--Inserting values into MDDepartment table
		INSERT INTO MDDepartment(MDDepartmentName) VALUES('Dot Net');
		INSERT INTO MDDepartment(MDDepartmentName) VALUES('Angular')
		INSERT INTO MDDepartment(MDDepartmentName) VALUES('Mobile');
		INSERT INTO MDDepartment(MDDepartmentName) VALUES('Sales');
		INSERT INTO MDDepartment(MDDepartmentName) VALUES('IT');

	-- Inserting values into MDEmployee table with DEFAULT values of CreatedBY and CreatedON
	INSERT INTO MDEmployee
	(
		MDEmployeeFirstName, MDEmployeeLastName, MDEmployeeGender, MDEmployeeAddress, MDEmployeeDOB, MDEmployeeAge,
		MDEmployeeCountryCode, MDEmployeeMobileNumber1, MDEmployeeMobileNumber2, MDEmployeeEmailID, MDEmployeeCity, MDEmployeePincode,
		MDEmployeeDepartmentID, MDEmployeeDesignation, MDEmployeeSalary )
	VALUES
	('MadanMohan', 'Das', 'Male', 'D cabin,Sabarmati, Ahmedabad', '2000-03-01', 78, '+91','9899827272','898987777','moha23n@gmail.com','Ahmedabad',344455, 1, 'Software Developer Trainee', 20000),
	('Vikrant', 'Anand', 'Male', 'Bopal Gam', '2002-08-02', 38, '+91','9899827000','9099877767','vkanand@gmail.com','Ahmedabad',390008, 2, 'Software Developer Trainee', 22000 ),
	('Jatin', 'Dhote', 'Male', '12/2 Sanskruti society,near bopal gam', '2000-10-12', 38, '+91','9999827000','9090977767','katind@gmail.com','Ahmedabad',391108, 1, 'Software Developer Trainee', 20000),
	('Niki','Patel','Female','11/2 Anand Complex,near IOC road, chandkheda','1998-02-10',25,'+91','9000667656','9988776655','nkpatel@yahoo.com','Ahmedabad',358800,3,'Software Developer Trainee',22000),
	('Shashank','Kirad','Male','87/2 Narmada Society, near navrangpura','1995-12-01',28,'+91','9001617181','8900980989','shashank@gmail.com','Ahmedabad',380005,2,'Software Developer Trainee',18500.50),
	('Raj','Barot','Male','Sargasan','1998-10-10',25,'+91','9990002233','9090908080','rajb@outlook.com','Gandhinagar',310023,1,'Software Developer Trainee',20000.25);

	-- Inserting values into MDEmployee table with overrding DEFAULT values of CreatedBY and CreatedON
	INSERT INTO MDEmployee
	(
		MDEmployeeFirstName, MDEmployeeLastName, MDEmployeeGender, MDEmployeeAddress, MDEmployeeDOB, MDEmployeeAge,
		MDEmployeeCountryCode, MDEmployeeMobileNumber1, MDEmployeeMobileNumber2, MDEmployeeEmailID, MDEmployeeCity, MDEmployeePincode,
		MDEmployeeDepartmentID, MDEmployeeDesignation, MDEmployeeSalary, CreatedON, CreatedBY )
	VALUES
	( 'Mihir', 'Patel', 'Male', '147 Shaligram Complex, near Vaishodevi circle', '2000-12-12', 30, '+91','8988776523','8777090999','mihirp@gmail.com','Ahmedabad',390098, 3, 'Software Developer Trainee', 22000.50, '2023-02-28 11:12:11.123','HR Shaligram'),
	( 'Vedang', 'Prajapati', 'Male', '14 Satyam Complex, near science city', '2002-11-11', 35, '+91','9998776523','8777000999','vedangp@gmail.com','Ahmedabad',300898, 5, 'Software Developer Trainee', 20000.50, '2023-03-28 10:10:10.111','HR Shaligram');
	( 'Dhruvi','Modi','Female','23 Satya Complex, near AMC market vasna','1995-12-12',28,'+91','9898987676','9725676767','modidhrumil@gmail.com','Ahmedabad',399099,2,'Software Developer Trainee',21500,'2023-02-12 11:23:23.100','HR Shaligram'),
	( 'Chirag','Jadav','Male','12/11 Rajiv Opal, near manigar brts','2002-12-01',21,'+91','9990098987','9989887767','chiragj@yahoo.com','Ahmedabad',342525,2,'Software Developer Trainee',18000.50,'2023-01-29 15:23:23.232','HR Shaligram');

--6). Deleting records from table
	DELETE FROM MDEmployee where MDEmployeeAddress='Sargasan'
	DELETE FROM MDEmployee where MDEmployeeDepartmentID=1

--7). Updating records of the table
	BEGIN TRAN
		UPDATE MDEmployee SET MDEmployeeDOB='1985-01-11', UpdatedON=CURRENT_TIMESTAMP, UpdatedBY='Mohan Das' WHERE MDEmployeeFirstName='Vikrant';
		UPDATE MDEmployee SET MDEmployeeDOB='1988-01-01', MDEmployeeDesignation='IT Engineer', UpdatedON=CURRENT_TIMESTAMP, UpdatedBY='Mohan Das' WHERE MDEmployeeFirstName='Vedang' AND MDEmployeeLastName='Prajapati';
		UPDATE MDEmployee SET MDEmployeeDOB='1993-01-01', UpdatedON=CURRENT_TIMESTAMP, UpdatedBY='Mohan Das' WHERE MDEmployeeEmailID='mihirp@gmail.com';
		UPDATE MDEmployee SET MDEmployeeDesignation='Mobile Development Engineer', UpdatedON=CURRENT_TIMESTAMP, UpdatedBY='Mohan Das' WHERE MDEmployeeDepartmentID=3;

	COMMIT TRAN
	ROLLBACK TRAN

--8). Retriving record from table
		SELECT * FROM MDEmployee;
		SELECT * FROM MDDepartment;

		--Selecting those records where designation is mobile development engineer
		SELECT MDEmployeeID,MDEmployeeFirstName,MDEmployeeLastName,MDEmployeeSalary FROM MDEmployee WHERE MDEmployeeDesignation='Mobile Development Engineer';
		
		--selecting firstname,lastname,departmentID of employee whose salary is more then 20000
		SELECT MDEmployeeFirstName, MDEmployeeLastName, MDEmployeeDepartmentID, MDEmployeeSalary FROM MDEmployee WHERE MDEmployeeSalary > 20000;

		--selecting employees whose firstname start with 'V'
		SELECT * FROM MDEmployee WHERE MDEmployeeFirstName LIKE 'V%';

		--selecting employee whose birth after year 2000
		SELECT * FROM MDEmployee WHERE MDEmployeeDOB < '2000-01-01';

		--slecting employee whose birth year is between 1990 and 2000
		SELECT * FROM MDEmployee WHERE MDEmployeeDOB BETWEEN '1990-01-01' AND '2000-01-01';

		--getting maximum salary
		SELECT MAX(MDEmployeeSalary) FROM MDEmployee;

		--counting no. of male employees
		SELECT COUNT(MDEmployeeID) AS 'NO OF FEMALE EMPLOYEE' FROM MDEmployee WHERE MDEmployeeGender='FEMALE';

		--counting no. of female employees
		SELECT COUNT(MDEmployeeID) AS 'NO OF MALE EMPLOYEE' FROM MDEmployee WHERE MDEmployeeGender='MALE';
		
		--selecting the employees record which are no updated yet
		SELECT * FROM MDEmployee WHERE UpdatedON IS NULL AND UpdatedBY IS NULL  --IS NULL is used to find which column values are null