import pyodbc
import random
import time

conn = pyodbc.connect('DSN=ALTI_UNIXODBC; SERVER=127.0.0.1; PORT_NO=20300; NLS_USE=UTF8; UID=smssuser; PWD=smssuser')

cur = conn.cursor()

for x in range(60) :
        sql = "insert into test2(k01,k02) values(?, ?)"
        cur.execute(sql, ( x, x))
        conn.commit()
#        time.sleep(1)
cur.close()
conn.close()

