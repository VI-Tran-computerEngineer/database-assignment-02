CREATE function check_vou (@id CHAR(7))
RETURNS int
AS
BEGIN 
	DECLARE @i int = 0
	DECLARE @d SMALLDATETIME
	DECLARE @s VARCHAR(10)
	SELECT @i= count  (dbo.VOUCHERS.promotion_id ),@d= dbo.PROMOTIONS.end_day FROM dbo.VOUCHERS join dbo.PROMOTIONS on dbo.VOUCHERS.promotion_id = DBO.PROMOTIONS.promotion_id
	WHERE dbo.VOUCHERS.voucher_id = @id AND 'Available' = dbo.VOUCHERS.voucher_status GROUP BY dbo.PROMOTIONS.end_day
	IF @i=1
	BEGIN
		IF @d > GETDATE() 
		BEGIN
			RETURN DATEDIFF(DAY,GETDATE(),@d )    
		END
		ELSE RETURN @i-1 
	END
    ELSE RETURN @i-1 
	RETURN @i
END
GO




CREATE function val_vou (@id CHAR(7))
RETURNS int
AS
BEGIN
DECLARE @check int = 0
DECLARE @v int
SELECT @v = dbo.VOUCHERS.voucher_value FROM dbo.VOUCHERS WHERE dbo.VOUCHERS.voucher_id = @id
SELECT @check = dbo.check_vou(@id)
IF @check >0 RETURN  @v
ELSE RETURN 0
RETURN 0
END
GO
