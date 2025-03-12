<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/loginsignup.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<div class="FI-page">
	<div class="FI-container">
		<div class="FI-sign">
			<h2 class="FI-high-T">찾은 아이디</h2>
   			 
   			<h2>회원님의 아이디</h2>
    		<p>${maskedId}</p>
    		<a href="/member/login.do">로그인</a>
		</div>
	</div>
</div>		

<%@ include file="/fragments/footer.jsp"%>