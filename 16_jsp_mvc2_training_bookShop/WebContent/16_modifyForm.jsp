<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="css/style.css"/>
<script src="js/jquery-3.5.1.min.js"></script>
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
				url: "modifyPro.do",
				data: query,
				success: function(data){
					var str1 = '<p id="ck">';
		    		var loc = data.indexOf(str1);
		    		var len = str1.length;
		    		var check = data.substr(loc+len,1);
		    		if(check == "1"){//
		    			alert("회원정보가 수정되었습니다.");
						window.location.href="modify.do";
		    	    }else{
		    	    	alert("비밀번호 틀림.");
		    	    	$("#passwd").val("");
		    	    	$("#passwd").focus();
		    	    }
			   }
			});
		});
		
		$("#cancle").click(function(){//[취소]버튼 클릭
			window.location.href="modify.do";
		});
		
	 });
</script>

<c:if test="${empty sessionScope.id}">
	<meta http-equiv="Refresh" content="0;url=index.do">
</c:if>

<div id="regForm" class="box">
   <ul>
      <li><p class="center">회원 정보 수정
      <li><label for="id">아이디</label>
          <input id="id" name="id" type="email" size="20" 
           maxlength="50" value="${id}" readonly disabled>
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="passwd" type="password" 
           size="20" placeholder="6~16자 숫자/문자" maxlength="16">
           <small class="cau">반드시 입력하세요.</small>
      <li><label for="name">이름</label>
          <input id="name" name="name" type="text" 
           size="20" maxlength="10" value="${m.getName()}">
      <li><label for="address">주소</label>
          <input id="address" name="address" type="text" 
           size="30" maxlength="50" value="${m.getAddress()}">
      <li><label for="tel">전화번호</label>
          <input id="tel" name="tel" type="tel" 
           size="20" maxlength="20" value="${m.getTel()}">
      <li class="label2"><button id="modifyProcess">수정</button>
          <button id="cancle">취소</button>
   </ul>
</div>