package bookshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import bookshop.bean.ManagerDTO;

public class ManagerDAO {

	private ManagerDAO() {}
	private static ManagerDAO instance = new ManagerDAO();
	public static ManagerDAO getInstance() {
		return instance;
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/pool");
		conn = ds.getConnection();
		return conn;
	}

	
	// 관리자 인증 메서드
	public int userCheck(String id, String passwd) {
		
		int check = -1;
		
		try {
			conn = getConnection();

			String sql = "SELECT managerPw FROM manager WHERE managerId=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String dbpw = rs.getString("managerPw");
				if (passwd.equals(dbpw)) {
					check = 1;

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		System.out.println("[check]" + check);
		return check;
	}
	
	
	// 해당 분류의 책의 수를 얻어내는 메소드
	public int getBookCount(String book_kind)  {
	   
	    int x=0;
	    int kind  = Integer.parseInt(book_kind);

	    try {
	    	
	        conn = getConnection();
	        String query = "select count(*) from book where book_kind=" + kind;
	        pstmt = conn.prepareStatement(query);
	        rs = pstmt.executeQuery();

	        if (rs.next()) 
	            x= rs.getInt(1);
	        
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    } finally {
	    	if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
	    }
		return x;
	}
	
	
	//책의 제목을 얻어냄
	public String getBookTitle(int book_id){
        
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String x="";

        try {
            
        	conn = getConnection();          
            pstmt = conn.prepareStatement("select book_title from book where book_id = "+book_id);
            rs = pstmt.executeQuery();

            if (rs.next()) 
               x= rs.getString(1);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
        	if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
        }
		return x;
    }
	
	
	// 전체 등록된 책의 수를 얻어내는 메서드
	public int getBookCount() {

		int count = 0;

		try {
			
			conn = getConnection();

			String sql = "SELECT COUNT(*) FROM book";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return count;
	}

	
	public List<ManagerDTO> getBooks(String book_kind) {

		List<ManagerDTO> bookList = null;

		try {

			conn = getConnection();

			String sql1 = "SELECT * FROM book";
			String sql2 = "SELECT * FROM book ";
			sql2 += "WHERE book_kind=? ORDER BY reg_date DESC";

			if (book_kind.equals("all")) {
				pstmt = conn.prepareStatement(sql1);
			} else {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, book_kind);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				
				bookList = new ArrayList<ManagerDTO>();
				do {
					
					ManagerDTO book = new ManagerDTO();

					book.setBook_id(rs.getInt("book_id"));
					book.setBook_kind(rs.getString("book_kind"));
					book.setBook_title(rs.getString("book_title"));

					book.setBook_price(rs.getInt("book_price"));
					book.setBook_count(rs.getInt("book_count"));
					book.setAuthor(rs.getString("author"));
					book.setPublishing_com(rs.getString("publishing_com"));
					book.setPublishing_date(rs.getString("publishing_date"));
					book.setBook_image(rs.getString("book_image"));
					book.setDiscount_rate(rs.getInt("discount_rate"));
					book.setReg_date(rs.getString("reg_date"));

					bookList.add(book);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return bookList;
	}

	
	// 이미 등록된 책을 검증
	public int registedBookconfirm(String book_kind, String book_title, String author) {

		int check = 1; // 해당 책이 등록되어 있지 않음

		try {

			conn = getConnection();

			String sql = "SELECT book_title FROM book ";
			sql += " WHERE book_kind=? AND book_title=? AND author=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, book_kind);
			pstmt.setString(2, book_title);
			pstmt.setString(3, author);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				check = -1; // 해당 책이 이미 등록되어 있음
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return check;
	}

	// 책 등록 메서드
	public void insertBook(ManagerDTO book) {

		int num = 0;

		try {
			conn = getConnection();

			// num의 최대값을 꺼내와 1증가 시키기
			String sql = "SELECT COUNT(book_id) FROM book";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}

			sql = "INSERT INTO book(book_id,book_kind,book_title,book_price,";
			sql += "book_count,author,publishing_com,publishing_date,book_image,";
			sql += "book_content,discount_rate,reg_date) VALUES (?,?,?,?,?,?,?,?,?,?,?,now())";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, book.getBook_kind());
			pstmt.setString(3, book.getBook_title());
			pstmt.setInt(4, book.getBook_price());
			pstmt.setInt(5, book.getBook_count());
			pstmt.setString(6, book.getAuthor());
			pstmt.setString(7, book.getPublishing_com());
			pstmt.setString(8, book.getPublishing_date());
			pstmt.setString(9, book.getBook_image());
			pstmt.setString(10, book.getBook_content());
			pstmt.setInt(11, book.getDiscount_rate());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
	}

	
	// bookId에 해당하는 책의 정보를 얻어내는 메소드로
	// 등록된 책을 수정하기 위해 수정폼으로 읽어들기이기 위한 메서드
	public ManagerDTO getBook(int bookId) {

		ManagerDTO book = null;

		try {
			
			conn = getConnection();

			String sql = "SELECT * FROM book WHERE book_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bookId);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				book = new ManagerDTO();

				book.setBook_kind(rs.getString("book_kind"));
				book.setBook_title(rs.getString("book_title"));
				book.setBook_price(rs.getInt("book_price"));
				book.setBook_count(rs.getInt("book_count"));
				book.setAuthor(rs.getString("author"));
				book.setPublishing_com(rs.getString("publishing_com"));
				book.setPublishing_date(rs.getString("publishing_date"));
				book.setBook_image(rs.getString("book_image"));
				book.setBook_content(rs.getString("book_content"));
				book.setDiscount_rate(rs.getInt("discount_rate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
		}
		return book;
	}
	
	
	// 등록된 책의 정보를 수정시 사용하는 메소드
    public void updateBook(ManagerDTO book, int book_id) {
        
    	try {
    		
            conn = getConnection();
            
            String sql = "UPDATE book SET book_kind=?,book_title=?,book_price=?";
            sql += ",book_count=?,author=?,publishing_com=?,publishing_date=?";
            sql += ",book_image=?,book_content=?,discount_rate=?";
            sql += " where book_id=?";
            
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, book.getBook_kind());
            pstmt.setString(2, book.getBook_title());
            pstmt.setInt(3, book.getBook_price());
            pstmt.setInt(4, book.getBook_count());
            pstmt.setString(5, book.getAuthor());
            pstmt.setString(6, book.getPublishing_com());
			pstmt.setString(7, book.getPublishing_date());
			pstmt.setString(8, book.getBook_image());
			pstmt.setString(9, book.getBook_content());
			pstmt.setInt(10, book.getDiscount_rate());
			pstmt.setInt(11, book_id);
            
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	if (pstmt != null) try{ pstmt.close(); }catch(SQLException e) {}
        	if (conn != null) try{ conn.close(); }catch(SQLException e) {}
        }
    }
    
    
    // bookId에 해당하는 책의 정보를 삭제시 사용하는 메소드
    public void deleteBook(int bookId) {
        
        try {
        	
			conn = getConnection();
			
			String sql = "DELETE FROM book WHERE book_id=?"; 
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookId);
            
            pstmt.executeUpdate();
            
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
        	if (rs != null)    try {rs.close();}    catch (SQLException e) {}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
        }
    }
    
    
 // 쇼핑몰 메인에 표시하기 위해서 사용하는 분류별 신간책목록을 얻어내는 메소드
 	public ManagerDTO[] getBooks(String book_kind, int count) {

 		ManagerDTO bookList[]=null;
         
 		int i = 0;
         
         try {
        	 
             conn = getConnection();
             
             String sql = "SELECT * FROM book WHERE book_kind=? ";
             sql += "ORDER  BY reg_date DESC LIMIT ?,?";
             
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, book_kind);
             pstmt.setInt(2, 0);
             pstmt.setInt(3, count);
             
         	rs = pstmt.executeQuery();

             if (rs.next()) {
             
             	bookList = new ManagerDTO[count];
                 
             	do {
                 	ManagerDTO book= new ManagerDTO();
                 	
                     book.setBook_id(rs.getInt("book_id"));
                     book.setBook_kind(rs.getString("book_kind"));
                     book.setBook_title(rs.getString("book_title"));
                     book.setBook_price(rs.getInt("book_price"));
                     book.setBook_count(rs.getInt("book_count"));
                     book.setAuthor(rs.getString("author"));
                     book.setPublishing_com(rs.getString("publishing_com"));
                     book.setPublishing_date(rs.getString("publishing_date"));
                     book.setBook_image(rs.getString("book_image"));
                     book.setDiscount_rate(rs.getInt("discount_rate"));
                     book.setReg_date(rs.getString("reg_date"));
                      
                     bookList[i]=book;
                      
                     i++;
                     
 			    }while(rs.next());
 			}
         } catch (Exception e) {
             e.printStackTrace();
         } finally {
        	if (rs != null)    try {rs.close();}    catch (SQLException e) {}
 			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
 			if (conn != null)  try {conn.close();}  catch (SQLException e) {}
         }
 		return bookList;
     }
 	
}
