create or alter FUNCTION cal_payment_price(@order_id char(7))
returns int
AS
BEGIN
    if @order_id is NULL
        return -1;
    declare @total_price INT;
    set @total_price = (
        select sum(price*dish_quantity)
    from DISHES d, DISHES_LIST l
    where l.order_id = @order_id and d.dish_id = l.dish_id
    );
    if @total_price is NULL
        return 0;
    declare @decreased_value int;
    set @decreased_value = (select dbo.cal_decreased_price(@order_id));
    if @decreased_value <= 0
        return @total_price;

    declare @payment_value int;
    set @payment_value = @total_price - @decreased_value;
    if @payment_value < 0
        return 0;
    return @payment_value;
END



create or alter function cal_decreased_price(@order_id char(7))
returns INT
AS
BEGIN
    if @order_id is NULL
        return -1;
    DECLARE @voucher_id char(7);
    set @voucher_id = (select voucher_added
    from ORDER_DISHES
    where order_id = @order_id);
    DECLARE @promotion_id char(8);
    set @promotion_id = (select promotion_id
    from order_dishes
    where order_id = @order_id);
    if (@voucher_id is NULL) or (@promotion_id is null)
        return 0;

    DECLARE @decreased_value int;
    set @decreased_value = (select voucher_value
    from VOUCHERS
    where voucher_id = @voucher_id and promotion_id = @promotion_id);
    if (@decreased_value is null) or (@decreased_value < 0)
        return -2;
    return @decreased_value
end