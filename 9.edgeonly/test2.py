import pyodbc


server_arr = ['192.168.35.31','192.168.35.31','192.168.35.31','192.168.35.31','192.168.35.31', \
                '192.168.35.31', '192.168.35.31','192.168.35.31','192.168.35.31','192.168.35.31']

conn = pyodbc.connect('DSN=ALTI_UNIXODBC; SERVER=192.168.35.31; PORT_NO=20300; NLS_USE=UTF8; UID=smssuser; PWD=smssuser')

cursor = conn.cursor()

sql = "select SITE_ID, BUILDING_ID, FLOOR_ID, SECTOR_ID, SENSOR_ID, SENSOR_UNIT_ID, VALUE_COL_1, VALUE_COL_2, VALUE_COL_3, VALUE_COL_4, VALUE_COL_5, VALUE_COL_6 from tbl_sm_data"

print('SENSOR   Site : Building : Floor : Sector : Sensor : ReportSec :  T :  H :   L  : G : W : P')

cursor.execute(sql)
cnt = 0
 
x = cursor.fetchone() 
while x: 
	my_site_id 	= x[0]	
	building_id 	= x[1]	
	floor_id 	= x[2]	
	sector_id 	= x[3]	
	sensor_id 	= x[4]	
	sensor_unit_id 	= x[5]	
	val_1 		= x[6]	
	val_2 		= x[7]	
	val_3 		= x[8]	
	val_4 		= x[9]	
	val_5 		= x[10]	
	val_6 		= x[11]	
	print(' {} =  :  {}  :     {}    :  {}    :  {}     :  {}     :     {}     : {} : {} : {} : {} : {} : {} '.format(server_arr[my_site_id], my_site_id, building_id, floor_id, sector_id,sensor_id, sensor_unit_id, val_1, val_2, val_3, val_4, val_5, val_6))
	x = cursor.fetchone()
	cnt = cnt + 1

cursor.close()
conn.close()

print('TOTAL = {} ' . format(cnt) )

