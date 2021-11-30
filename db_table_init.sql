create database db_assigment2;
use db_assignment2;

-- used to change table attribute
-- use master;
-- drop DATABASE db_assigment2;
----------------------------------------------------------------

create table CUSTOMERS
(
    account_id char(7) not null,
    username VARCHAR(50) not null,
    password varchar(50) not null,
    email VARCHAR(50) null,
    phone_number char(11) not null,
    Fname VARCHAR(50) not null,
    Minit VARCHAR(50) null,
    Lname VARCHAR(50) not null,
    Bdate DATE null,
    gender CHAR(8) not null check(gender='Male' or gender='Female' or gender='LGBT'),
    registration_date smalldatetime,
    bonus_point INT not null check(bonus_point >= 0),
    constraint login_customer PRIMARY KEY(account_id, username),
    unique (phone_number)
);

----------------------------------------------------------------

create table EMPLOYEES
(
    account_id char(7) not null,
    username VARCHAR(50) not null,
    password varchar(50) not null,
    email VARCHAR(50) null,
    phone_number char(11) not null,
    Fname VARCHAR(50) not null,
    Minit VARCHAR(50) null,
    Lname VARCHAR(50) not null,
    Bdate DATE not null,
    gender CHAR(8) not null check(gender='Male' or gender='Female' or gender='LGBT'),
    registration_date smalldatetime,
    working_date_per_month INT not null check(working_date_per_month >= 0 and working_date_per_month < 401),
    constraint login_employee PRIMARY KEY(account_id, username)
);

----------------------------------------------------------------

create table CASHIERS
(
    account_id char(7) not null,
    username VARCHAR(50) not null,
    accounting_certification varchar(255) not null,
    primary key (account_id, username),
    foreign key(account_id, username) REFERENCES EMPLOYEES(account_id, username) on update CASCADE
);

----------------------------------------------------------------

create table SERVICE_EMPLOYEES
(
    account_id char(7) not null,
    username VARCHAR(50) not null,
    high_school_certification varchar(255) not null,
    primary key (account_id, username),
    foreign key(account_id, username) REFERENCES EMPLOYEES(account_id, username) on update CASCADE
);

----------------------------------------------------------------

create table CHEFS
(
    account_id char(7) not null,
    username VARCHAR(50) not null,
    chef_certification varchar(255) not null,
    primary key (account_id, username),
    foreign key(account_id, username) REFERENCES EMPLOYEES(account_id, username) on update CASCADE
);

----------------------------------------------------------------

create table MANAGERS
(
    account_id char(7) not null,
    username VARCHAR(50) not null,
    college_certification varchar(255) not null,
    toeic_certification varchar(255) not null,
    primary key (account_id, username),
    foreign key(account_id, username) REFERENCES EMPLOYEES(account_id, username) on update CASCADE
);

----------------------------------------------------------------

create table RESTAURANT_BRANCH
(
    branch_name varchar(50) not null,
    branch_addr varchar(100) not null,
    percent_warehouse_available decimal(5, 4) not null
        check(percent_warehouse_available >= 0 and percent_warehouse_available <= 1),
    primary key(branch_name)
);

----------------------------------------------------------------

create table MANAGE
(
    manager_id char(7) not null,
    manager_username VARCHAR(50) not null,
    branch_name varchar(50) not null,
    first_working_day smalldatetime not null,
    primary key (manager_id),
    foreign key(manager_id, manager_username) REFERENCES MANAGERS(account_id, username) on update CASCADE,
    foreign key (branch_name) REFERENCES RESTAURANT_BRANCH(branch_name) on update CASCADE
);

----------------------------------------------------------------

create table PROMOTIONS
(
    promotion_id char(8) not null,
    promotion_name varchar(50) not null,
    promo_description varchar(250) not null,
    begin_day smalldatetime not null,
    end_day smalldatetime not null,
    PRIMARY key(promotion_id)
);

----------------------------------------------------------------

create table VOUCHERS
(
    voucher_id char(7) not null,
    promotion_id char(8) not null,
    voucher_status varchar(10) not null check(voucher_status = 'Available' OR voucher_status = 'Expired' or voucher_status = 'Used'),
    expired_day smalldatetime not null,
    voucher_value int not null CHECK(voucher_value > 0),
    primary key(voucher_id, promotion_id),
    foreign key(promotion_id) REFERENCES PROMOTIONS(promotion_id)
);

----------------------------------------------------------------

create table SHIPPERS
(
    shipper_id char(7) not null,
    shipper_name varchar(50) not null,
    phonenumber char(11) not null,
    primary key(shipper_id)
);

----------------------------------------------------------------

create table DISHES_CATEGORIES
(
    category_id char(7) not null,
    category_name varchar(50) not null,
    category_description varchar(255) not null,
    num_of_dishes int not null check(num_of_dishes >= 0),
    primary key(category_id),
    unique(category_name)
);

----------------------------------------------------------------

create table DISHES
(
    dish_id char(7) not null,
    dish_name varchar(50) not null,
    dish_image varchar(255) not null,
    dish_description varchar(255) not null,
    price int not null check(price >= 0),
    category_id char(7) not null,
    primary key(dish_id),
    unique(dish_name),
    foreign key(category_id) REFERENCES DISHES_CATEGORIES(category_id) on update CASCADE
);

----------------------------------------------------------------

create table ORDER_DISHES
(
    order_id char(7) not null,
    voucher_added char(7) null,
    promotion_id char(8) null,
    customer_id char(7) not null,
    customer_username varchar(50) not null,
    order_status char(10) not null
        check(order_status='Unpaid' or order_status='Paid' or order_status='Delivered' or order_status='Cancelled'),
    total_price int not null check(total_price >= 0),
    order_method char(10) not null
        check(order_method='Live' or order_method='App' or order_method='Website'),
    branch_name varchar(50) not null,
    shipper_id char(7) null,
    primary key(order_id),
    foreign key(voucher_added, promotion_id) REFERENCES VOUCHERS(voucher_id, promotion_id),
    foreign key(shipper_id) REFERENCES SHIPPERS(shipper_id) on update CASCADE,
    foreign key(customer_id, customer_username) REFERENCES CUSTOMERS(account_id, username),
    foreign key(branch_name) REFERENCES RESTAURANT_BRANCH(branch_name)
);

----------------------------------------------------------------

create table DISHES_LIST
(
    id int IDENTITY(1,1) not null,
    order_id char(7) not null,
    dish_id char(7) not null,
    dish_quantity int not null check(dish_quantity >= 0),
    primary key(order_id, dish_id),
    foreign key(order_id) REFERENCES ORDER_DISHES(order_id),
    foreign key(dish_id) REFERENCES DISHES(dish_id)
);

----------------------------------------------------------------

create table ORDER_BILLS
(
    bill_id int IDENTITY(1,1) not null,
    payment_time smalldatetime not null,
    payment_method char(10) not null
        check(payment_method='Cash' or payment_method='Bank card' or payment_method='E-wallet'),
    total_price int not null check(total_price >= 0),
    order_id char(7) not null,
    primary key(bill_id, order_id),
    foreign key(order_id) REFERENCES ORDER_DISHES(order_id)
);

----------------------------------------------------------------

create table SUPPLIERS
(
    supplier_name varchar(50) not null,
    supplier_addr varchar(100) not null,
    supplier_email varchar(50) not null,
    primary key(supplier_name)
);

----------------------------------------------------------------

create table CONSIGNMENTS
(
    consignment_id char(7) not null,
    supplier varchar(50) not null,
    consigned_day smalldatetime not null,
    chef_id char(7) not null,
    chef_username varchar(50) not null,
    primary key(consignment_id),
    foreign key(chef_id, chef_username) REFERENCES CHEFS(account_id, username) on UPDATE CASCADE,
    foreign key(supplier) REFERENCES SUPPLIERS(supplier_name) on UPDATE CASCADE
);

----------------------------------------------------------------

create table DISHES_MATERIALS
(
    material_name varchar(50) not null,
    consignment_id char(7) not null,
    expired_day date not null,
    quantity decimal(38,2) not null default 0 check(quantity >= 0),
    primary key(material_name, consignment_id),
    foreign key(consignment_id) REFERENCES CONSIGNMENTS(consignment_id) on update CASCADE
);
