from sqlpostgres import Sqlpostgres
    
def selectproduct(search_str):
    with Sqlpostgres() as pg:
        sqlstr = "select * from Employee where name like '%{search_str}%'".format(search_str = search_str)
        print('SQLStr: ', sqlstr)
        resultstr = pg.querysearch(sql=sqlstr)
        print(resultstr)
        return resultstr
def selectpassword(search_str):
    with Sqlpostgres() as pg:
        sqlstr = "select password from login where email = '{search_str}'".format(search_str = search_str)
        print('SQLStr: ', sqlstr)
        resultstr = pg.querysearch(sql=sqlstr)
        print(resultstr)
        return resultstr
# def selectproduct_orderby(order_by, sort_by):
#     with Sqlpostgres() as pg:
#         sqlstr = "select * from products order by {field} {sort};".format(field = order_by, sort=sort_by)
#         print('SQLStr: ', sqlstr)
#         resultstr = pg.querysearch(sql=sqlstr)
#         return resultstr

def listemployees():
        with Sqlpostgres() as pg:
            sqlstr = "select * from Employee";
            return pg.query(sql=sqlstr)
