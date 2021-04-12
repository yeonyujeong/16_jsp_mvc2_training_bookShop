<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="${contextPath}/css/style.css"/>
<script src="${contextPath}/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		//[로그인]버튼을 클릭하면 자동실행	
		$("#login").click(function(){
			var query = {id : $("#id").val(), 
					     passwd:$("#passwd").val()};
			  
			$.ajax({
			   type: "POST",
			   url: "${contextPath}/mg/managerLoginPro.do",
			   data: query,
			   success: function(data){
				  
				   window.location.href="${contextPath}/mg/managerMain.do";	
			   
			   }
			});
		});
		
		//[로그아웃]버튼을 클릭하면 자동실행
		$("#logout").click(function(){
			$.ajax({
			   type: "POST",
			   url: "${contextPath}/mg/managerLogout.do",
			   success: function(data){
				  
				   window.location.href="${contextPath}/mg/managerMain.do";
					
			   }
			});
		});
		
	 });
</script>

<c:if test="${empty sessionScope.id}">
  <div id="status">
     <ul>
        <li><label for="id">아이디</label>
            <input id="id" name="id" type="email" size="20" 
              maxlength="50" placeholder="example@kings.com">
            <label for="passwd">비밀번호</label>
            <input id="passwd" name="passwd" type="password" 
              size="20" placeholder="6~16자 숫자/문자" maxlength="16">
            <button id="login">로그인</button>
     </ul>
  </div>
</c:if>
<c:if test="${!empty sessionScope.id}">
  <div id="status">
     <ul>
        <li>관리자 로그인 성공!!. 작업중...
           <button id="logout">로그아웃</button>
     </ul>
  </div>
</c:if> 