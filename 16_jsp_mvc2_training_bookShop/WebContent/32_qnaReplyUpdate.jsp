<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="css/style.css"/>
<script src="js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		
	    $("#update").click(function(){		
	    	  var qna_id = $("#qna_id").val();
	  		  var query = {qna_content:$("#uRContent").val(),
	  				       qna_id:$("#qna_id").val()};
	  
	  		  $.ajax({
	  		     type: "POST",
	  		     url: "mg/qnaReplyUpdatePro.do",
	  		     data: query,
	  		     success: function(data){
	  		    	window.location.href="mg/qnaList.do";
	  		     }
	  		  });
		});
	    
	    
	    $("#cancle").click(function(){
	    	window.location.href="mg/qnaList.do";
		});  
	    
	});
	
</script>

<c:if test="${empty sessionScope.id}">
	<meta http-equiv="Refresh" content="0;url=mg/managerMain.do" >
</c:if>

<input type="hidden" id="qna_id" value="${qna_id}">

<div id="editForm" class="box">
   <ul>
      <li><label for="content">내용</label>
          <textarea id="uRContent" rows="13" cols="50">${qna.getQna_content()}</textarea>
      <li class="label2">
          <button id="update">수정</button>
          <button id="cancle">취소</button> 
   </ul>
</div>