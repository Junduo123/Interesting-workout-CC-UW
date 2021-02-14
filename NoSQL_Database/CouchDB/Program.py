# Assisgnment number: 05
# Name: Junduo Dong
# Date of submission: Nov.19.2019


import couchdb

def func12():
    URI=input("Enter URI:")
    ID=input("Enter id:")
    P=input("Enter password:")
    dbname=input("Enter database:")
    couch = couchdb.Server()
    couch = couchdb.Server(URI)

    if dbname in couch:
        db=couch[dbname]
    else:
        couch.resource.credentials=(ID,P)
        couch.create(dbname)
    return db

def func4_1():
    print("1.List all contacts")
    print("2.Enter a new contact")
    print("3.Find a contact")
    print("4.Delete a contact")
    print("5.Exit the program")
    c=int(input("Enter an option:"))
    return c

def func4_2():
    db=func12()
    r=func4_1()
    while True:
        if r==1:
            # list all contact
            # Before this step, please manually create a view called 'new-view' in your database
            # view document name called 'doc'
            # view name called 'new-view'
            # below is the map function in the view
            """
            function (doc) {
                  emit(doc._id, {First_name:doc.First_name,
                                Last_name:doc.Last_name,
                                Email_address:doc.Email_address,
                                phone_number:doc.phone_number,
                                notes:doc.notes
                                });
                            }
            """
            print('All contacts are:')
            for item in db.view('_design/doc/_view/new-view'):
                print(item.id, item.value['First_name'],item.value['Last_name'], item.value['Email_address'],
                     item.value['phone_number'],item.value['notes'])
            r=func4_1()
        elif r==2:
            pn=''
            nt=''
            fn=input("Enter First name:")
            ln=input("Enter Last name:")
            ea=input("Enter Email address:")
            pn_yn=input("Do you want to enter a phone number?y/n")
            if pn_yn=='y':
                pn=input("Enter phone number:")
            nt_yn=input("Do you want to enter a notes?y/n")
            if nt_yn=='y':
                nt=input("Enter Notes:")
            #insert contact into database
            i=0
            for item in db.view('_design/doc/_view/new-view'):
                i=i+1
            i=i+1
            s=str(i)
            db[s] = dict(First_name=fn, Last_name=ln, Email_address=ea, phone_number=pn, notes=nt)
            r=func4_1()
        elif r==3:
            ln=input("Enter the Last name to search:")
            #search by last name
            for item in db.view('_design/doc/_view/new-view'):
                if item.value['Last_name']==ln:
                    print(item.value['First_name'],item.value['Last_name'], item.value['Email_address'],
                        item.value['phone_number'],item.value['notes'])
            r=func4_1()
        elif r==4:
            d=input("Enter the ID to delete:")
            d_yn=input("Do you want to delete?y/n")
            if d_yn=='y':
                #delete
                doc=db[d]
                db.delete(doc)                  
                print('delete successfully!')
            r=func4_1()
        elif r==5:
            break
            
        continue
    return

func4_2()

