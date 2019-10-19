import pyodbc
import random
import time
import pandas

from pandas import DataFrame

myserver 	= 'localhost'
myport		= '20300'

conn = pyodbc.connect('DSN=ALTI_UNIXODBC; SERVER='+ myserver +'; \
                         PORT_NO='+ myport +'; NLS_USE=UTF8; UID=smssuser; PWD=smssuser')

cur = conn.cursor()
sql = "select * from tbl_sm_data"
cur.execute(sql)
for data in cur.fetchall():
	print(data)



