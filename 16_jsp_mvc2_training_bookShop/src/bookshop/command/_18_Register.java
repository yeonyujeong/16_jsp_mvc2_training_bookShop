package bookshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bookshop.controller.CommandAction;

public class _18_Register implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws Throwable {		
		
		request.setAttribute("type", new Integer(1));
		
		return "/18_register.jsp";
	
	}
	
}