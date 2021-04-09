package bookshop.command;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import bookshop.bean.MemberDTO;
import bookshop.controller.CommandAction;
import bookshop.dao.MemberDAO;

public class _19_RegisterPro implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request,HttpServletResponse response) throws Throwable {
	
		request.setCharacterEncoding("utf-8");	
		
		MemberDTO member = new MemberDTO();
		member.setId(request.getParameter("id"));
        member.setPasswd(request.getParameter("passwd"));
        member.setName(request.getParameter("name"));
        member.setReg_date(new Timestamp(System.currentTimeMillis()).toString());
		member.setAddress(request.getParameter("address"));
		member.setTel(request.getParameter("tel"));
        
		//회원가입처리
        MemberDAO dbPro = MemberDAO.getInstance();
        dbPro.insertMember(member);
		
		return "/19_registerPro.jsp";
		
	}

}
