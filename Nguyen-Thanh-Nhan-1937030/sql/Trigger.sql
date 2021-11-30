CREATE TRIGGER insert_voucher 
ON dbo.VOUCHERS FOR INSERT 
AS
BEGIN
	UPDATE DBO.PROMOTIONS SET number_of_voucher = number_of_voucher +1 FROM dbo.PROMOTIONS , INSERTED WHERE INSERTED.promotion_id = DBO.PROMOTIONS.promotion_id;
END
GO



CREATE TRIGGER delete_voucher 
ON dbo.VOUCHERS FOR DELETE
AS
BEGIN
	UPDATE DBO.PROMOTIONS SET number_of_voucher = number_of_voucher -1 FROM dbo.PROMOTIONS , DELETED WHERE DELETED.promotion_id = DBO.PROMOTIONS.promotion_id;
END
GO



CREATE TRIGGER date_check  ON dbo.VOUCHERS FOR INSERT
AS
BEGIN
	DECLARE @check_date DATE;
	SELECT @check_date= end_day FROM  dbo.PROMOTIONS , INSERTED WHERE INSERTED.promotion_id = DBO.PROMOTIONS.promotion_id
	IF @check_date < GETDATE()
	BEGIN
		PRINT N'ky khuyen mai da ket thuc'
		ROLLBACK TRAN
   END
END

