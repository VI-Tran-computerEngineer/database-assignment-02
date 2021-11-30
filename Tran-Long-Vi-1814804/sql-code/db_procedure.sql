use db_assigment2;
---------------------------------------------------------------------------
CREATE or alter PROCEDURE Insert_Tuple_2_ORDER_DISHES
    @order_id char(7),
    @voucher_added char(7),
    @customer_username varchar(50),
    @order_status char(10),
    @order_method char(10),
    @branch_name varchar(50),
    @shipper_id char(7)
as
begin
    DECLARE @flag AS int
    set @flag = 0
    IF @order_id=null 
    BEGIN
        RAISERROR ('Order ID must not equal "NULL"!', 16, 1)
        set @flag = -1
    END
    if @customer_username=null
    BEGIN
        RAISERROR ('Customer Username must not equal "NULL"!', 16, 1)
        set @flag = -1
    END
    if @order_status=null
    BEGIN
        RAISERROR ('Order status must not equal "NULL"!', 16, 1)
        set @flag = -1
    END
    if (@order_status != 'Unpaid' and @order_status != 'Paid' and @order_status!='Delivered' and @order_status!='Cancelled')
    BEGIN
        RAISERROR ('Invalid Order status value!', 16, 1)
        set @flag = -2
    END
    if @order_method=null
    BEGIN
        RAISERROR ('Last name must not equal "NULL"!', 16, 1)
        set @flag = -1
    END
    if (@order_method!='Live' and @order_method!='App' and @order_method!='Website')
    BEGIN
        RAISERROR ('Invalid Order method value!', 16, 1)
        set @flag =  -2
    END
    if @branch_name=null
    BEGIN
        RAISERROR ('Gender must not equal "NULL"!', 16, 1)
        set @flag =  -1
    END

    IF @flag=0
    BEGIN
        declare @promotion_id char(8);
        SET @promotion_id = (select promotion_id
        from VOUCHERS
        where voucher_id = @voucher_added);
        declare @customer_id char(7);
        set @customer_id = (select account_id
        from CUSTOMERS
        where username = @customer_username);
        INSERT INTO ORDER_DISHES
        VALUES
            (@order_id, @voucher_added, @promotion_id, @customer_id, @customer_username, @order_status, 0, @order_method, @branch_name, @shipper_id)
    END
end;


---------------------------------------------------------------------------
-- Stored procedure used to insert tuple into DISHES_LIST table
CREATE or alter PROCEDURE Insert_Tuple_2_DISHES_LIST
    @order_id char(7),
    @dish_id char(7),
    @dish_quantity int
as
begin
    DECLARE @flag AS int
    set @flag = 0
    IF @order_id=null 
    BEGIN
        RAISERROR ('Order ID must not equal "NULL"!', 16, 1)
        set @flag = -1
    END
    if @dish_id=null
    BEGIN
        RAISERROR ('Dish ID must not equal "NULL"!', 16, 1)
        set @flag =  -1
    END
    if @dish_quantity=null
    BEGIN
        RAISERROR ('Dish quantity must not equal "NULL"!', 16, 1)
        set @flag =  -1
    END
    if @dish_quantity < 0
    BEGIN
        RAISERROR ('Dish quantity must not equal "NULL"!', 16, 1)
        set @flag =  -1
    END

    IF @flag=0
    BEGIN
        if not exists(select *
        from DISHES_LIST
        where order_id = @order_id and dish_id = @dish_id)
        begin
            INSERT INTO DISHES_LIST
            VALUES
                (@order_id, @dish_id, @dish_quantity)
        end
        else
        BEGIN
            UPDATE DISHES_LIST 
            SET dish_quantity = @dish_quantity 
            where order_id = @order_id and dish_id = @dish_id;
        end
    END
end;
---------------------------------------------------------------------------



---------------------------------------------------------------------------
-- Stored procedure used to calculate total price for an order dishes
CREATE or alter PROCEDURE Calculate_total_price
    @order_id char(7)
as
begin
    DECLARE @flag AS int
    set @flag = 0
    IF @order_id=null 
    BEGIN
        RAISERROR ('Order ID must not equal "NULL"!', 16, 1)
        set @flag = -1
    END

    IF @flag=0
    BEGIN
        select sum(price*dish_quantity)
        from DISHES d, DISHES_LIST l
        where l.order_id = @order_id and d.dish_id = l.dish_id;
    END
end;
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- Stored procedure used to calculate total price for an order dishes
CREATE or alter PROCEDURE Display_dish_list_of_order
    @order_id char(7)
as
begin
    DECLARE @flag AS int
    set @flag = 0
    IF @order_id=null 
    BEGIN
        RAISERROR ('Order ID must not equal "NULL"!', 16, 1)
        set @flag = -1
    END

    IF @flag=0
    BEGIN
        select dish_name, price, dish_quantity, (price*dish_quantity) as 'Total price'
        from DISHES d, DISHES_LIST l
        where d.dish_id = l.dish_id and l.order_id = @order_id
        order by dish_quantity ASC
    END
end;
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- Stored procedure used to calculate total price for an order dishes
CREATE or alter PROCEDURE Display_order_dishes_list
    @text varchar(255)
as
begin
    if @text = ''
    begin
        select dl.order_id, customer_username as 'username', sum(price*dish_quantity) as 'o_price', total_price as 'p_price', dbo.cal_decreased_price(od.order_id) as 'd_price', order_method, order_status, branch_name
        from DISHES_LIST dl, DISHES d, ORDER_DISHES od
        where dl.dish_id = d.dish_id and dl.order_id = od.order_id
        group by dl.order_id, customer_username, total_price, od.order_id, order_method, order_status, branch_name
        order by sum(price*dish_quantity) asc;
    end
    else BEGIN
        select dl.order_id, customer_username as 'username', sum(price*dish_quantity) as 'o_price', total_price as 'p_price', dbo.cal_decreased_price(od.order_id) as 'd_price', order_method, order_status, branch_name
        from DISHES_LIST dl, DISHES d, ORDER_DISHES od
        where dl.dish_id = d.dish_id and dl.order_id = od.order_id
        group by dl.order_id, customer_username, total_price, od.order_id, order_method, order_status, branch_name
        having (dl.order_id like '%'+@text+'%')
            or (customer_username like '%'+@text+'%')
            or (order_method like '%'+@text+'%')
            or (order_status like '%'+@text+'%')
            or (branch_name like '%'+@text+'%')
        order by sum(price*dish_quantity) asc;
    end
end;

---------------------------------------------------------------------------

CREATE or alter PROCEDURE delete_a_order_dish
    @order_id char(7)
as
BEGIN
    if @order_id is not null
    begin
        declare @dish_id char(7);
        declare dish_cursor CURSOR
        for
        select dish_id
        from DISHES_LIST
        where order_id = @order_id;

        open dish_cursor;
        fetch next from dish_cursor into @dish_id;

        while @@FETCH_STATUS = 0
        begin
            if (@dish_id != 0)
                delete from DISHES_LIST where order_id = @order_id and dish_id = @dish_id;
            fetch next from dish_cursor into @dish_id;
        end;
        CLOSE dish_cursor;
        DEALLOCATE dish_cursor;

        if EXISTS (select *
        from ORDER_DISHES
        where order_id = @order_id)
        delete from ORDER_DISHES where order_id = @order_id;
    end;
end;
