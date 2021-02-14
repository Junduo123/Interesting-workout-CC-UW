# Assisgnment number: 05
# Name: Junduo Dong
# Date of submission: Nov.19.2019


import couchdb

couch = couchdb.Server()
couch = couchdb.Server('http://127.0.0.1:5984/')
couch.resource.credentials = ('junduo','Lovelife0915')
db = couch.create('db_tests')
db = couch['db_tests']

db['1'] = dict(First_name='Jack',
                 Last_name='Shi',
                 Email_address='Jackshi@gmail.com',
                 phone_number='3365428795',
                 notes='Jack shi is a student in Conestoga college')

db['2'] = dict(First_name='Rong',
                 Last_name='Wang',
                 Email_address='rongwang@gmail.com',
                 phone_number='2265290864',
                 notes='Rong Wang is a student in Conestoga college')

db['3'] = dict(First_name='Oliver',
                 Last_name='Dong',
                 Email_address='oliverdong987@gmail.com',
                 phone_number='2265179045',
                 notes='Oliver Dong is a student in Conestoga college')






