-- thu tuc them mot hang vao EMPLOYEES
CREATE PROCEDURE addEmployee(
    username VARCHAR(50),
    password varchar(50),
    email VARCHAR(50),
  	mgr_id INT,
    phone_number char(11),
    Fname VARCHAR(50),
    Minit VARCHAR(50),
    Lname VARCHAR(50),
    Bdate DATE,
    gender CHAR(8),
    registration_date DATE,
    working_date_per_month INT)
BEGIN
	DECLARE uniqueUsername INT DEFAULT 0;
    --  Kiem tra xem username da ton tai chua
    SELECT COUNT(*)
    INTO uniqueUsername
    FROM EMPLOYEES E
    WHERE E.username=username;
    
    IF uniqueUsername > 0 THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The username already exists';
    END IF;
	
    -- username khong duoc bang null
	IF username <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username must be different from null';
    END IF;
	
    --  password khong duoc bang null
    IF password <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password must be different from null';
    END IF;
    
    --  email phai dung dinh dang email
    IF email NOT REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,63}$' THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This is not a valid email';
    END IF;
    
    --  Fname khong duoc bang null
    IF Fname <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'First name must be different from null';
    END IF;
    
    --  Minit khong duoc bang null
    IF Minit <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Minit must be different from null';
    END IF;
    
    --  Lname khong duoc bang null
    IF Lname <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Last name must be different from null';
    END IF;
    
    --  Gender phai la Male, Female hoac LGBT
    IF gender!='male' AND gender!='Male' AND gender!='female' AND gender!='Female' AND gender!='LGBT' THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gender must be \'Female\' or \'Male\' or \'LGBT\'';
    END IF;
    
    --  So ngay lam viec mot thang khong duoc vuot qua 30
    IF working_date_per_month > 30 THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Working day per month should not be more than 31';
    END IF;
    
	
	INSERT INTO EMPLOYEES(username, password, email, mgr_id, phone_number,
                             Fname, Minit, Lname, Bdate, 
                             gender, registration_date, working_date_per_month)
	VALUES(username, password, email, mgr_id, phone_number,
                             Fname, Minit, Lname, Bdate, 
                             gender, registration_date, working_date_per_month);
END;

-- add manager
CREATE PROCEDURE addManager(username VARCHAR(50),
                            age INT,
                            college_certification VARCHAR(255),
                            toeic_certification INT,
                           	Fname VARCHAR(50),
                          	Minit VARCHAR(50),
                           	Lname VARCHAR(50))
BEGIN
	DECLARE uniqueUsername INT DEFAULT 0;
    --  Kiem tra xem username da ton tai chua
    SELECT COUNT(*)
    INTO uniqueUsername
    FROM MANAGERS M
    WHERE M.username=username;
    
    IF uniqueUsername > 0 THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The username already exists';
    END IF;
    
    --  username khong duoc bang null
	IF username <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username must be different from null';
    END IF;
	
    --  quan ly phai it nhat 18 tuoi
    IF age < 18 THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid age';
    END IF;
    
    --  diem thi hop le cua Toeic
    IF toeic_certification < 0 OR toeic_certification > 990 THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid toeic certification';
    END IF;
    
    --  Fname khong duoc bang null
   	IF Fname <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'First name must be different from null';
    END IF;
   
	--  Minit khong duoc bang null   
	IF Minit <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Minit must be different from null';
    END IF;    
    
    --  Lname khong duoc bang null 
    IF Lname <=> NULL THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Last name must be different from null';
    END IF;
    
	INSERT INTO MANAGERS(username, age, college_certification, 
                         toeic_certification, Fname, Minit, Lname)
    VALUES(username, age, college_certification, 
                         toeic_certification, Fname, Minit, Lname);
END;