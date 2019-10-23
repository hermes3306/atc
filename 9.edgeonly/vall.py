import pyodbc

port_arr=['20300','20300']
server_arr=["ezhub.club","localhost"]

Tot = 0
ST = []

for p in range(len(port_arr)):
    print('\n\n### SENSORS OF ' + server_arr[p] + " : " +  port_arr[p] + ' ###')
    dsn  = 'DSN=ALTI_UNIXODBC; SERVER="'+ server_arr[p] +'; PORT_NO='+ port_arr[p] +'; NLS_USE=UTF8; UID=smssuser; PWD=smssuser'
    print(dsn)
    conn = pyodbc.connect(dsn)
    cursor = conn.cursor()

    sql = "select SITE_ID, BUILDING_ID, FLOOR_ID, SECTOR_ID, SENSOR_ID, SENSOR_UNIT_ID, VALUE_COL_1, VALUE_COL_2, VALUE_COL_3, VALUE_COL_4, VALUE_COL_5, VALUE_COL_6 from tbl_sm_data"

    cursor.execute(sql)
    x = cursor.fetchone()

    cnt = 0;
    print('SENSOR   Site : Building : Floor : Sector : Sensor : ReportSec :  T :  H :   L  : G : W : P')
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

        print(' {} =  :  {}  :     {}    :  {}    :  {}     :  {}     :     {}     : {} : {} : {} : {} : {} : {} '.format(port_arr[p], my_site_id, building_id, floor_id, sector_id,sensor_id, sensor_unit_id, val_1, val_2, val_3, val_4, val_5, val_6))
        x = cursor.fetchone()
        cnt += 1
        Tot += 1
    cursor.close()
    conn.close()
    print('TOTAL of ['+ server_arr[p] + ':' + port_arr[p] + '] = {} ' . format( cnt ))
    ST.append( cnt )


print('\n\n')
for s in range(len(server_arr)):
    print('TOTAL of ['+ server_arr[s] + ':' + port_arr[s] + '] = {} ' . format( ST[s] ))

print('\n\n')
print('GRAND TOTAL = {} ' . format(Tot))

