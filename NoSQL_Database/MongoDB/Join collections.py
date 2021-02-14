#!/usr/bin/env python
# coding: utf-8

# In[4]:


import pymongo
from pymongo import MongoClient

userid = ("your_userid")
password = ("your_password")
myclient = MongoClient("mongodb://"+userid+":"+password+"@"+"cluster0-shard-00-00-90kj9.mongodb.net:27017,cluster0-shard-00-01-90kj9.mongodb.net:27017,cluster0-shard-00-02-90kj9.mongodb.net:27017/test?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin&retryWrites=true&w=majority")
mydb = myclient['your_db_name']

# assign values to each collections 
movies_collection = mydb.movies
people_collection = mydb.people
fullmovies_collection = mydb['fullmovies']

fullmovies_data = []
# for an empty document 'movie'
# insert cast info into movies collection
for movie in movies_collection.find():
    # create an empty list called 'cast' in movie collection
    movie['cast'] = []
    # find each people in each movie (movie['_id'])
    people = people_collection.find({'movies':movie['_id']})
    # for each actor in people, append them into document 'cast'
    for actor in people:
        movie['cast'].append(actor)
    
    fullmovies_data.append(movie)
    
fullmovies_collection.insert(fullmovies_data)    


# In[ ]:




