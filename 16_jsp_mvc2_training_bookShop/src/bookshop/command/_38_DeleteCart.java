package bookshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bookshop.dao.CartDAO;
import bookshop.controller.CommandAction;

public class _38_DeleteCart implements CommandAction {

	@Override	
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws Throwable {
		
		request.setCharacterEncoding("utf-8");
		String list = request.getParameter("list");
		String msg = "";
		
		CartDAO bookProcess = CartDAO.getInstance();
		
		if (list.equals("all")) {			
			String buyer = request.getParameter("buyer");
			bookProcess.deleteAll(buyer);
			msg = "장바구니가 모두 비워졌습니다.";
		}
		else {			
			bookProcess.deleteList(Integer.parseInt(list));
			msg = "지정한 항목이 삭제되었습니다..";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("type", new Integer(1));
		
		return "/38_deleteCart.jsp";
		
	}

}
