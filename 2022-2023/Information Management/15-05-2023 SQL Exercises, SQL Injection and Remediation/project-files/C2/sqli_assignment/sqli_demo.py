from flask import Flask, render_template, request, redirect
from flask_bootstrap import Bootstrap
from flask_mail import Mail, Message
from sqliauthenticate import authenticate
from sqlselectemployee import selectproduct, listemployees, selectpassword
from sqlselectorder import listorders
from sqliinit import sqliinit

app = Flask(__name__)
bootstrap = Bootstrap(app)
app.config['MAIL_SERVER'] = 'smtp.office365.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USERNAME'] = 'im243wmg@hotmail.com'
app.config['MAIL_PASSWORD'] = 'Coventry2023'
app.config['MAIL_USE_SSL'] = False
app.config['MAIL_USE_TLS'] = True

mail = Mail(app)


@app.route('/')
def defaulthandler() -> '302':
    return render_template('index.html',
                           this_title='Main Page')


@app.route('/login', methods=['GET'])
def login() -> 'html':
    return render_template('login_form.html',
                           this_title='Enter login details')


@app.route('/login', methods=['POST'])
def logincheck() -> 'html':
    user = request.form['user']
    passwd = request.form['pass']

    authenticatedUser = authenticate(user, passwd)
    # print('Authenticated User: ', authenticatedUser['email'])

    if authenticatedUser == None:
        return render_template('login_form.html', this_title='Login failed')
    else:
        employees = listemployees()
        return render_template('employee_form.html', this_title=''.join(['Welcome ', authenticatedUser['email']]),
                               employees=employees)


# @app.route('/orders/<customer>', methods=['GET'])
# def showorders(customer) -> 'html':
#     orders = listorders(customer)
#     print('Orders: ', orders, ' for customer: ', customer)
#     return render_template('orders.html', this_title=''.join(['Orders for ', customer]), orders=orders)


@app.route('/products', methods=['GET'])
def doproducts() -> 'html':
    args = request.args
    if "order_by" in args:
        order_by = args["order_by"]
    else:
        order_by = 'prod_id'

    if "sort" in args:
        sort_by = args["sort"]
    else:
        sort_by = 'asc'

    products = selectproduct_orderby(order_by, sort_by)
    # products = listproducts()
    return render_template('employee_form.html', this_title='Products', customer='Guest User', products=products)


@app.route('/send_pwd', methods=['POST'])
def send_pwd() -> 'html':
    print("check the email exist")
    searchstring = request.form['user']
    password = selectpassword(searchstring)
    if len(password)<1:
        print('User doesn\'t exist')
    else:
        msg = Message('Hello!', sender='im243wmg@hotmail.com', recipients=[searchstring])
        msg.body = "Hey {email}, Your password is {password}".format(email = searchstring, password= password[0][0])
        mail.send(msg)
        print('sent')
    return render_template('index.html')
@app.route('/search', methods=['GET'])
def dolookup() -> 'html':
    description = '''
            Use the searchstr form variable to search for products.    
            '''
    return render_template('search_form.html', this_title='Enter search parameters', description=description)


@app.route('/forgot', methods=['GET'])
def doforgot() -> 'html':
    description = '''
            Use the searchstr form variable to search for products.    
            '''
    return render_template('forgot.html', this_title='Enter email', description=description)


@app.route('/search/<cmd>', methods=['GET'])
def dosqli(cmd) -> 'html':
    # Different options selected from the main menu....

    if cmd == 'dbuser':
        description = '''
            Use the searchstr form variable to determine the database role for the application.
            (Try to avoid peeking at the back end database!)
            '''

    if cmd == 'tablejoin':
        description = '''
            Use the searchstr form variable to join data from appusers table for the application. 
            (Try to avoid peeking at the back end database!)
            '''
    if cmd == 'blind':
        description = '''
            Use the searchstr form variable to infer data from the appusers table using blind SQL injection.
            (Try to avoid peeking at the back end database!)
            '''

    if cmd == 'oob':
        description = '''
            Use the searchstr form variable to inject data that will result in the credentials of an application user being converted to ascii
            and set to an external DNS service via an nslookup query (see notes)
            '''

    return render_template('search_form.html', this_title='Enter search parameters', description=description)


@app.route('/search', methods=['POST'])
def dosearch() -> 'html':
    searchstring = request.form['searchstring']
    products = selectproduct(searchstring)
    return render_template('employee_form.html', this_title='Employee', customer='Guest User', employees=products)


@app.route('/init')
def init() -> 'html':
    sqliinit()
    return render_template('index.html', this_title='Main Page')


app.run(debug=True)
