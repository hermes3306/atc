import java.util.Properties;
import java.sql.*;

class jdbctest
{
    public static void main(String args[]) {
        Properties props = new Properties();
        Connection con = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet res;

/*
        if ( args.length == 0 )
        {
            System.err.println("Usage : java JdbcTest port_no \n");
            System.exit(1);
        }
        String port = args[0];  */


        String url = "jdbc:Altibase://127.0.0.1:20300" + "/mydb";
        String user = "SYS";
        String passwd = "MANAGER";
        String enc = "US7ASCII";

        props.put("user", user);
        props.put("password", passwd);
        props.put("encoding", enc);

    /* 알티베이스 JDBC 드라이버 등록 */
        try {
            Class.forName("Altibase.jdbc.driver.AltibaseDriver");
        } catch ( Exception e ) {
            System.err.println("Can't register Altibase Driver");
            return;
        }

    /* 접속하고 Statment를 할당. */
        try {
            con = DriverManager.getConnection(url,props);
            stmt = con.createStatement();
        } catch ( Exception e ) {
            e.printStackTrace();
        }

    /* 쿼리수행 */
        try {
            stmt.execute("DROP TABLE TEST001");
        } catch ( SQLException se ) { }

        try {       
            stmt.execute("CREATE TABLE TEST001 ( name varchar(20), age number(3) )");
            pstmt = con.prepareStatement("INSERT INTO TEST001 VALUES(?,?)");
            pstmt.setString(1,"김민석");
            pstmt.setInt(2,28);
            pstmt.execute();
   
            pstmt.setString(1,"홍길동");
            pstmt.setInt(2,25);
            pstmt.execute();

            pstmt.setString(1,"아무개");
            pstmt.setInt(2,34);
            pstmt.execute();

            res = stmt.executeQuery("SELECT * FROM TEST001");
    /* 결과를 받아 화면에 출력 */
            while(res.next()) {
                System.out.println(" Name : "+res.getString(1)+", Age : "+res.getInt(2));
            }

    /* 연결 해제 */
            stmt.close();
            pstmt.close();
            con.close();
        } catch ( Exception e ) {
            e.printStackTrace();
        }
    }
}   
