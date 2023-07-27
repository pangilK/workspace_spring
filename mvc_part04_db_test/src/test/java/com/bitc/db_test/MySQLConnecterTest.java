package com.bitc.db_test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

public class MySQLConnecterTest {
	
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/digital_spring";
	String user = "digital";
	String pass = "12345";
	
	@Test
	public void testConnection() {
		Connection conn = null;
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,user,pass);
			
		} catch (ClassNotFoundException e) {
			System.out.println("DrvierClass 찾을수 없음 라이브러리를 등록해 주세요");
		} catch (SQLException e) {
			System.out.println("DB연결정보 오류 " + e.getMessage());
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	
	}
}
