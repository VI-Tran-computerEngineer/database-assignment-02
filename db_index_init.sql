use db_assigment2;

----------------------------------------------------------------
-- Get customer name
create index idx_customer_name
on CUSTOMERS(Fname, Minit, Lname);

-- Get dish name
create index idx_dish_name
on DISHES(dish_name);

-- Get dish price
create index idx_dish_price
on DISHES(price);

-- Get voucher value
create index idx_voucher_value
on VOUCHERS(voucher_value);
