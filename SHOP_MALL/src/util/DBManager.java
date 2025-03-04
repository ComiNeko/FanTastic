package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBManager {
	
	private static DBManager instance = new DBManager ();
	
	private DBManager() {};
	
	public static DBManager getInstance() {
		return instance;
	}
	
	public Connection getConnection() {
		
		Connection cnn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "user21";
		String pw = "1234";
		
		try {
			Class.forName(driver);
			cnn = DriverManager.getConnection(url, id, pw);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return cnn;
	}
	
	
	public void close(PreparedStatement pstmt, Connection cnn) {
		try {

			if(pstmt != null)pstmt.close();
			if(cnn != null)cnn.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close(ResultSet rs, PreparedStatement pstmt, Connection cnn) {
		try {
			if(rs != null)rs.close();
			if(pstmt != null)pstmt.close();
			if(cnn != null)cnn.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	

}

