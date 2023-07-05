package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

import config.ServerInfo;

public class BookDAO implements BookDAOTemplate {

	private Properties p = new Properties();
	
	public BookDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}

	@Override
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();
		conn.close();	
	}
	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		rs.close();
		closeAll(st, conn);
	}

	@Override
	public ArrayList<Book> printBookAll() throws SQLException {
		return null;
	}

	@Override
	public int registerBook(Book book) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerBook"));
		
		st.setString(1, book.getBkTitle());
		st.setString(2, book.getBkAuthor());
		st.setInt(3, book.getBkno());
		
		st.executeUpdate();
		
		closeAll(st,conn);
		
		return 0;
	}

	@Override
	public int sellBook(int no) throws SQLException {
		// 책 삭제!( Delete )
		return 0;
	}

	@Override
	public int registerMember(Member member) throws SQLException {
		// id, name, password
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPwd());
		st.setString(3, member.getMemberName());
		
		st.executeUpdate();
		
		closeAll(st,conn);
		
		return 0;
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		// char rs.getString("status").charAt(0)
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("getMember"));
		
		st.setString(1, id);
		st.setString(2, password);
		
		ResultSet rs = st.executeQuery();
		Member m = null;
		
		if(rs.next()) {
			m = new Member(rs.getString("id"),
					rs.getString("password"),
					rs.getString("name"));
		}
		
		closeAll(rs,st,conn);
		
		return m;
	
	}

	@Override
	public int deleteMember(String id, String password) throws SQLException {
		// UPDATE - STATUS를 Y 로!
		// status가 n이면 회원 유지, y면 회원 탈퇴
		// n이 기본값! <-- 회원유지
		return 0;
	}

	@Override
	public int rentBook(Rent rent) throws SQLException {
		return 0;
	}

	@Override
	public int deleteRent(int no) throws SQLException {
		return 0;
	}

	@Override
	public ArrayList<Rent> printRentBook(String id) throws SQLException {
		// SQL문 - JOIN필요 ! 테이블 다 엮어야함
		// 이유 -->  rent_no, rent_date , bk_title, bk_author
		// 조건은 member_id가지고 가져오니까
		
		// while 문 안에서 ! Rent rent= new Rent();
		// setter 사용!!
		// rest.setBook(new Book(rs.getString("bk_title"), rs.getString("bk_author")));
		return null;
	}



}
