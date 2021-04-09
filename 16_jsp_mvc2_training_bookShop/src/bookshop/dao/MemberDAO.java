package bookshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import bookshop.bean.MemberDTO;

public class MemberDAO {
	
	private MemberDAO() {}
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/pool");
		return ds.getConnection();
	}

	
	// 회원 가입 처리에서 사용하는 메소드
	public void insertMember(MemberDTO member) {
		
		try {
			
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into member values (?,?,?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getReg_date());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getTel());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
	}

	
	// 로그인 폼 처리의 사용자 인증 처리에서 사용하는 메소드
	public int userCheck(String id, String passwd) {
		
		int x = -1;

		try {
			
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from member where id = ? and passwd=?");
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = 1;
			} 

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return x;
	}

	
	// 아이디 중복 확인에서 아이디의 중복 여부를 확인하는 메소드
	public int confirm(String id) {
		
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select id from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next())	x = 1; 
			else			x = -1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return x;
	}

	
	// 주어진 id에 해당하는 회원정보를 얻어내는 메소드
	public MemberDTO getMember(String id) {
		
		MemberDTO member = null;

		try {
			
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {// 해당 아이디에 대한 레코드가 존재
				member = new MemberDTO();// 데이터저장빈 객체생성
				member.setId(rs.getString("id"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getString("reg_date"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return member;
	}

	
	// 주어진 id, passwd에 해당하는 회원정보를 얻어내는 메소드
	public MemberDTO getMember(String id, String passwd) {
		
		MemberDTO member = null;

		try {
			
			conn = getConnection();


			pstmt = conn.prepareStatement("select * from member where id = ? and passwd = ?"); // 사용자가 입력한 비밀번호와 테이블의 비밀번호가 같으면 수행
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();

			if (rs.next()) {// 해당 아이디에 대한 레코드가 존재

				member = new MemberDTO();// 데이터저장빈 객체생성
				member.setId(rs.getString("id"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getString("reg_date"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return member;
	}

	
	// 회원 정보 수정을 처리하는 메소드
	@SuppressWarnings("resource")
	public int updateMember(MemberDTO member) {
		
		int x = -1;

		try {
			
			conn = getConnection();

			pstmt = conn.prepareStatement("select passwd from member where id = ? and passwd = ?");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			rs = pstmt.executeQuery();

			if (rs.next()) {// 해당 아이디가 있으면 수행
				pstmt = conn.prepareStatement("update member set name=?,address=?,tel=? where id=?");
				pstmt.setString(1, member.getName());
				pstmt.setString(2, member.getAddress());
				pstmt.setString(3, member.getTel());
				pstmt.setString(4, member.getId());
				pstmt.executeUpdate();
				x = 1;// 회원정보 수정 처리 성공

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return x;
	}

	
	// 회원 정보를 삭제하는 메소드
	@SuppressWarnings("resource")
	public int deleteMember(String id, String passwd) {
		
		int x = -1;

		try {
			
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from member where id = ? and passwd = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				pstmt = conn.prepareStatement("delete from member where id=?");
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				x = 1;// 회원탈퇴처리 성공

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return x;
	}
	
}
