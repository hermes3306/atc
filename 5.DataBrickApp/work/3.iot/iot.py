import pyodbc
import random
import time


site_arr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
building_arr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
floor_arr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
sector_arr = [1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2];
sensor_arr = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
report_arr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

t_arr = [20,21,17,18,19,20,21,15,10,22,19,18,17,17,20,21,23,25,22,20];
h_arr = [65,63,68,40,49,39,76,74,79,56,52,64,73,12,83,55,48,50,66,68];
l_arr = [1022,2018,2022,3022,2022,2022,1022,1232,1082,1883,1983,1123,1983,1277,1223,1832,1764,1932,1123,1422];
g_arr = [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,0];
w_arr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
p_arr = [0,1,1,2,1,1,0,0,0,1,1,0,1,0,0,1,0,1,0,0];


conn = pyodbc.connect('DSN=ALTI_UNIXODBC; SERVER=127.0.0.1; PORT_NO=20300; NLS_USE=UTF8; UID=smssuser; PWD=smssuser')

cur = conn.cursor()

print('SENSOR   Site : Building : Floor : Sector : Sensor : ReportSec :  T : H : L : G : W : P')
#for x in range(60) :
while (1) :

        
        t_id = random.randint(0,19)
        site_id = site_arr[t_id]
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

        
        print('SENSOR =  {}  :    {}      :   {}  :    {}    :     {}  :    {}   : {} : {} : {} : {} : {}: {} '.format(site_id, building_id, floor_id, sector_id,sensor_id, sensor_unit_id, val_1, val_2, val_3, val_4, val_5, val_6))


        sql = "insert into tbl_sm_data(TIME_STAMP, SITE_ID, BUILDING_ID, FLOOR_ID, SECTOR_ID, SENSOR_ID, SENSOR_UNIT_ID, VALUE_COL_1, VALUE_COL_2, VALUE_COL_3, VALUE_COL_4, VALUE_COL_5, VALUE_COL_6) values(sysdate,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

        cur.execute(sql, ( site_id, building_id, floor_id, sector_id, sensor_id, sensor_unit_id, val_1, val_2, val_3, val_4, val_5, val_6))

        conn.commit()
        time.sleep(1)

cur.close()
conn.close()

