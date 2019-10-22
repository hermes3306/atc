import pyodbc
import random
import time

building_arr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
floor_arr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
sector_arr = [1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2];
sensor_arr = [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0];
report_arr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

t_arr = [20,21,17,18,19,20,21,15,10,22,19,18,17,17,20,21,23,25,22,20];
h_arr = [65,63,68,40,49,39,76,74,79,56,52,64,73,12,83,55,48,50,66,68];
l_arr = [1022,2018,2022,3022,2022,2022,1022,1232,1082,1883,1983,1123,1983,1277,1223,1832,1764,1932,1123,1422];
g_arr = [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,0];
w_arr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
p_arr = [0,1,1,2,1,1,0,0,0,1,1,0,1,0,0,1,0,1,0,0];

server_arr = ['localhost','localhost','localhost','localhost','localhost', \
		'localhost', 'localhost','localhost','localhost','localhost']

port_arr = ['20300','20300','20300','20300' ]

print('SENSOR   Site : Building : Floor : Sector : Sensor : ReportSec :  T :  H :   L  : G : W : P')
#for x in range(60) :

while (1) :
	my_site_id =  random.randint(1,9)  
	my_port_id = random.randint(0,3)
	myserver = server_arr[ my_site_id ]
	myport = port_arr[ my_port_id ]

	conn = pyodbc.connect('DSN=ALTI_UNIXODBC; SERVER='+ myserver +'; \
			 PORT_NO='+ myport +'; NLS_USE=UTF8; UID=smssuser; PWD=smssuser')

	cur = conn.cursor()
	t_id = random.randint(0,19)
	building_id = building_arr[t_id]
	floor_id = floor_arr[t_id]
	sector_id = sector_arr[t_id]
	sensor_id = sensor_arr[t_id]
	sensor_unit_id = report_arr[t_id]

	val_1 = t_arr[t_id] + random.randint(0,2)
	val_2 = h_arr[t_id] + random.randint(0,2)
	val_3 = l_arr[t_id] + random.randint(0,29)
	val_4 = g_arr[t_id] + random.randint(0,1)
	val_5 = w_arr[t_id] + random.randint(0,1)
	val_6 = p_arr[t_id] + random.randint(0,1)

        
	print(' {} =  :  {}  :     {}    :  {}    :  {}     :  {}     :     {}     : {} : {} : {} : {} : {} : {} '.format(server_arr[my_site_id], my_site_id, building_id, floor_id, sector_id,sensor_id, sensor_unit_id, val_1, val_2, val_3, val_4, val_5, val_6))


	sql = "insert into tbl_sm_data(TIME_STAMP, SITE_ID, BUILDING_ID, FLOOR_ID, SECTOR_ID, SENSOR_ID, SENSOR_UNIT_ID, VALUE_COL_1, VALUE_COL_2, VALUE_COL_3, VALUE_COL_4, VALUE_COL_5, VALUE_COL_6) values(sysdate,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

	cur.execute(sql, ( my_site_id, building_id, floor_id, sector_id, sensor_id, sensor_unit_id, val_1, val_2, val_3, val_4, val_5, val_6))

	conn.commit()
	time.sleep(1)

	cur.close()
	conn.close()
