use db_assigment2;
------------------------------------------------
INSERT INTO CUSTOMERS
VALUES
    ('1111111', 'vitran', '1814804', 'vitran2000_vi@hcmut.edu.vn', '0322432411', 'Tran', 'Long', 'Vi', '1-1-2000', 'Male', '2021-11-18 18:07:03', 0);

------------------------------------------------
INSERT INTO RESTAURANT_BRANCH
VALUES
    ('Ly Thuong Kiet', '130 Ly Thuong Kiet, TP. Ho Chi Minh, Vietnam', 0.43);

------------------------------------------------
INSERT INTO PROMOTIONS
VALUES
    ('01112021', 'Black Friday', 'Friday 13th, November 2021', '2021-11-01 00:00:00', '2021-11-29 00:00:00');

------------------------------------------------
INSERT INTO VOUCHERS
VALUES
    ('1234567', '01112021', 'Available', '2021-11-29 00:00:00', 500000);
INSERT INTO VOUCHERS
VALUES
    ('7654321', '01112021', 'Expired', '2021-11-29 00:00:00', 200000);
INSERT INTO VOUCHERS
VALUES
    ('2233445', '01112021', 'Used', '2021-11-29 00:00:00', 100000);

------------------------------------------------
INSERT INTO SHIPPERS
VALUES
    ('0000001', 'Vo Thi An', '0883181332');

------------------------------------------------
INSERT INTO DISHES_CATEGORIES
VALUES
    ('0000001', 'Appetizer', 'The first dish served in the meal', 1);
INSERT INTO DISHES_CATEGORIES
VALUES
    ('0000002', 'Bbq', 'Grilled meat', 2);
INSERT INTO DISHES_CATEGORIES
VALUES
    ('0000003', 'Dessert', 'The Last dish served in the meal', 2);

------------------------------------------------
INSERT INTO DISHES
VALUES
    ('1111111', 'Mixed vegetable', 'm_veget.png', 'Vegetables mixed with sweet and sour sauce', 19000, '0000001');
INSERT INTO DISHES
VALUES
    ('2222222', 'Beef stack', 'beef_s.png', 'Kobe beef is grilled on the stone', 49000, '0000002');
INSERT INTO DISHES
VALUES
    ('3333333', 'Grilled chicken', 'g_chicken.png', 'Chicken is baked in a pressure cooker', 60000, '0000002');
INSERT INTO DISHES
VALUES
    ('4444444', 'Ice cream', 'i_cream.png', 'Delicious cold chocolate ice cream ', 25000, '0000003');
INSERT INTO DISHES
VALUES
    ('5555555', 'Pudding', 'pudding.png', 'A cake like jelly', 21000, '0000003');

------------------------------------------------
INSERT INTO ORDER_DISHES
VALUES
    ('1231231', null, null, '1111111', 'vitran', 'Unpaid', 157000, 'App', 'Ly Thuong Kiet', '0000001');
INSERT INTO ORDER_DISHES
VALUES
    ('4564564', '2233445', '01112021', '1111111', 'vitran', 'Delivered', 330000, 'Live', 'Ly Thuong Kiet', null);
------------------------------------------------
INSERT INTO DISHES_LIST
VALUES
    ('1231231', '1111111', 2);
INSERT INTO DISHES_LIST
VALUES
    ('1231231', '2222222', 2);
INSERT INTO DISHES_LIST
VALUES
    ('1231231', '5555555', 1);

INSERT INTO DISHES_LIST
VALUES
    ('4564564', '1111111', 4);
INSERT INTO DISHES_LIST
VALUES
    ('4564564', '2222222', 2);
INSERT INTO DISHES_LIST
VALUES
    ('4564564', '3333333', 1);
INSERT INTO DISHES_LIST
VALUES
    ('4564564', '4444444', 3);
INSERT INTO DISHES_LIST
VALUES
    ('4564564', '5555555', 1);

------------------------------------------------
INSERT INTO ORDER_BILLS
VALUES
    ('2021-11-20 19:00:34', 'Cash', 230000, '4564564');
------------------------------------------------
INSERT INTO CUSTOMERS 
VALUES ('1111111', 'vitran', '1814804', 'vitran2000_vi@hcmut.edu.vn',
'0322432411', 'Tran', 'Long', 'Vi', '1-1-2000', 'Male', 
'2021-11-18 18:07:03', 0);

INSERT INTO CUSTOMERS(account_id, username, password, email, phone_number, 
        Fname,Minit,Lname, Bdate, gender, registration_date, bonus_point)
VALUES ('KH006','Tri006','123456','vanTri@gmail.com',
'0136356709','Tri','Van','Nguyen','1995-09-10','Male','',0) 

INSERT INTO CUSTOMERS(account_id, username, password, email, phone_number, 
        Fname,Minit,Lname, Bdate, gender, registration_date, bonus_point)
VALUES ('KH007','Tam007','123456','leTam@gmail.com',
'0236356709','Tam','Le','Nguyen','1994-10-08','Male','',10) 
	        ------------------------------------------------
INSERT INTO SUPPLIERS VALUES ('CTy A','abc','cta@gmail.com');
INSERT INTO SUPPLIERS VALUES ('CTy B','cbc','ctb@gmail.com');
INSERT INTO SUPPLIERS VALUES ('CTy C','aba','ctc@gmail.com'); 
	        ------------------------------------------------
INSERT INTO CONSIGNMENTS(consignment_id, supplier, consigned_day, 
                        chef_id, chef_username, branch_name)
VALUES ('CS0001','CTy A',GETDATE(),'E001','employee1','CN01');
INSERT INTO CONSIGNMENTS(consignment_id, supplier, consigned_day, 
                        chef_id, chef_username, branch_name)
VALUES ('CS0002','CTy A',GETDATE(),'E001','employee1','CN01');
INSERT INTO CONSIGNMENTS(consignment_id, supplier, consigned_day, 
                        chef_id, chef_username, branch_name)
VALUES ('CS0003','CTy B',GETDATE(),'E001','employee1','CN01');

------------------------------------------------
INSERT INTO MANAGERS(username, age, college_certification, toeic_certification, Fname, Minit, Lname)
VALUES('manager1', 40, 'bachelor', 750, 'Zinedine', 'Zizou', 'Zidane');
                                         
INSERT INTO MANAGERS(username, age, college_certification, toeic_certification, Fname, Minit, Lname)
VALUES('manager2', 44, 'bachelor', 990, 'Carlo', 'Carletto', 'Ancelotti');

------------------------------------------------
INSERT INTO EMPLOYEES(username, password, email, mgr_id, phone_number, Fname, Minit, Lname, Bdate, gender, registration_date, working_date_per_month)
VALUES('employ1', '123456', 'employ1@example.com', 1, '0123456789', 'Antonio', 'Blanco', 'Chust', '1999-11-17', 'Male', '2021-07-17', 20);

INSERT INTO EMPLOYEES(username, password, email, mgr_id, phone_number, Fname, Minit, Lname, Bdate, gender, registration_date, working_date_per_month)
VALUES('employ2', '123456', 'employ2@example.com', 1, '0123456789', 'Francisco', 'Román', 'Alarcón', '1999-11-17', 'Male', '2021-07-17', 20);
                                
INSERT INTO EMPLOYEES(username, password, email, mgr_id, phone_number, Fname, Minit, Lname, Bdate, gender, registration_date, working_date_per_month)
VALUES('employ3', '123456', 'employ3@example.com', 2, '0123456789', 'Cristiano', 'Ronaldo', 'dos Santos', '1985-02-05', 'Male', '2021-07-17', 24); 
