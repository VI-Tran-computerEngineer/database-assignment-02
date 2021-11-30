create or alter TRIGGER Insert_Update_DISH_LIST_trigger
on DISHES_LIST
after INSERT, UPDATE
AS
BEGIN
    DECLARE @order_id INT;
    SET @order_id = (select top 1
        order_id
    from inserted);
    if @order_id is null
    BEGIN
        RAISERROR ('Order ID must not equal "NULL"!', 16, 1);
        ROLLBACK;
    end;
    declare @payment_price int;
    set @payment_price = (select dbo.cal_payment_price(@order_id));
    if @payment_price < 0 or @payment_price = null
    BEGIN
        RAISERROR ('Oups, something happened!', 16, 1);
        ROLLBACK;
    end;
    update ORDER_DISHES
    set total_price = @payment_price
    where order_id = @order_id;
end
go

create or alter TRIGGER Delete_DISH_LIST_trigger
on DISHES_LIST
after DELETE
AS
BEGIN
    DECLARE @order_id INT;
    SET @order_id = (select top 1
        order_id
    from deleted);
    if @order_id is null
    BEGIN
        RAISERROR ('Order ID must not equal "NULL"!', 16, 1);
        ROLLBACK;
    end;
    declare @payment_price int;
    set @payment_price = (select dbo.cal_payment_price(@order_id));
    if @payment_price < 0 or @payment_price is null
    BEGIN
        RAISERROR ('Oups, something happened!', 16, 1);
        ROLLBACK;
    end;
    update ORDER_DISHES
    set total_price = @payment_price
    where order_id = @order_id;
end
go


create or alter TRIGGER Update_ORDER_DISHES_trigger
on ORDER_DISHES
after INSERT, UPDATE
AS
BEGIN
    DECLARE @order_id INT;
    SET @order_id = (select order_id
    from inserted);
    if @order_id is null
    BEGIN
        RAISERROR ('Order ID must not equal "NULL"!', 16, 1);
        ROLLBACK;
    end;
    DECLARE @voucher_id char(7);
    set @voucher_id = (select voucher_added
    from ORDER_DISHES
    where order_id = @order_id);
    DECLARE @order_status CHAR(10);
    set @order_status = (select order_status
    from ORDER_DISHES
    where order_id = @order_id);
    if (@order_status='Paid' or @order_status='Delivered')
    begin
        if @voucher_id is not null
        begin
            DECLARE @voucher_status varchar(10);
            set @voucher_status = (select voucher_status
            from VOUCHERS
            where voucher_id = @voucher_id);
            if (@voucher_status != 'Expired')
                update VOUCHERS
                set voucher_status = 'Used'
                where voucher_id = @voucher_id;
        end
        if not exists (select *
        from ORDER_BILLS
        where order_id = @order_id)
        begin
            declare @datetime smalldatetime;
            set @datetime = (select CAST(GETDATE() AS smalldatetime));
            declare @price int;
            set @price = (select total_price
            from ORDER_DISHES
            where order_id = @order_id);
            insert into ORDER_BILLS
            values
                (@datetime, 'Cash', @price, @order_id);
        end
    end;
end
go