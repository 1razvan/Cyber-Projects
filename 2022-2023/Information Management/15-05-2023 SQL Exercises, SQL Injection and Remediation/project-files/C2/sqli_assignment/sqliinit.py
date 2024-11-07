from sqlpostgres import Sqlpostgres

def sqliinit():
    with Sqlpostgres() as pg:
        pg.execute('''drop table if exists Employee''')
        pg.execute('''drop table if exists EmployeeJobDetails''')
        pg.execute('''drop table if exists Login''')
        pg.execute('''drop table if exists orders''')
        pg.execute('''drop table if exists order_lines''')
        pg.execute('''drop table if exists appusers''')
        pg.execute('''drop table if exists products''')
        pg.execute('''drop table if exists order_lines''')
        pg.execute('''drop table if exists customers''')

        pg.execute('''create table if not exists Employee (
                emp_id serial primary key,
                name varchar(50),
                address varchar(50),
                date_of_birth date,
                sort_code bigint,
                bank_account_number bigint,
                salary  bigint
                )''')
                   
        pg.execute('''create table if not exists EmployeeJobDetails (
                emp_id serial,
                area_id integer,
                store_id integer,
                department_id integer,
                Job_role varchar(50)
                )''')
        
        pg.execute('''create table if not exists Login (
                emp_id serial,
                email varchar(50),
                password varchar(25)
                )''')

        # pg.execute('''create table if not exists order_lines (
        #         order_line_id serial primary key,
        #         order_id varchar(10),
        #         product_id varchar(10),
        #         qty int,
        #         purchase_price decimal
        #         )''')
        #
        # pg.execute('''create table if not exists products (
        #         prod_id varchar(10) primary key,
        #         prod_name varchar(25),
        #         prod_desc text,
        #         prod_type varchar(15),
        #         prod_cost decimal
        #         )''')

        pg.execute('delete from Employee')
        pg.execute('delete from EmployeeJobDetails')
        pg.execute('delete from Login')
        # pg.execute('delete from order_lines')
        # pg.execute('delete from products')
        pg.execute('''
        WITH ins1 AS (
            INSERT INTO Employee (name, address, date_of_birth, sort_code,bank_account_number, salary) values ('Alice Smith','22 Baker Street','06/01/1954',123456,123456789,650000)
            RETURNING emp_id
        ), ins2 AS (
        INSERT INTO Login (emp_id,email,password) SELECT emp_id,'alice@warwick.ac.uk','alicebaker' FROM ins1 RETURNING emp_id)
        INSERT INTO EmployeeJobDetails (emp_id,area_id,store_id, department_id, Job_role) SELECT emp_id, 1,2,3,'Store_manager' FROM ins2;
        ''')
        pg.execute('''
        WITH ins1 AS (
            INSERT INTO Employee (name, address, date_of_birth, sort_code,bank_account_number, salary) values ('Robert Holmes','2 morvenside Street','01/01/1994',789976,567891234,450000)
            RETURNING emp_id
        ), ins2 AS (
        INSERT INTO Login (emp_id,email,password) SELECT emp_id,'bobholmes@warwick.ac.uk','holmesdrive' FROM ins1 RETURNING emp_id)
        INSERT INTO EmployeeJobDetails (emp_id,area_id,store_id, department_id, Job_role) SELECT emp_id, 1,2,3,'HR_manager' FROM ins2;
        ''')
        pg.execute('''
       WITH ins1 AS (
           INSERT INTO Employee (name, address, date_of_birth, sort_code,bank_account_number, salary) values ('Martin Taylor','34 down Street','05/10/1988',546789,678976584,250000)
           RETURNING emp_id
       ), ins2 AS (
       INSERT INTO Login (emp_id,email,password) SELECT emp_id,'martintaylor@warwick.ac.uk','taylor' FROM ins1 RETURNING emp_id)
       INSERT INTO EmployeeJobDetails (emp_id,area_id,store_id, department_id, Job_role) SELECT emp_id, 1,2,3,'admin' FROM ins2;
       ''')
        # pg.execute('''
        #         WITH ins1 AS (
        #             INSERT INTO Employee (name, address, date_of_birth, sort_code,bank_account_number, salary) values ('Anita Khadka','220 Baker Street','06/01/1854',123456,123456789,650000)
        #             RETURNING emp_id
        #         ), ins2 AS (
        #         INSERT INTO Login (emp_id,email,password) SELECT emp_id,'anita.khadka@warwick.ac.uk','Coventry' FROM ins1 RETURNING emp_id)
        #         INSERT INTO EmployeeJobDetails (emp_id,area_id,store_id, department_id, Job_role) SELECT emp_id, 1,2,3,'Store_manager' FROM ins2;
        #         ''')

        # pg.execute('''
        #         insert into appusers (name, pass, customer_ref) values ('Ann', 'annpw', 'C-105');
        #         insert into appusers (name, pass, customer_ref) values ('Bob', 'bobpw', 'C-106');
        #         insert into appusers (name, pass, customer_ref) values ('Col', 'colpw', 'C-107');
        #         insert into appusers (name, pass, customer_ref) values ('Dee', 'deepw', 'C-108');
        #         ''')
        #
        # pg.execute('''
        #         insert into customers values ('C-105', 'Atherstone Analytics');
        #         insert into customers values ('C-106', 'Backup And Restore Services');
        #         insert into customers values ('C-107', 'Code Consultants');
        #         insert into customers values ('C-108', 'Diagnostic Research Co.');
        #         ''')
        #
        # pg.execute('''
        #         insert into orders values ('002045', '2019-08-12', 'C-106');
        #         insert into orders values ('002046', '2019-08-20', 'C-105');
        #         insert into orders values ('002047', '2019-09-10', 'C-106');
        #         insert into orders values ('002048', '2019-09-16', 'C-107');
        #         insert into orders values ('002049', '2019-09-18', 'C-107');
        #         insert into orders values ('002050', '2019-10-02', 'C-107');
        #         insert into orders values ('002051', '2019-10-03', 'C-108');
        #         insert into orders values ('002052', '2019-10-12', 'C-105');
        #         insert into orders values ('002053', '2019-10-29', 'C-108');
        #         insert into orders values ('002054', '2019-11-07', 'C-107');
        #         insert into orders values ('002055', '2019-11-13', 'C-108');
        #         insert into orders values ('002056', '2019-11-19', 'C-108');
        #         insert into orders values ('002057', '2019-11-25', 'C-106');
        #         insert into orders values ('002058', '2019-11-30', 'C-106');
        #         insert into orders values ('002059', '2019-12-02', 'C-106');
        #         insert into orders values ('002060', '2019-12-09', 'C-108');
        #         insert into orders values ('002061', '2019-12-14', 'C-107');
        #         insert into orders values ('002062', '2019-12-14', 'C-106');
        #         insert into orders values ('002063', '2020-01-04', 'C-105');
        #         insert into orders values ('002064', '2020-01-04', 'C-106');
        #         insert into orders values ('002065', '2020-01-04', 'C-107');
        #         ''')
        #
        # pg.execute('''
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002045', 'SW-003',3, 4000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002046', 'CN-001',1, 8000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002047', 'SW-002',10, 1600.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002048', 'SW-001',1, 100.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002049', 'SW-003',1, 1500.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002050', 'SW-002',2, 450.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002051', 'CN-002',1, 13000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002052', 'CN-001',1, 8000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002053', 'FW-001',1, 650.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002054', 'CN-002',1, 13000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002055', 'RT-001',1, 3000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002056', 'FW-003',1, 8000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002057', 'FW-003',1, 10000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002058', 'RT-001',1, 2500.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002059', 'SV-003',4, 28000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002060', 'CN-003',1, 25000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002061', 'CN-002',1, 13000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002062', 'SV-001',10, 5000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002063', 'SW-003',1, 1500.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002064', 'CN-003',1, 25000.00);
        #         insert into order_lines (order_id, product_id, qty, purchase_price) values ('002065', 'CN-002',1, 13000.00);
        #         ''')
        #
        #
        # pg.execute('''
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('SW-001', 'Switch-8', '8 port 10Gb Switch', 'Switch', 100.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('SW-002', 'Switch-24', '24 port 10Gb Switch', 'Switch', 250.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('SW-003', 'Switch-48', '48 port 10Gb Switch', 'Switch', 1600.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('SW-010', 'CoreSwitch-24', 'Core Switch', 'Switch', 7000.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('SW-011', 'CoreSwitch-48', 'Core Switch', 'Switch', 1800.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('SV-001', 'Server Lite', 'Entry level server', 'Server', 800.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('SV-002', 'Server Pro', 'Mid-range server', 'Server', 3000.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('SV-003', 'Server Extreme', 'Data centre edition', 'Server', 10000.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('RT-001', 'Router Core', 'Core router', 'Router', 3000.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('FW-001', 'Firewall-100x', 'Branch office firewall', 'Firewall', 650.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('FW-002', 'Firewall-400x', 'Standard firewall', 'Firewall', 3000.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('FW-003', 'Firewall-XX', 'Perimeter firewall', 'Firewall', 12000.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('CN-001', 'Consultancy Package 1', '5 days consultancy', 'Consultancy', 8000.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('CN-002', 'Consultancy Package 2', '10 days consultancy', 'Consultancy', 14000.00);
        #         insert into products (prod_id, prod_name, prod_desc,prod_type, prod_cost) values ('CN-003', 'Consultancy Package 3', '20 days consultancy', 'Consultancy', 25000.00);
        #
        #         ''')
