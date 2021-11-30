CREATE PROC add_vou 
	@voucher_id CHAR(7),
    @promotion_id char(8),
    @voucher_value int
AS
BEGIN
	DECLARE @flag AS INT =0 
	DECLARE @count AS INT=0 
	IF @voucher_id =NULL OR @promotion_id=NULL OR  @voucher_value= NULL
	BEGIN
		RAISERROR('cant insert null information',16,1)
		SET @flag = -1
    END
    IF @voucher_value <= 0 OR @voucher_value > 200  
	BEGIN
		RAISERROR('wrong value',16,1)
		SET @flag = -1
	END	
	SELECT @count = COUNT(dbo.PROMOTIONS.promotion_id) FROM dbo.PROMOTIONS WHERE dbo.PROMOTIONS.promotion_id = @promotion_id
	IF @count =0 
	BEGIN
		RAISERROR('wrong promotion id',16,1)
		SET @flag = -1
	END
	IF @flag =0 
	BEGIN
		INSERT dbo.VOUCHERS
		(
		    voucher_id,
		    promotion_id,
		    voucher_status,
		    voucher_value
		)
		VALUES
		(   @voucher_id,                    
		    @promotion_id,                    
		    'Available',                    
		    @voucher_value                      
		    )
	END
END
