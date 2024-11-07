import requests


try:
	response = requests.get('http://localhost:8080/index.php', timeout=10)
	print(response.status_code)
	if 'Connection failed:'in response.text:
		exit(1)
#make a request and check if the reponse is ok and check that the webserver can connect to the database
	if response.status_code!=200:
		exit(1)
	response = requests.post('http://localhost:8080/action.php', data={'fullname':'test_name', 'suggestion':'test_suggestion'}, timeout=10)
	print(response.status_code)
#check that a post request can be made successully
	if response.status_code!=200:
		exit(1)
	exit(0)
except Exception as err:
	print('bad')
#exit insuccesfully if the connection errors or times out
	exit(1)

