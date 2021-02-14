## Introduction
CouchDB is a popular document-type database. Since it uses the http protocol and JSON for communications,
libraries are easy to create for various programming environments. In this assignment, you will use Python to demonstrate access to a CouchDB database. You will be implementing a simple contact list.

## Requirements
- `1.`: As the Python program starts, the user is asked for <br />
        - `a.` The CouchDB URL <br />
        - `b.` The CouchDB administrator id <br />
        - `c.` The CouchDB administrator password <br />
        - `d.` The Database to use for the Contact system <br />

- `2.`: The information in the previous requirement is used to connect to the server and check if the database exists. If the database does not exist, then it should be created.

- `3.`: The data that must be stored for each contact is as follows: <br />
        - `a.` First name (required) <br />
        - `b.` Last name (required) <br />
        - `c.` Email address (required) <br />
        - `d.` Phone number (required) <br />
        - `e.` Notes (optional) <br />

- `4.`: The main part of the system is menu driven with the following options: <br />
        - `1.` List all contacts <br />
        - `2.` Enter a new contact <br />
        - `3.` Find a contact <br />
        - `4.` Delete a contact <br />
        - `5.` Exit the program <br />

- `5.`: Implement the code for each of the options, using the database you connected to (or created) in step 2 of the requirements. <br />
        - `a.` For "Find a contact", search by last name. You may get more than one result.
        - `b.` For "Delete a contact", use the document id. Please ask for confirmation before you delete.
        
- `6.`: After an option is executed in the menu, the menu should be shown again to choose another option. However, option 5. Should exit the program,

## Notes:
- `1.`: Use the Python library listed in PyPi: [Library URL](https://pypi.org/project/CouchDB/)
- `2.`: Basic API for the CouchDB library: [Basic API](https://couchdb-python.readthedocs.io/en/latest/client.html)
