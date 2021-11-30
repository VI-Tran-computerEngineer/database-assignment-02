CREATE FUNCTION getEmployeeWithWorkDay (
mgr INT, work_date INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE checkManager INT DEFAULT 0;
    DECLARE result INT DEFAULT 0;
    
 	--  Kiểm tra số ngày làm trong một tháng không vượt quá 30 
	IF work_date > 30 THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Working day must be less than 30 days!';
    END IF;
    
    SELECT COUNT(*)
    INTO checkManager
    FROM MANAGERS M
    WHERE M.account_id=mgr;
    
    --  Kiểm tra liệu có tồn tại manager với mã đã cho không
    IF checkManager = 0 THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='The manager id does not exist';
    END IF;
    
    SELECT COUNT(*)
    INTO result
    FROM EMPLOYEES E
    WHERE E.mgr_id=mgr && E.working_date_per_month > work_date;
    
    RETURN (result);
END;

CREATE FUNCTION getTotalManagerWithToeic(toeic INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE result INT DEFAULT 0;
    --  Kiểm tra toeic không vượt quá 990
    IF toeic > 990 THEN
    	SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The toeic certification must be less than 990';
    END IF;
    
    SELECT COUNT(*)
    INTO result
    FROM MANAGERS M
    WHERE M.toeic_certification >= toeic;
    
    RETURN (result);
END;