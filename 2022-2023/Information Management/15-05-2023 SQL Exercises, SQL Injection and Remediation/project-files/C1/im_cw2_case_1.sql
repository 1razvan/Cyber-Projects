DROP ROLE IF EXISTS role_store_manager;
DROP ROLE IF EXISTS role_hr_manager;
DROP ROLE IF EXISTS role_admin;
DROP ROLE IF EXISTS role_finance_manager;
DROP ROLE IF EXISTS role_area_manager;

DROP ROLE IF EXISTS s1_user_store_manager;
DROP ROLE IF EXISTS s1_user_hr_manager;
DROP ROLE IF EXISTS s1_user_admin;
DROP ROLE IF EXISTS s1_user_finance_manager;
DROP ROLE IF EXISTS s1_user_area_manager;
DROP ROLE IF EXISTS s2_user_store_manager;
DROP ROLE IF EXISTS s2_user_hr_manager;
DROP ROLE IF EXISTS s2_user_admin;
DROP ROLE IF EXISTS s2_user_finance_manager;
DROP ROLE IF EXISTS s2_user_area_manager;

CREATE SCHEMA private;
CREATE SCHEMA store_manager;
CREATE SCHEMA hr_manager;
CREATE SCHEMA admin;
CREATE SCHEMA finance_manager;
CREATE SCHEMA area_manager;

CREATE TABLE private.product (
	prod_id SERIAL PRIMARY KEY,
	name varchar(255) NOT NULL,
	price int NOT NULL
);

CREATE TABLE private.inventory (
	inv_id SERIAL PRIMARY KEY,
	product int NOT NULL REFERENCES private.product(prod_id),
	amount int NOT NULL
);

CREATE TABLE private.customers (
	cust_id SERIAL PRIMARY KEY,
	name varchar(255) NOT NULL,
	address varchar(255) NOT NULL,
	date_of_birth date NOT NULL
);

CREATE TABLE private.employees (
	emp_id SERIAL PRIMARY KEY,
	name varchar(255) NOT NULL,
	address varchar(255) NOT NULL,
	date_of_birth date NOT NULL,
	sort_code char(6) NOT NULL,
	bank_account_number char(8) NOT NULL,
	salary int NOT NULL
);

CREATE TABLE private.EmployeeJobDetails (
	emp_id int NOT NULL REFERENCES private.employees(emp_id),
	area_id int NOT NULL,
	store_id int NOT NULL,
	department_id int NOT NULL,
	job_role varchar(255) NOT NULL
);

-- VIEWS
CREATE OR REPLACE VIEW store_manager.check_employees 
AS SELECT name, address FROM private.employees e
JOIN private.EmployeeJobDetails d
ON d.emp_id=e.emp_id
WHERE d.store_id = (SELECT SUBSTRING(user,2,1) :: INT);

CREATE OR REPLACE VIEW hr_manager.check_employees 
AS SELECT name, address, date_of_birth, salary FROM private.employees e
JOIN private.EmployeeJobDetails d
ON d.emp_id=e.emp_id
WHERE d.store_id = (SELECT SUBSTRING(user,2,1) :: INT);

CREATE OR REPLACE VIEW admin.check_employees 
AS SELECT name FROM private.employees e
JOIN private.EmployeeJobDetails d
ON d.emp_id=e.emp_id
WHERE d.store_id = (SELECT SUBSTRING(user,2,1) :: INT);

CREATE OR REPLACE VIEW finance_manager.check_employees 
AS SELECT name, address, date_of_birth, sort_code, bank_account_number, salary 
FROM private.employees e
JOIN private.EmployeeJobDetails d
ON d.emp_id=e.emp_id
WHERE d.store_id = (SELECT SUBSTRING(user,2,1) :: INT);

CREATE OR REPLACE VIEW area_manager.check_employees 
AS SELECT name, address FROM private.employees e
JOIN private.EmployeeJobDetails d
ON d.emp_id=e.emp_id
WHERE d.store_id = (SELECT SUBSTRING(user,2,1) :: INT);

--creation of roles and users

-- store manager (store 1)
CREATE ROLE role_store_manager;
CREATE ROLE s1_user_store_manager WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA store_manager TO role_store_manager;
GRANT SELECT ON store_manager.check_employees TO role_store_manager;
GRANT role_store_manager TO s1_user_store_manager;

-- hr manager (store 1)
CREATE ROLE role_hr_manager;
CREATE ROLE s1_user_hr_manager WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA hr_manager TO role_hr_manager;
GRANT SELECT ON hr_manager.check_employees TO role_hr_manager;
GRANT role_hr_manager TO s1_user_hr_manager;

-- admin (store 1)
CREATE ROLE role_admin;
CREATE ROLE s1_user_admin WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA admin TO role_admin;
GRANT SELECT ON admin.check_employees TO role_admin;
GRANT role_admin TO s1_user_admin;

-- finance manager (store 1)
CREATE ROLE role_finance_manager;
CREATE ROLE s1_user_finance_manager WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA finance_manager TO role_finance_manager;
GRANT SELECT ON finance_manager.check_employees TO role_finance_manager;
GRANT role_finance_manager TO s1_user_finance_manager;

-- area manager (store 1)
CREATE ROLE role_area_manager;
CREATE ROLE s1_user_area_manager WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA area_manager TO role_area_manager;
GRANT SELECT ON area_manager.check_employees TO role_area_manager;
GRANT role_area_manager TO s1_user_area_manager;




-- store manager (store 2)
CREATE ROLE s2_user_store_manager WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA store_manager TO role_store_manager;
GRANT SELECT ON store_manager.check_employees TO role_store_manager;
GRANT role_store_manager TO s2_user_store_manager;

-- hr manager (store 2)
CREATE ROLE s2_user_hr_manager WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA hr_manager TO role_hr_manager;
GRANT SELECT ON hr_manager.check_employees TO role_hr_manager;
GRANT role_hr_manager TO s2_user_hr_manager;

-- admin (store 2)
CREATE ROLE s2_user_admin WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA admin TO role_admin;
GRANT SELECT ON admin.check_employees TO role_admin;
GRANT role_admin TO s2_user_admin;

-- finance manager (store 2)
CREATE ROLE s2_user_finance_manager WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA finance_manager TO role_finance_manager;
GRANT SELECT ON finance_manager.check_employees TO role_finance_manager;
GRANT role_finance_manager TO s2_user_finance_manager;

-- area manager (store 2)
CREATE ROLE s2_user_area_manager WITH LOGIN PASSWORD 'test';
GRANT USAGE ON SCHEMA area_manager TO role_area_manager;
GRANT SELECT ON area_manager.check_employees TO role_area_manager;
GRANT role_area_manager TO s2_user_area_manager;