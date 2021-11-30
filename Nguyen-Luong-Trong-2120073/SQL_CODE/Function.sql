CREATE FUNCTION check_materialsDate(@material_name VARCHAR(50))
RETURNS INT
AS 
	BEGIN 
	DECLARE @Date INT
	SELECT @Date = DATEDIFF(DAY,CAST(GETDATE()AS DATE),DISHES_MATERIALS.expired_day) FROM dbo.DISHES_MATERIALS WHERE material_name=@material_name		
	RETURN @DATE
	END
GO

CREATE FUNCTION shouldBeUseFirst(@Date int)
RETURNS VARCHAR(50)
AS 
BEGIN
	IF(@Date < 15)
		BEGIN
			RETURN 'use soon'
		END
	ElSE 
	BEGIN
		RETURN 'use later'
	END

	RETURN 'Can not define'
END
GO


CREATE FUNCTION check_bonuspoint(@bonus_point int)
RETURNS VARCHAR(50)
AS 
BEGIN 
	IF(@bonus_point > 50)
		BEGIN
		RETURN 'accept'
		END
	ELSE
		BEGIN 
		RETURN 'unacceptable'
		END
	RETURN 'Can not define'
END
GO