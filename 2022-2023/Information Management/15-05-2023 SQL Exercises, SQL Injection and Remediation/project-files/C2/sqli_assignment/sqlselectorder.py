from sqlpostgres import Sqlpostgres

def listorders(customer):
        with Sqlpostgres() as pg:
            sqlstr = """select o.order_date, o.order_id, p.prod_id, p.prod_name, p.prod_desc, l.qty, l.purchase_price 
            from orders o 
            inner join order_lines l on l.order_id = o.order_id 
            inner join products p on l.product_id = p.prod_id where o.customer_ref = '{customer}' order by o.order_date """.format(customer = customer);
            print('SQL str: ', sqlstr)
            return pg.query(sql=sqlstr)
