#!/usr/bin/python

import MySQLdb

# Open database connection
db = MySQLdb.connect("localhost","root","redhat")

# prepare a cursor object using cursor() method
cursor = db.cursor()

# Prepare SQL query to INSERT a record into the table.
sql = """INSERT INTO test_minnu.users(FIRST_NAME,
         LAST_NAME, AGE, Gender, INCOME)
         VALUES ('Mac', 'Mohan', 20, 'M', 2000)"""
try:
   # Execute the SQL command
   cursor.execute(sql)
   # Commit your changes in the database
   db.commit()
   # execute SQL query using execute() method.
   cursor.execute("select * from test_minnu.users")
   # Fetch a single row using fetchone() method.
   data = cursor.fetchone()
   print("Query the Table : %s " % data)
except:
   # Rollback in case there is any error
   db.rollback()

# disconnect from server
db.close()


