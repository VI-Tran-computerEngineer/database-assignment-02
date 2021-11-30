CREATE TRIGGER UTG_add_warehouse
ON CONSIGNMENTS
AFTER INSERT
AS
	BEGIN 
	UPDATE RESTAURANT_BRANCH
	SET percent_warehouse_available=percent_warehouse_available+0.1
	FROM  RESTAURANT_BRANCH, inserted
	WHERE RESTAURANT_BRANCH.branch_name = inserted.branch_name
	END	
GO


CREATE TRIGGER UTG_del_warehouse 
ON CONSIGNMENTS
AFTER DELETE
AS
	BEGIN 
	UPDATE RESTAURANT_BRANCH
	SET percent_warehouse_available = percent_warehouse_available-0.1
	FROM RESTAURANT_BRANCH,deleted
	WHERE RESTAURANT_BRANCH.branch_name = deleted.branch_name
	END
GO