package bookshop.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bookshop.bean.ManagerDTO;
import bookshop.controller.CommandAction;
import bookshop.dao.ManagerDAO;

public class _11_ShopMain implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws Throwable {
			
		ManagerDTO bookList[] = null;
		List<ManagerDTO[]> bookLists = new ArrayList<ManagerDTO[]>();
		
		ManagerDAO bookProcess = ManagerDAO.getInstance();
		
		//카테고리별 최신의 상품 3개씩 얻어내서 List에 저장
		for(int i=1; i<=3;i++){
			bookList = bookProcess.getBooks(i+"00",3);
			bookLists.add(bookList);
		}
		 
        request.setAttribute("bookLists", bookLists);   
		request.setAttribute("type", new Integer(1));
		
		return "/11_shopMain.jsp";
		
	}
	
}