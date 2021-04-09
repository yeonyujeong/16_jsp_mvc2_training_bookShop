package bookshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import bookshop.dao.MemberDAO;
import bookshop.controller.CommandAction;

public class _13_LoginPro implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws Throwable {
		
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String passwd  = request.getParameter("passwd");

		MemberDAO manager = MemberDAO.getInstance();
		int check= manager.userCheck(id,passwd);
		// 아이디비번맞으면 1 아니면 -1 반환
		
		request.setAttribute("id", id);
		request.setAttribute("check", new Integer(check));
		return "/13_loginPro.jsp";
		
	}
	
}