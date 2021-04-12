<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<script src="${contextPath}/js/jquery-3.5.1.min.js"></script>
<script>

	$(document).ready(function(){
		$("#registProduct").click(function(){//[상품등록]버튼 클릭
			window.location.href="${contextPath}/mg/bookRegister.do";
	
		});
		
		$("#updateProduct").click(function(){//[상품수정/삭제]버튼 클릭
			window.location.href="${contextPath}/mg/bookList.do?book_kind=all";
				 
		});
		
		$("#orderedProduct").click(function(){//[전체구매목록 확인]버튼 클릭
			
			window.location.href="${contextPath}/mg/orderList.do";
			
		});
		
		$("#qna").click(function(){//[상품 QnA답변]버튼 클릭
			
			window.location.href="${contextPath}/mg/qnaList.do";
		});
	});
</script>

<c:if test="${empty sessionScope.id}">
  <div id="mList"><p>로그인 하세요.
  </div>
</c:if>
<c:if test="${!empty sessionScope.id}">
  <div id="mList">
     <ul>
        <li>상품관련 작업
   
        <li><button id="registProduct">상품등록</button>
        <li><button id="updateProduct">상품수정/삭제</button>
     </ul>
     <ul>
        <li>구매된 상품관련 작업
        <li><button id="orderedProduct">전체구매목록 확인</button>
     </ul>
     <ul>
        <li>상품 QnA 작업
        <li><button id="qna" >상품 QnA답변</button>
     </ul>
    
  </div>
</c:if>    