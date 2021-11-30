CREATE PROCEDURE ADD_CUSTOMERS
@account_id CHAR(7) ,
@username VARCHAR(50) ,
@password VARCHAR(50) ,
@email VARCHAR(50),
@phone_number CHAR(11) ,
@Fname VARCHAR(50) ,
@Minit VARCHAR(50),
@Lname VARCHAR(50) ,
@Bdate DATE,
@gender CHAR(8) ,
@registration_date SMALLDATETIME,
@bonus_point INT 
AS
BEGIN
	IF EXISTS (SELECT * FROM CUSTOMERS WHERE account_id = @account_id OR username = @username )
		BEGIN 
			PRINT 'Username already exists. Please check again!';
			RETURN 0
		END
	IF (LEN(@password)<5)
		BEGIN 
			PRINT 'password is too short. Please enter a password of 5 or more characters.';
			RETURN 0
		END
	IF (@email NOT LIKE '%[A-Z0-9][@][A-Z0-9]%[.][A-Z0-9]%')
		BEGIN 
			PRINT 'Email format is incorrect. Please re-enter.';
			RETURN 0
		END
	IF (LEN(@phone_number)<10)
		BEGIN
			PRINT 'Please re-enter the phone number. Phone number must be 10 digits';
			RETURN 0
		END
	IF(@Fname LIKE '%[0-9,!,@,#,;,$,%,^,&,*,(,)]%' OR @Minit LIKE '%[0-9,!,@,#,;,$,%,^,&,*,(,)]%' OR @Lname Like '%[0-9,!,@,#,;,$,%,^,&,*,(,)]%')
		BEGIN
			PRINT 'The name cannot contain special characters. Please re-enter.';
			RETURN 0
		END
	IF(@gender <> 'Male' AND @gender <> 'Female' AND @gender <> 'LGBT')
		BEGIN
			PRINT 'The gender you entered is incorrect. Please re-enter!';
			RETURN 0
		END
	IF(@bonus_point < 0)
		BEGIN
			PRINT 'Incorrectly entered bonus points. Please re-enter!';
			RETURN 0
		END
	INSERT INTO CUSTOMERS (account_id, username, password, email, phone_number, Fname,Minit,Lname, Bdate, gender, registration_date, bonus_point)
	VALUES (@account_id, @username, @password, @email, @phone_number, @Fname, @Minit, @Lname, @Bdate, @gender, GETDATE(), @bonus_point)
END
