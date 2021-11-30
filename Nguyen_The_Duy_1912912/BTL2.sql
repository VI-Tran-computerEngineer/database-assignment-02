
use db_assigment2

/*procedure to insert a new product*/
DROP PROCEDURE insert_dishes
go
CREATE PROCEDURE insert_dishes(
	@dish_id char(7),
    @dish_name varchar(50),
    @dish_image varchar(255),
    @dish_description varchar(255),
    @price int ,
    @category_id char(7)
)
AS 
BEGIN  
DECLARE @cate varchar(20)
SELECT @cate = category_id FROM DISHES_CATEGORIES
          WHERE category_id = @category_id
IF (@price < 0)
print 'invalid price. price can not be negative'
ELSE IF (EXISTS(SELECT category_id from DISHES_CATEGORIES WHERE category_id=@category_id))
	BEGIN
	INSERT INTO DISHES(dish_id, dish_name, dish_image, dish_description, price, category_id)
	VALUES (@dish_id, @dish_name, @dish_image, @dish_description, @price, @category_id)
	END
ELSE
print 'not exit in category_id, have to add your category to table DISHES_CATEGORY first'
END 

/*test procedure*/
INSERT INTO DISHES_CATEGORIES(category_id, category_name, category_description, num_of_dishes)
VALUES ('DC0003', 'Dessert', 'Sweet like sugar', 0);



EXEC insert_dishes 
@dish_id = '7777777', 
@dish_name =  'Orange', 
@dish_image = 'orange.png', 
@dish_description = 'Best fruit ever', 
@price= 30000, 
@category_id= '0000003'

go



/*trigger to update num of dishes when dish was inserted*/
CREATE TRIGGER update_qty ON DISHES AFTER INSERT AS
BEGIN
	update DISHES_CATEGORIES
	set num_of_dishes = num_of_dishes + 1
	from DISHES_CATEGORIES, inserted
	where DISHES_CATEGORIES.category_id = inserted.category_id
END
go


/*trigger update num of dishes when dish was deleteted*/
CREATE TRIGGER update_qty_delete ON DISHES AFTER DELETE AS
BEGIN
	update DISHES_CATEGORIES
	set num_of_dishes = num_of_dishes - 1
	from DISHES_CATEGORIES, deleted
	where DISHES_CATEGORIES.category_id = deleted.category_id
END
go


/*procedure to query dish in category have less than 5 dishes*/
DROP PROCEDURE query_type
go
CREATE PROCEDURE query_type
AS
BEGIN
SELECT D.dish_id, D.dish_name, D.dish_image, D.dish_description, D.price, D.category_id 
FROM DISHES as D,DISHES_CATEGORIES as C
WHERE D.category_id = C.category_id and C.num_of_dishes < 3
ORDER BY D.category_id
END
go

/*procedure to count how many dish in category type have price more than 20*/
DROP PROCEDURE query_category_price
go
CREATE PROCEDURE query_category_price
AS
BEGIN
SELECT T1.category_id, category_name, category_description, num_of_dishes, more_than_20  FROM (
SELECT DISHES.category_id,  count(price) as more_than_20 
FROM DISHES
WHERE price>20000
GROUP BY category_id)AS T1, DISHES_CATEGORIES as T2
WHERE T1.category_id= T2.category_id
END
go



/*test procedure*/

go
EXEC query_type
EXEC query_category_price
go


/*function to filter dish price between min price and max price*/
DROP FUNCTION query_price
go
CREATE FUNCTION query_price(@max_price float, @min_price float, @dish_id varchar(7))
returns VARCHAR(30)
as
BEGIN
	IF (@max_price < 0 OR @min_price <0 OR @dish_id = null)
	return 'Min price or max price can not be negative'
	else
	BEGIN
	declare @price INT
	 select @price=price from DISHES WHERE dish_id = @dish_id
	IF(@price >= @min_price AND @price<=@max_price)
		return 'hople'
	END
return 'khong hop le'
END
go

go

/*function to filter search string*/
go
CREATE FUNCTION query_search(@search_string VARCHAR(20), @dish_id varchar(7))
returns VARCHAR(20)
as
BEGIN
DECLARE @name varchar(20)
DECLARE @char varchar(20)
set @char = 'search'
SELECT @name=dish_name FROM DISHES WHERE dish_id=@dish_id
set @char = @search_string
IF CHARINDEX(LOWER(@char), LOWER(@name), 0)>0
	begin
	return 'hople'
	end
else
	return 'khong hop le'
return 'INVALID VARIABLE'
END


/*test function*/
SELECT * FROM DISHES WHERE dbo.query_price(40000,20000,dish_id)='hople'

SELECT * FROM DISHES WHERE dbo.query_search('ice', dish_id)='hople'



