import pyodbc

conn = pyodbc.connect('DSN=ALTI_UNIXODBC; SERVER=127.0.0.1; PORT_NO=20300; NLS_USE=UTF8; UID=smssuser; PWD=smssuser')

dbcursor1 = conn.cursor()

dbcursor1.execute('select count(*) from tbl_sm_data')
data = dbcursor1.fetchall()

for x in data:
   print(x[0])

dbcursor1.close()
conn.close()

