CREATE PROCEDURE up_numOfOrder 

AS BEGIN
SELECT account_id, Fname,Bdate,bonus_point ,COUNT(ORDER_DISHES.customer_id) as num_of_order
	FROM CUSTOMERS INNER JOIN ORDER_DISHES ON CUSTOMERS.account_id = ORDER_DISHES.customer_id

GROUP BY ORDER_DISHES.customer_id,Fname,Bdate,bonus_point,account_id
ORDER BY num_of_order
END
GO

CREATE PROCEDURE up_supplier
AS
BEGIN
SELECT SUPPLIERS.supplier_name,SUPPLIERS.supplier_email,COUNT(CONSIGNMENTS.consignment_id ) as num_of_consignment
FROM SUPPLIERS, CONSIGNMENTS
WHERE SUPPLIERS.supplier_name = CONSIGNMENTS.supplier 
GROUP BY SUPPLIERS.supplier_name,SUPPLIERS.supplier_email
ORDER BY num_of_consignment DESC
END
GO