package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBConnectionTest2 {
	public static final String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	public static final String USER = "kh";
	public static final String PASSWARD = "kh";

	public static void main(String[] args) {
		
		try {
			// 1. 드라이버 로딩
			Class.forName(DRIVER_NAME);
			// 2. 디비 연결
			Connection conn = DriverManager.getConnection(URL,USER,PASSWARD);
			System.out.println("Connection ...!!");
			
			// 3. Statement 객체 생성 = INSERT
			String query = "INSERT INTO emp(emp_id, emp_name) VALUES(?, ?)";
			PreparedStatement st = conn.prepareStatement(query);
			
			// 4. 쿼리문 실행
			st.setInt(1, 2);
			st.setString(2, "박주영");
			
			int result = st.executeUpdate();
			
			System.out.println(result + " 명 추가 !");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	}

}
