package bookshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import bookshop.dao.MemberDAO;
import bookshop.controller.CommandAction;

public class _20_Confirm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws Throwable {
		
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		  
		MemberDAO manager = MemberDAO.getInstance();
		int check= manager.confirm(id);
		
		request.setAttribute("check", new Integer(check));
		
		return "/20_confirm.jsp";
		
	}
	
}