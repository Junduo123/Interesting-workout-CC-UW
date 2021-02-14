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
