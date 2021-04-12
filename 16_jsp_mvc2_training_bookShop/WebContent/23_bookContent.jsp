<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="${contextPath}/css/style.css"/>
<script src="${contextPath}/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		$("#insertCart").click(function(){//[장바구니에 담기]버튼 클릭
			var buyer = $("#buyer").val();
			var book_kind = $("#book_kind").val();
			var query = {book_id:$("#book_id").val(),
					     buy_count:$("#buy_count").val(),
					     book_image:$("#book_image").val(),
					     book_title:$("#book_title").val(),
					     buy_price:$("#buy_price").val(),
					     buyer:buyer};		
			$.ajax({
	 		     type: "POST",
	 		     url: "${contextPath}/insertCart.do",
	 		     data: query,
	 		     success: function(data){
	 		    	 alert("장바구니에 담겼습니다."); 
	 		     }
	 		});
		});
		
		$("#list").click(function(){//[목록으로]버튼 클릭
			window.location.href="${contextPath}/list.do?book_kind=all";
		});
		
		$("#shopMain").click(function(){//[메인으로]버튼 클릭
			window.location.href="${contextPath}/index.do";
		});
		
		$("#writeQna").click(function(){//[상품QnA쓰기]버튼 클릭
			var book_id = $("#book_id").val();
			var book_kind = $("#book_kind").val();
			
	 		var query="${contextPath}/qnaForm.do?book_id="+book_id;
	 		query += "&book_kind="+book_kind;
	 		window.location.href=query;
	 		
		});
	});
	
	function edit(editBtn){//[수정]버튼 클릭
		var rStr = editBtn.name;
		var arr = rStr.split(",");
		var query = "${contextPath}/qnaUpdateForm.do?qna_id="+arr[0];
		query += "&book_kind="+arr[1];
		window.location.href=query;
	}
	
	function del(delBtn){//[삭제]버튼 클릭
		var rStr = delBtn.name;
		var arr = rStr.split(",");
		
		var query = {qna_id: arr[0]};
	    $.ajax({
	       type: "POST",
	       url: "${contextPath}/qnaDeletePro.do",
	       data: query,
	       success: function(data){
	    	   var str1 = '<p id="ck">';
	 		   var loc = data.indexOf(str1);
	 		   var len = str1.length;
	 		   var check = data.substr(loc+len,1);
	 		   if(check == "1"){//
	 		  	  alert("QnA가 삭제 되었습니다.");
	 		 	  var query = "${contextPath}/bookContent.do?book_id="+arr[1];
	 			  query += "&book_kind="+arr[2];
	 			  window.location.href=query;
	 	       }else//사용할 수 있는 아이디
	 	  	      alert("QnA가 삭제 실패");
	       }
	    });
	}
</script>

<div id="cata" class="box2">
  <ul>
    <li><a href="${contextPath}/list.do?book_kind=100">문학</a>
    <li><a href="${contextPath}/list.do?book_kind=200">어학</a>
    <li><a href="${contextPath}/list.do?book_kind=300">컴퓨터</a>
    <li><a href="${contextPath}/list.do?book_kind=all">전체</a>
  </ul>
</div>

<div id="showBook">
  <table class="vhcenter"> 
   <tr height="30"> 
     <td rowspan="6"  width="150">
        <img src="${contextPath}/bookImage/${book.getBook_image()}" class="contentimage"></td> 
     <td width="500">
       <b>${book.getBook_title()}</b></td>
   </tr> 
   <tr><td width="500">저자 : ${book.getAuthor()}</td></tr>
   <tr><td width="500">출판사 : ${book.getPublishing_com()}</td></tr> 
   <tr><td width="500">출판일 : ${book.getPublishing_date()}</td></tr>
   <tr><td width="500"><c:set var="price" value="${book.getBook_price()}"/>
         <c:set var="rate" value="${book.getDiscount_rate()}"/>
         정가 : <fmt:formatNumber value="${price}" type="number" pattern="#,##0"/>원<br>
         <strong class="bred">판매가:<c:set var="rPrice" value="${price*((100.0-rate)/100)}"/>
         <fmt:formatNumber value="${rPrice}" type="number" pattern="#,##0"/>원</strong>
   <tr><td width="500">

     <c:if test="${!empty sessionScope.id}">
       <c:if test="${book.getBook_count()==0}">
         <p>일시품절
       </c:if>
       <c:if test="${book.getBook_count()>=1}">
         수량 : <input type="text" size="5" id="buy_count" value="1"> 개
       </c:if>
       <input type="hidden" id="book_id" value="${book_id}">
       <input type="hidden" id="book_image" value="${book.getBook_image()}">
       <input type="hidden" id="book_title" value="${book.getBook_title()}">
       <input type="hidden" id="buy_price" value="${rPrice}">
       <input type="hidden" id="book_kind" value="${book_kind}">
       <input type="hidden" id="buyer" value="${sessionScope.id}">              
       <button id="insertCart">장바구니에 담기</button>
     </c:if>
     <c:if test="${empty sessionScope.id}">
       <c:if test="${book.getBook_count()==0}">
         <p>일시품절
       </c:if>
       <p>제품을 구매하시려면 로그인 하세요.
     </c:if>
     <button id="list">목록으로</button>
     <button id="shopMain">메인으로</button>
   </td>
  </tr>         
  <tr class="ch">
    <td colspan="2" class="hleft">${book.getBook_content()}</td>
  </tr> 
</table>
</div>

<div id="showQna">
<p class="b">상품QnA 
<c:if test="${!empty sessionScope.id}">
   <button id="writeQna">상품QnA쓰기</button>
</c:if>
<c:if test="${empty sessionScope.id}">
   <p>상품QnA를 쓰실려면 로그인 하세요.</p>
</c:if>
</p>
<c:if test="${count == 0}">
   <ul>
      <li>등록된 상품QnA가 없습니다.
   </ul>
</c:if>
<c:if test="${count > 0}">
  <c:forEach var="qna" items="${qnaLists}">
    <ul>
      <li>
        <c:set var="writer" value="${qna.getQna_writer()}"/>
        ${fn:substring(writer, 0, 4)}****
        <small class="date">(${qna.getReg_date()})</small>
      <li>${qna.getQna_content()}
      <li>
        <c:if test="${sessionScope.id==writer}">
          <button id="edit" name="${qna.getQna_id()},${book_kind}" 
	       onclick="edit(this)">수정</button>
	      <button id="delete" name="${qna.getQna_id()},${book_id},${book_kind}" 
	       onclick="del(this)">삭제</button>
        </c:if>   
    </ul>
  </c:forEach>
</c:if>
</div>
