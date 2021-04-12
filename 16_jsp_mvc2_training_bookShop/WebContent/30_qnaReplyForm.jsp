<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="${contextPath}/css/style.css"/>
<script src="${contextPath}/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
	    $("#replyPro").click(function(){//[답변하기]버튼 클릭
	  		  var query = {qna_content:$("#rContent").val(),
	  				       qna_writer:$("#qna_writer").val(),
	  				       book_title:$("#book_title").val(),
	  				       book_id:$("#book_id").val(),
	  				       qna_id:$("#qna_id").val(),
	  				       qora:$("#qora").val()};
	  		  
	  		  $.ajax({
	  		     type: "POST",
	  		     url: "${contextPath}/mg/qnaReplyPro.do",
	  		     data: query,
	  		     success: function(data){
	  		    	window.location.href="${contextPath}/mg/qnaList.do";
	  		     }
	  		  });
		});
	    
	    $("#cancle").click(function(){//[취소]버튼 클릭
	    	window.location.href="${contextPath}/mg/managerMain.do";
		});
	       
	});
</script>

<c:if test="${empty sessionScope.id}">
  <meta http-equiv="Refresh" content="0;url=${contextPath}/mg/managerMain.do" >
</c:if>

<input type="hidden" id="qna_writer" value="manager">
<input type="hidden" id="qna_id" value="${qna_id}">
<input type="hidden" id="book_id" value="${book_id}">
<input type="hidden" id="book_title" value="${book_title}">
<input type="hidden" id="qora" value="${qora}">

<div id="writeForm" class="box">
   <ul>
      <li><p>[${book_title}] 의 QnA </p>
          <p>QnA내용:${qna_content}</p>
      <li><label for="rContent">답변</label>
          <textarea id="rContent" rows="13" cols="50"></textarea>
      <li class="label2">
          <button id="replyPro">답변하기</button>
          <button id="cancle">취소</button> 
   </ul>
</div>