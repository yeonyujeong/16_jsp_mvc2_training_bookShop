<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="${contextPath}/css/style.css"/>
<script src="${contextPath}/js/jquery-3.5.1.min.js"></script>

<script>
	$(document).ready(function(){
	    $("#regist").click(function(){//[등록]버튼 클릭
	    	  var book_kind = $("#book_kind").val();
	    	  var book_id = $("#book_id").val();
	
	  		  var query = {qna_content:$("#qnaCont").val(),
	  				       qna_writer:$("#qna_writer").val(),
	  				       book_title:$("#book_title").val(),
	  				       book_id:book_id,
	  				       qora:$("#qora").val()};
	  		  
	  		  $.ajax({
	  		     type: "POST",
	  		     url: "${contextPath}/qnaPro.do",
	  		     data: query,
	  		     success: function(data){
	  		    	var str1 = '<p id="ck">';
		    		var loc = data.indexOf(str1);
		    		var len = str1.length;
		    		var check = data.substr(loc+len,1);
		    		if(check == "1"){//
		    			alert("QnA가 등록되었습니다.");
	 		    		var query = "${contextPath}/bookContent.do?book_id="+book_id;
	 		    		query += "&book_kind="+book_kind;
	 		    		window.location.href=query;
		    	     }else
		    	    	 alert("QnA 등록 실패");
	  		     }
	  		  });
		});
	    
	    $("#cancle").click(function(){//[취소]버튼 클릭
	    	var book_kind = $("#book_kind").val();
	    	var book_id = $("#book_id").val();
	    	var query = "${contextPath}/bookContent.do?book_id="+book_id;
	 		query += "&book_kind="+book_kind;
	 		window.location.href=query;
		});
	       
	});
</script>

<c:if test="${empty sessionScope.id}">
  <meta http-equiv="Refresh" content="0;url=${contextPath}/index.do">
</c:if>

<input type="hidden" id="qna_writer" value="${sessionScope.id}">
<input type="hidden" id="book_kind" value="${book_kind}">
<input type="hidden" id="book_id" value="${book_id}">
<input type="hidden" id="book_title" value="${book_title}">
<input type="hidden" id="qora" value="${qora}">

<div id="writeForm" class="box">
   <ul>
      <li>[${book_title}]에 대한 QnA
      <li><label for="content">내용</label>
          <textarea id="qnaCont" rows="13" cols="50"></textarea>
      <li class="label2">
          <button id="regist">등록</button>
          <button id="cancle">취소</button> 
   </ul>
</div>