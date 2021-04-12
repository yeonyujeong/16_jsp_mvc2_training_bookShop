<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="${contextPath}/css/style.css"/>
<script src="${contextPath}/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		
		$("#regist").click(function(){//[책등록]버튼 클릭
			window.location.href="${contextPath}/mg/bookRegister.do";
		});
		
		$("#bookMain").click(function(){//[관리자 메인으로]버튼 클릭
			window.location.href="${contextPath}/mg/managerMain.do";
		});
	});
	
	//[수정]버튼을 클릭하면 자동실행
	function edit(editBtn){
		var rStr = editBtn.name;
		var arr = rStr.split(",");
		var query = "${contextPath}/mg/bookUpdate.do?book_id="+arr[0];
		query += "&book_kind="+arr[1];
		window.location.href=query;
	}
	
	//[삭제]버튼을 클릭하면 자동실행
	function del(delBtn){
		var rStr = delBtn.name;
		var arr = rStr.split(",");
		var query = "${contextPath}/mg/bookDeletePro.do?book_id="+arr[0];
		query += "&book_kind="+arr[1];
		window.location.href=query;
	}
</script>

<c:if test="${empty sessionScope.id}">
  <meta http-equiv="Refresh" content="0;url=${contextPath}/mg/managerMain.do" >
</c:if>

<div id="listHeader">
  <p>등록된 상품 목록(전체 상품:${count})
  <button id="regist">책 등록</button>
  <button id="bookMain">관리자 메인으로</button>
</div>
<div id="books">
  <c:if test="${count == 0}">
    <ul>
      <li>등록된 상품이 없습니다.
    </ul>
  </c:if>
  <c:if test="${count > 0}">
  <table> 
    <tr class="title"> 
      <td align="center"  width="30">번호</td> 
      <td align="center"  width="30">책분류</td> 
      <td align="center"  width="100">제목</td>
      <td align="center"  width="50">가격</td> 
      <td align="center"  width="50">수량</td> 
      <td align="center"  width="70">저자</td>
      <td align="center"  width="70">출판사</td>
      <td align="center"  width="50">출판일</td>
      <td align="center"  width="50">책이미지</td>
      <td align="center"  width="30">할인율</td>
      <td align="center"  width="70">등록일</td>
      <td align="center"  width="50">수정</td>
      <td align="center"  width="50">삭제</td>           
    </tr>

   <c:set var="number" value="${0}"/>
   <c:forEach var="book" items="${bookList}">
   <tr>
    <td align="center"  width="50" >
      <c:set var="number" value="${number+1}"/>
	  <c:out value="${number}"/>
	</td>
    <td width="30">${book.getBook_kind()}</td> 
      <td width="100" align="left">
           ${book.getBook_title()}</td>
      <td width="50" align="right">${book.getBook_price()}</td> 
      <td width="50" align="right">
      <c:if test="${book.getBook_count() == 0}">
         <font color="red">일시품절</font>
      </c:if>
      <c:if test="${book.getBook_count() > 0}">
         ${book.getBook_count()}
      </c:if>
      </td> 
      <td width="70">${book.getAuthor()}</td>
      <td width="70">${book.getPublishing_com()}</td>
      <td width="50">${book.getPublishing_date()}</td>
      <td width="50">${book.getBook_image()}</td>
      <td width="50">${book.getDiscount_rate()}</td>
      <td width="50">${book.getReg_date()}</td>
      <%--
       <td width="50"><fmt:formatDate pattern="yyyy-MM-dd" value="${book.getReg_date()}"/></td>
       --%>
     
      <td width="50">
      <button id="edit" name="${book.getBook_id()},${book.getBook_kind()}" onclick="edit(this)">수정</button></td>
	  <td width="50">
	  <button id="delete" name="${book.getBook_id()},${book.getBook_kind()}" onclick="del(this)">삭제</button></td> 
   </tr>
  </c:forEach>
</table>
</c:if>
</div>