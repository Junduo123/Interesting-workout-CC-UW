#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pymongo
from pymongo import MongoClient

# make connection
def connection():
    userid = input("enter your user id: ")
    password = input("enter your password here: ")
    myclient = MongoClient("mongodb://"+userid+":"+password+"@"+"cluster0-shard-00-00-90kj9.mongodb.net:27017,cluster0-shard-00-01-90kj9.mongodb.net:27017,cluster0-shard-00-02-90kj9.mongodb.net:27017/test?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin&retryWrites=true&w=majority")
    mydb = myclient['BDSA-06']
    return mydb

def fun6_1():
    print("1. List all movie titles with only the names of the cast")
    print("2. Ask for a cast, display all movies that he/she is in")
    print("3. Ask for a keyword, and search the 'overview' field to return the title and overview")
    c = int(input("Enter an option:"))
    return c

def fun6_2():
    mydb = connection()
    r = fun6_1()
    while True:
        if r == 1:
            # list all movie titles with only cast names
            mycol = mydb["fullmovies"]
            for x in mycol.find({},{"_id":1,"cast._id":1}):
                print(x)
            r = fun6_1()
        elif r == 2:
            # Ask for a cast, diaplay all movies that he/she is in
            mycol = mydb["fullmovies"]
            cast = input("enter the cast name: ")
            print(mycol.find_one({"cast._id":cast}))
            r = fun6_1()
        elif r == 3:
            # Ask for a keyword, and search the 'overview' field to return the title and overview
            mycol = mydb["fullmovies"]
            keyword = input("enter the keyword: ")
            
            matched_movies = mycol.find({'$text':{'$search':keyword}},{'overview':1})
            for movie in matched_movies:
                print(movie)
            r = fun6_1()
        else:
            break
    return
fun6_2()


# In[ ]:




