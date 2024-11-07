from sqlpostgres import Sqlpostgres

def authenticate(user, passwd):
    
    if len(user) == 0:
        print('Authentication error')
        return None

    with Sqlpostgres() as pg:
        sqlstr = """
            select * from login where email = '{user}' and password = '{password}'
            """.format(user=user, password=passwd)
        
        result = pg.querysingle(sql=sqlstr)
        print('authentication result: ', result)
        return result

    

        
