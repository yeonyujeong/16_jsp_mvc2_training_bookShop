package bookshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bookshop.bean.MemberDTO;
import bookshop.controller.CommandAction;
import bookshop.dao.MemberDAO;

public class _16_ModifyForm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws Throwable {

		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
	
		MemberDAO manager = MemberDAO.getInstance();
		MemberDTO m = manager.getMember(id,passwd); 
		
		request.setAttribute("m",m);
		request.setAttribute("id", id);
		request.setAttribute("type", new Integer(1));
		return "/16_modifyForm.jsp";
		
	}
	
}