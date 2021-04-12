<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="${contextPath}/css/style.css"/>
<script src="${contextPath}/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		$("#checkId").click(function(){//[ID중복확인]버튼 클릭
		  if($("#id").val()){
			var query = {id:$("#id").val()};
			
		    $.ajax({
		    	type:"post",
		    	url:"${contextPath}/confirmId.do",
		    	data:query,
		    	success:function(data){
		    		var str1 = '<p id="ck">';
		    		var loc = data.indexOf(str1);
		    		var len = str1.length;
		    		var check = data.substr(loc+len,1);
		    		if(check == "1"){//사용할 수 없는 아이디
		    			alert("사용할 수 없는 아이디");
		    	    	$("#id").val("");
		    	     }else//사용할 수 있는 아이디
		    	  	    alert("사용할 수 있는 아이디");
		 	    }
		    });
		  }else{//아이디를 입력하지 않고 [ID중복확인]버튼을 클릭한 경우
			  alert("사용할 아이디를 입력");
			  $("#id").focus();
		  }
		});
		
		$("#process").click(function(){//[가입하기]버튼 클릭
			  var query = {id:$("#id").val(), 
					  passwd:$("#passwd").val(),
				      name:$("#name").val(),
				      address:$("#address").val(),
				      tel:$("#tel").val()};
			  
			  $.ajax({
			      type:"post",
			      url:"${contextPath}/registerPro.do",
			      data:query,
			      success:function(data){
			    	  window.location.href="${contextPath}/index.do";
			 	  }
			  });
		});
		
		$("#cancle").click(function(){//[취소]버튼 클릭
			window.location.href="${contextPath}/index.do";
		});
	
	 });
</script>

<div id="regForm" class="box">
   <ul>
      <li><label for="id">아이디</label>
          <input id="id" name="id" type="email" size="20" 
           maxlength="50" placeholder="example@kings.com" autofocus>
          <button id="checkId">ID중복확인</button>
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="passwd" type="password" 
           size="20" placeholder="6~16자 숫자/문자" maxlength="16">
      <li><label for="repass">비밀번호 재입력</label>
          <input id="repass" name="repass" type="password" 
           size="20" placeholder="비밀번호재입력" maxlength="16">
      <li><label for="name">이름</label>
          <input id="name" name="name" type="text" 
           size="20" placeholder="홍길동" maxlength="10">
      <li><label for="address">주소</label>
          <input id="address" name="address" type="text" 
           size="30" placeholder="주소 입력" maxlength="50">
      <li><label for="tel">전화번호</label>
          <input id="tel" name="tel" type="tel" 
           size="20" placeholder="전화번호 입력" maxlength="20">
      <li class="label2"><button id="process">가입하기</button>
          <button id="cancle">취소</button>
   </ul>
</div>