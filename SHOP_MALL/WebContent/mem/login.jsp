<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/loginsignup.css">

<div class="login-page">
	<div class="login-container">
		<div class="login-sign">
			<h2 class="loginup-high-T">Login</h2>
		</div>
		<div class="login-part">
			<form name="my" id="my" method="post">
				<div class="login-flex-container">
					<div class="login-fields">
						<input type="text" name="userid" id="userid" placeholder="아이디" required>
						<input type="password" name="password" id="password" placeholder="비밀번호" required>
					</div>
					<button type="button" class="login-button" id="login-button">로그인</button>
				</div>
				<p id="errmsg" class="error"></p>
	
				<div class="remember-me-container">
					<input type="checkbox" class="checkbox" name="rememberU" id="rememberU">
					<label for="rememberU" class="checkbox-label">로그인 유지</label>
				</div>
			</form>
			<div class="login-bottom-buttons">
				<a href="/member/signup.do" class="login-sub-button">회원가입</a> 
				<a href="/member/findidpw.do" class="login-sub-button">아이디/비밀번호 찾기</a>
			</div>
		</div>
			<p id="errmsg" class="error"></p>
		</div>
</div> 
<script>
	$(function() {
		$("#login-button").on("click", function() {
			var userid = $("#userid").val();
			var password = $("#password").val();

			if (userid === "" || password === "" || /\s/.test(userid)) {
				$("#errmsg").text("아이디와 비밀번호를 모두 입력해 주세요.");
				return;
			}

			$.ajax({
				type : "post",
				url : "/member/loginpro.do",
				data : {
					userid : userid,
					password : password
				},
				success : function(response) {
					console.log("서버 응답:", response);
					if (response.trim() === "success") {
						window.location.href = "/";
					} else {
						$("#errmsg").text("아이디 혹은 비밀번호를 확인해 주세요.");
					}
				},
				error : function() {
					$("#errmsg").text("통신 에러 발생.");
				}
			})
		})
	})
</script>

<%@ include file="/fragments/footer.jsp"%>