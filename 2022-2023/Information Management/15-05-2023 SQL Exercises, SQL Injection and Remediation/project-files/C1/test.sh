#!/bin/bash

sudo -su postgres psql -U postgres -c "ALTER ROLE postgres WITH LOGIN PASSWORD 'postgres'"

export PGHOST=localhost
export PGPORT=5432
export PGUSER=postgres
export PGPASSWORD=postgres

psql -c "DROP DATABASE IF EXISTS im_cw2_case_1"
psql -c "CREATE DATABASE im_cw2_case_1"

psql -d im_cw2_case_1 < im_cw2_case_1.sql

export PGDATABASE=im_cw2_case_1

psql -c "INSERT INTO private.product (prod_id, name, price) VALUES
(nextval('private.product_prod_id_seq'),'Toothbrush', 2),
(nextval('private.product_prod_id_seq'),'Toothpaste', 3),
(nextval('private.product_prod_id_seq'),'Chicken 1 KG', 4),
(nextval('private.product_prod_id_seq'),'Apples', 1);
"
psql -c "INSERT INTO private.inventory (inv_id,product,amount) VALUES
(nextval('private.inventory_inv_id_seq'),1, 50),
(nextval('private.inventory_inv_id_seq'),2, 60),
(nextval('private.inventory_inv_id_seq'),3, 10),
(nextval('private.inventory_inv_id_seq'),4, 15);
"
psql -c "INSERT INTO private.customers (cust_id,name,address,date_of_birth) VALUES
(nextval('private.customers_cust_id_seq'),'Customer 1', 'Address 10', '21/07/2000'),
(nextval('private.customers_cust_id_seq'),'Customer 2', 'Address 20', '26/09/1965'),
(nextval('private.customers_cust_id_seq'),'Customer 3', 'Address 30', '18/02/1997'),
(nextval('private.customers_cust_id_seq'),'Customer 4', 'Address 40', '11/05/1989');
"

psql -c "INSERT INTO private.employees 
(emp_id,name,address,date_of_birth,sort_code,bank_account_number,salary) VALUES
(nextval('private.employees_emp_id_seq'),'Employee 1', 'Address 1', '12/12/1976', 123456, 65765865, 30000),
(nextval('private.employees_emp_id_seq'),'Employee 2', 'Address 2', '02/02/1997', 123456, 87745455, 40700),
(nextval('private.employees_emp_id_seq'),'Employee 3', 'Address 3', '10/10/1985', 123456, 35765987, 50670),
(nextval('private.employees_emp_id_seq'),'Employee 4', 'Address 4', '30/07/1986', 123456, 65765472, 64660),
(nextval('private.employees_emp_id_seq'),'Employee 10', 'Address 10', '12/12/1976', 123456, 65765665, 40000),
(nextval('private.employees_emp_id_seq'),'Employee 20', 'Address 20', '02/02/1997', 123456, 87745255, 50700),
(nextval('private.employees_emp_id_seq'),'Employee 30', 'Address 30', '10/10/1985', 123456, 35765287, 60670),
(nextval('private.employees_emp_id_seq'),'Employee 40', 'Address 40', '30/07/1986', 123456, 65765172, 74660);
"
psql -c "INSERT INTO private.EmployeeJobDetails (emp_id,area_id,store_id,department_id,job_role) VALUES
(1, 1, 1, 1, 'HR Manager'),
(2, 1, 1, 2, 'Store Manager'),
(3, 1, 1, 3, 'Employee'),
(4, 1, 1, 4, 'Finance Manager'),
(5, 2, 2, 1, 'HR Manager'),
(6, 2, 2, 2, 'Store Manager'),
(7, 2, 2, 3, 'Employee'),
(8, 2, 2, 4, 'Finance Manager');
"



# start of test script

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
STARTING TEST SCRIPT TO SHOW SECURITY
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

export PGUSER=s1_user_store_manager;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 1 EMPLOYEES HAVE A SINGLE DIGIT IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING STORE MANAGER ABILITY (STORE 1)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s2_user_store_manager;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 2 EMPLOYEES HAVE TWO DIGITS IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING STORE MANAGER ABILITY (STORE 2)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s1_user_hr_manager;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 1 EMPLOYEES HAVE A SINGLE DIGIT IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING HR MANAGER ABILITY (STORE 1)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s2_user_hr_manager;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 2 EMPLOYEES HAVE TWO DIGITS IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING HR MANAGER ABILITY (STORE 2)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s1_user_admin;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 1 EMPLOYEES HAVE A SINGLE DIGIT IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING ADMIN ABILITY (STORE 1)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s2_user_admin;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 2 EMPLOYEES HAVE TWO DIGITS IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING ADMIN ABILITY (STORE 2)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s1_user_finance_manager;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 1 EMPLOYEES HAVE A SINGLE DIGIT IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING FINANCE MANAGER ABILITY (STORE 1)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s2_user_finance_manager;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 2 EMPLOYEES HAVE TWO DIGITS IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING STORE FINANCE ABILITY (STORE 2)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s1_user_area_manager;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 1 EMPLOYEES HAVE A SINGLE DIGIT IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING AREA MANAGER ABILITY (STORE 1)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"

export PGUSER=s2_user_area_manager;
export PGPASSWORD=test;

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
!!! STORE 2 EMPLOYEES HAVE TWO DIGITS IN THEIR NAME !!!
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING AREA MANAGER ABILITY (STORE 2)
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING SELECT * ON WHOLE EMPLOYEES TABLE
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM private.employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR STORE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM store_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR HR MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM hr_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR ADMINS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM admin.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR FINANCE MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM finance_manager.check_employees;"

echo && echo "
@@@@@@@@@@@@@@@@@@@@@@@@@ 
TESTING CHECK EMPLOYEE VIEW ONLY FOR AREA MANAGERS
OUTPUT:
@@@@@@@@@@@@@@@@@@@@@@@@@"
echo 

psql -c "SELECT * FROM area_manager.check_employees;"