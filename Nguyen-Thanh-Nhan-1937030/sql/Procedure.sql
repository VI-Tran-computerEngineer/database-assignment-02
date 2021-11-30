CREATE PROC find_vou 
@val int 
AS
BEGIN
	SELECT dbo.VOUCHERS.voucher_id, dbo.VOUCHERS.voucher_status, dbo.VOUCHERS.voucher_value, dbo.PROMOTIONS.end_day FROM dbo.VOUCHERS, dbo.PROMOTIONS
	WHERE dbo.VOUCHERS.promotion_id = DBO.PROMOTIONS.promotion_id AND dbo.VOUCHERS.voucher_value > @val ORDER BY dbo.VOUCHERS.voucher_value 
END
GO



CREATE PROC find_pro 
AS
BEGIN
	SELECT  dbo.VOUCHERS.promotion_id,dbo.PROMOTIONS.promotion_name, dbo.PROMOTIONS.begin_day, dbo.PROMOTIONS.end_day,  SUM(dbo.VOUCHERS.voucher_value) AS sum1  FROM dbo.VOUCHERS, dbo.PROMOTIONS WHERE dbo.VOUCHERS.promotion_id = DBO.PROMOTIONS.promotion_id
	GROUP BY dbo.VOUCHERS.promotion_id,dbo.PROMOTIONS.end_day,dbo.PROMOTIONS.begin_day,dbo.PROMOTIONS.promotion_name ORDER BY sum1 
END
GO



CREATE PROC update_vou  
AS
BEGIN
	UPDATE dbo.VOUCHERS SET voucher_status = 'Expired' 
	WHERE voucher_status = 'Available' and  voucher_id in (SELECT  dbo.VOUCHERS.voucher_id FROM dbo.VOUCHERS,dbo.PROMOTIONS where dbo.VOUCHERS.promotion_id = DBO.PROMOTIONS.promotion_id AND dbo.PROMOTIONS.end_day < GETDATE())
	
END
GO
