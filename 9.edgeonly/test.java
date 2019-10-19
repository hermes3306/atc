import java.util.Properties;
import java.util.Random;
import java.sql.*;

class test
{
	static int cnt =0;	
	static int[] building_arr 	= {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
	static int[] floor_arr 	= {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
	static int[] sector_arr 	= {1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2};
	static int[] sensor_arr 	= {1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0};
	static int[] report_arr 	= {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};

	static int[] t_arr 		= {20,21,17,18,19,20,21,15,10,22,19,18,17,17,20,21,23,25,22,20};
	static int[] h_arr 		= {65,63,68,40,49,39,76,74,79,56,52,64,73,12,83,55,48,50,66,68};
	static int[] l_arr 		= {1022,2018,2022,3022,2022,2022,1022,1232,1082,1883,1983,1123,1983,1277,1223,1832,1764,1932,1123,1422};
	static int[] g_arr 		= {0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,0};
	static int[] w_arr 		= {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	static int[] p_arr 		= {0,1,1,2,1,1,0,0,0,1,1,0,1,0,0,1,0,1,0,0};

	public static int randomInt(int min, int max) {
		Random rand = new Random(System.currentTimeMillis());
		int randomNum = rand.nextInt((max-min)+1) - min;
		return randomNum;
	}

	public static void sel(Connection con) throws Exception {
		int mycnt = 0;
		String sql = "select SITE_ID, BUILDING_ID, FLOOR_ID, SECTOR_ID, SENSOR_ID, SENSOR_UNIT_ID, VALUE_COL_1, VALUE_COL_2, VALUE_COL_3, VALUE_COL_4, VALUE_COL_5, VALUE_COL_6 from tbl_sm_data";

		Statement stmt  = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()) {
			if(mycnt % 10 == 0)  {
				System.out.println("SENSOR:    Site :Bldg.:Floor: Sector: Sensor : Uni.:   T :  H  :  L  :  G   :   W :   P");
			}	
			mycnt++;

			int site_id  = rs.getInt(1);
			int building_id = rs.getInt(2);
			int floor_id    = rs.getInt(3);
			int sector_id   = rs.getInt(4);
			int sensor_id   = rs.getInt(5);
			int sensor_unit_id  = rs.getInt(6);
			int val_1       = rs.getInt(7); 
			int val_2       = rs.getInt(8);
			int val_3       = rs.getInt(9);
			int val_4       = rs.getInt(10);
			int val_5       = rs.getInt(11);
			int val_6       = rs.getInt(12);

			String server="SENSOR";
			System.out.printf("%s = %6d : %3d : %3d : %5d : %6d : %3d : %3d : %3d : %3d : %3d : %3d : %3d\n", server, site_id, building_id, floor_id, sector_id, sensor_id, sensor_unit_id, val_1, val_2, val_3, val_4, val_5, val_6);
		}
		System.out.printf("Total [] = %d \n", mycnt);
			
	}

	public static void ins(Connection con) {
		if(cnt % 10 == 0)  {
			System.out.println("SENSOR:    Site :Bldg.:Floor: Sector: Sensor : Uni.:   T :  H  :  L  :  G   :   W :   P");
		}	
		cnt++;

		int t_id = randomInt(0,18);
		int building_id = building_arr[t_id];
		int floor_id = floor_arr[t_id];
		int sector_id = sector_arr[t_id];
		int sensor_id = sensor_arr[t_id];
		int sensor_unit_id = report_arr[t_id];

		int val_1 = t_arr[t_id] + randomInt(0,1); 
		int val_2 = h_arr[t_id] + randomInt(0,1);  
		int val_3 = l_arr[t_id] + randomInt(0,28);
		int val_4 = g_arr[t_id] + randomInt(0,1); 
		int val_5 = w_arr[t_id] + randomInt(0,1); 
		int val_6 = p_arr[t_id] + randomInt(0,1); 

		String server = "SENSOR";
		System.out.printf("%s = %6d : %3d : %3d : %5d : %6d : %3d : %3d : %3d : %3d : %3d : %3d : %3d\n", server, t_id, building_id, floor_id, sector_id, sensor_id, sensor_unit_id, val_1, val_2, val_3, val_4, val_5, val_6);

		String sql = "insert into tbl_sm_data(TIME_STAMP, SITE_ID, BUILDING_ID, FLOOR_ID, SECTOR_ID, SENSOR_ID, SENSOR_UNIT_ID, VALUE_COL_1, VALUE_COL_2, VALUE_COL_3, VALUE_COL_4, VALUE_COL_5, VALUE_COL_6) values(sysdate,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, t_id);
            pstmt.setInt(2,	building_id);
            pstmt.setInt(3,	floor_id);
            pstmt.setInt(4, sector_id);
            pstmt.setInt(5, sensor_id);
            pstmt.setInt(6, sensor_unit_id);
            pstmt.setInt(7,	val_1);
            pstmt.setInt(8,	val_2);
            pstmt.setInt(9,	val_3);
            pstmt.setInt(10,val_4);
            pstmt.setInt(11,val_5);
            pstmt.setInt(12,val_6);
            pstmt.execute();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	public static void mysleep(int ms) {
		try {
	    	Thread.sleep( ms ) ;
		} catch ( InterruptedException e ) {}
	}

	public static void main(String args[]) {

		Properties props = new Properties();
       	Connection con = null;
       	Statement stmt = null;
       	PreparedStatement pstmt = null;
       	ResultSet res;

		String url = "jdbc:Altibase://127.0.0.1:20300" + "/mydb";
		String user = "SMSSUSER";
		String passwd = "SMSSUSER";
		String enc = "US7ASCII";
		props.put("user", user);
		props.put("password", passwd);
		props.put("encoding", enc);


		try {
			Class.forName("Altibase.jdbc.driver.AltibaseDriver");
            con = DriverManager.getConnection(url,props);
			sel(con);
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			try{
				con.close();
			}catch(Exception e) {}
		}

	}
}
