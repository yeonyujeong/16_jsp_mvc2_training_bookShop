package bookshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bookshop.dao.ManagerDAO;
import bookshop.controller.CommandAction;


public class _10_BookDeletePro implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws Throwable {
			
		int book_id = Integer.parseInt(request.getParameter("book_id"));
		String book_kind = request.getParameter("book_kind");
		
		ManagerDAO bookProcess = ManagerDAO.getInstance();
		bookProcess.deleteBook(book_id); 
		
		request.setAttribute("book_kind", book_kind);
		return "/10_bookDeletePro.jsp";
		
	}
	
}