<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<script src="../js/jquery-3.7.1.min.js"></script>
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
						<input type="text" name="userid" class="userid" id="userid" placeholder="ID" required>
						<input type="password" name="password" id="password" placeholder="パスワード" required>
					</div>
					<button type="button" class="login-button" id="login-button">ログイン</button>
				</div>
				<p id="errmsg" class="error"></p>

				<%--
				<div class="remember-me-container">
					<input type="checkbox" class="checkbox" name="rememberU" id="rememberU">
					<label for="rememberU" class="checkbox-label">로그인 유지</label>
				</div>
				--%>

			</form>
			<div class="login-bottom-buttons">
				<a href="/member/signup.do" class="login-sub-button">会員登録</a>
				<p> <a href="/member/findId.do" class="forgot-idpw">ID</a>
					または
					<a href="/member/findPw.do" class="forgot-idpw">パスワード</a>をお忘れですか？
				</p>
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
				$("#errmsg").html("<span class='error'>아이디와 비밀번호를 모두 입력해 주세요.</span>");
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
						$("#errmsg").html("<span class='error'>아이디 혹은 비밀번호를 확인해 주세요.</span>");
					}
				},
				error : function() {
					$("#errmsg").html("<span class='error'>통신 에러 발생</span>");
				}
			})
		})
	})
</script>

<%@ include file="/fragments/footer.jsp"%>