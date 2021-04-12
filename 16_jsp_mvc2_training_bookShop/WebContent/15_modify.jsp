<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="${contextPath}/css/style.css"/>
<script src="${contextPath}/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
	
		$("#modifyProcess").click(function(){//[수정]버튼 클릭
			var query = {id:$("#id").val(), 
					  passwd:$("#passwd").val(),
				      name:$("#name").val(),
				      address:$("#address").val(),
				      tel:$("#tel").val()};
			
			$.ajax({
				type: "post",
				url: "${contextPath}/modifyPro.do",
				data: query,
				success: function(data){
					var str1 = '<p id="ck">';
		    		var loc = data.indexOf(str1);
		    		var len = str1.length;
		    		var check = data.substr(loc+len,1);
		    		if(check == "1"){//
		    			alert("회원정보가 수정되었습니다.");
						window.location.href="${contextPath}/modify.do";
		    	    }else{
		    	    	alert("비밀번호 틀림.");
		    	    	$("#passwd").val("");
		    	    	$("#passwd").focus();
		    	    }
			   }
			});
		});
		
		$("#cancle").click(function(){//[취소]버튼 클릭
			window.location.href="${contextPath}/modify.do";
		});
		
	 });
</script>
<c:if test="${empty sessionScope.id}">
  <meta http-equiv="Refresh" content="0;url=${contextPath}/index.do">
</c:if>

<div id="mStatus">
   <form id="uForm" method="post" action="${contextPath}/modifyForm.do">
    <ul>
        <li><label for="passwd">비밀번호</label>
            <input id="passwd" name="passwd" type="password" 
              size="20" placeholder="6~16자 숫자/문자" maxlength="16">
            <input id="id" name="id" type="hidden" value="${sessionScope.id}">
            <input type="submit" id="modify" value="정보수정">
     </ul>
   </form>
  
   <form id="dForm" method="post" action="${contextPath}/deletePro.do">
    <ul>
        <li><label for="passwd">비밀번호</label>
            <input id="passwd" name="passwd" type="password" 
              size="20" placeholder="6~16자 숫자/문자" maxlength="16">
            <input id="id" name="id" type="hidden" value="${sessionScope.id}">
            <input type="submit" id="delete" value="탈퇴">
            <small class="cau">[탈퇴]버튼을 누르면 바로 탈퇴됨</small>
     </ul>
  </form>
  
  <button id="shopMain" 
  onclick="window.location.href='${contextPath}/index.do';">메인으로</button>
</div>
