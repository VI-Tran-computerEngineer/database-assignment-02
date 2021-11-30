CREATE PROCEDURE getEmployeeAndManager()
BEGIN
	SELECT CONCAT(E.Fname, " ", E.Minit, " ", E.Lname) as Employee, 
    	   CONCAT(M.Fname, " ", M.Minit, " ", M.Lname) as Manager
    FROM EMPLOYEES E, MANAGERS M
    WHERE E.mgr_id = M.account_id
    ORDER BY E.Fname; 
END;

CREATE PROCEDURE getEmployeeFromSearch(search VARCHAR(255), mgr INT)
BEGIN
	SELECT *
    FROM EMPLOYEES E
    WHERE E.mgr_id=mgr AND E.Fname LIKE CONCAT("%", search, "%") OR 
    E.Minit LIKE CONCAT("%", search, "%") OR
    E.Lname LIKE CONCAT("%", search, "%")
    ORDER BY E.Fname;
END;