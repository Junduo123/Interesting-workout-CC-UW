
import couchdb

couch = couchdb.Server()
couch = couchdb.Server('http://127.0.0.1:5984/')
couch.resource.credentials = ('your_admin_id','your_admin_pass')
db = couch.create('db_tests')
db = couch['db_tests']

db['1'] = dict(First_name='***',
                 Last_name='***',
                 Email_address='******@gmail.com',
                 phone_number='3365428795',
                 notes='**********************************')

db['2'] = dict(First_name='***',
                 Last_name='***',
                 Email_address='*******@gmail.com',
                 phone_number='2265290864',
                 notes='**********************************')

db['3'] = dict(First_name='****',
                 Last_name='*****',
                 Email_address='***********@gmail.com',
                 phone_number='2265179045',
                 notes='**********************************')






