<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/loginsignup.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<div class="login-page">
	<div class="FIP-page">
	<div class="FIP-container">
		<div class="FIP-sign">
			<h2 class="FIP-high-T">아이디/비밀번호 찾기</h2>
   			 <p>원하는 항목을 선택하세요.</p>
		</div>
		<div class="FIP-ID">
				 <button type="button" onclick="location.href='/member/findId.do'">
	            아이디 찾기
	        </button>
		</div>
		<div class="FIP-PW">
				 <button type="button" onclick="location.href='/member/findPw.do'">
	            비밀번호 찾기
	        </button>
		</div>
	</div>
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