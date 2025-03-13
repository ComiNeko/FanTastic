<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/findidpw.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<div class="findPW-page">
	<div class="findPW-container">
		<div class="findPW-sign">
			<h2 class="findPW-high-T">Forgot Password?</h2>
		</div>
		
		<div class="findPW-part">
			<!-- 1. 회원 아이디 대조 -->
			<p class="findPW-inform">비밀번호를 찾으시고자 하는 계정의 아이디를 입력해주세요.</p>
			<div class="findPW-ID-entry">
				<div class="findPW-ID-entry-left">
					<label for="userid">아이디</label>
				</div>
				<div class="findPW-ID-entry-right">
					<input type="text" id="userid" name="userid" placeholder="아이디 입력" required>
					<button type="button" id="checkUserId">아이디 확인</button>
				</div>
			</div>
			<p id="err-id"></p>
	
			<!-- 2. 이메일 입력 및 인증 코드 발송 -->
			<div class="findPW-form-group-email" id="email-form" style="display: none;">
				<p class="findPW-inform">계정과 연결된 이메일 주소를 입력해주세요. 이메일 주소를 입력하시면, 인증코드를 해당 이메일 주소로 보내드립니다.</p>
				<label for="email">이메일</label>
				<div class="email-container">
					<div class="email-container-left">
						<input type="text" id="emailPrefix" name="emailPrefix" placeholder="이메일 아이디" required>
						<span>@</span>
						<select id="emailDomain" name="emailDomain">
							<option value="" selected>선택해주세요</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="icloud.com">icloud.com</option>
							<option value="custom">직접입력</option>
						</select>
						<input type="text" id="customEmailDomain" name="customEmailDomain" placeholder="도메인 입력" style="display: none;">
					</div>
					<div class="email-container-right">
						<button type="button" id="verifyEmail">이메일 인증</button>
					</div>
				</div>
			</div>
			<p id="err-email"></p>
	
			<!-- 3. 인증 코드 입력 -->
			<div class="findPW-form-group-auth" id="auth-form" style="display: none;">
				<p class="findPW-inform">메일함을 확인하신 후, 발송된 인증코드를 입력해 주세요. 인증코드는 2분 뒤에 만료됩니다.</p>
				<div class="findPW-auth-part">
					<div class="findPW-auth-left">
						<label for="authCode">인증 코드</label>
					</div>
					<div class="findPW-auth-right">
						<input type="text" id="authCode" name="authCode" placeholder="인증 코드 입력" required>
						<button type="button" id="verifyAuthCode">인증 코드 확인</button>
					</div>
				</div>
				<p id="err-auth"></p>
			</div>
	
			<!-- 4. 재설정 링크 전송 요청 -->
			<div class="findPW-form-group-reset" id="send-link-form" style="display: none;">
				<p class="findPW-inform">아래 버튼을 클릭하면 비밀번호 변경을 위한 링크가 이메일로 전송됩니다. 안전하게 비밀번호를 재설정하세요!</p>
				<div class="findPW-reset-part">
					<button type="button" id="sendResetLink">비밀번호 재설정 링크 전송</button>
					<p id="link-msg"></p>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
	// 도메인 선택 시 직접 입력 필드 토글
	$("#emailDomain").change(
			function() {
				if ($(this).val() === "custom") {
					$("#customEmailDomain").show().prop("required",
							true).prop("disabled", false);
				} else {
					$("#customEmailDomain").hide().prop("required",
							false).prop("disabled", true).val("");
				}
			});

	// Step 1: 아이디 확인
	$("#checkUserId").click(function() {
		$("#err-id").html("");
		
		var userid = $("#userid").val();
		
		if (!userid) {
			$("#err-id").html("<span class='error' style='margin-left: 122px'>아이디를 입력해주세요.</span>");
			return;
		}
		
		$.post("/member/findPwId.do", { userid : userid },
		function(response) {
			var trimmed = response.trim();
			if (trimmed === "success") {
				alert("아이디가 확인되었습니다.");
				$("#id-form").hide();
				$("#email-form").show();
			} else {
				$("#err-id").html("<span class='error' style='margin-left: 122px'>" + trimmed + "</span>");
			}
		});
	});

	// 함수: 전체 이메일 주소 조합
	function getFullEmail() {
		var emailPrefix = $("#emailPrefix").val().trim();
		var emailDomain = $("#emailDomain").val();
		var customEmailDomain = $("#customEmailDomain").val().trim();
		
		if (!emailPrefix) {
            return null;
        }
		
		if (emailDomain === "custom") {
			if (!customEmailDomain) {
                return null;
            } else {
            	return emailPrefix + "@" + customEmailDomain;
            }
		} else {
            if (!emailDomain) {
                return null;
            } else {
          		return emailPrefix + "@" + emailDomain;
            }
        }
	}

	// Step 2: 이메일 인증 (아이디와 이메일 검증 후 인증 코드 발송)
	$("#verifyEmail").click(function() {
		$("#err-email").text("");
		var userid = $("#userid").val();
		var email = getFullEmail();
		
		if (!email) {
			$("#err-email").html("<span class='error'>이메일을 정확히 입력해주세요.</span>");
			return;
		} else {
			$("#err-email").html("");
		}
		
		$.post("/member/findPwEmail.do", {
			userid : userid,
			email : email
		}, function(response) {
			var trimmedResponse = response.trim();
			
			if (trimmedResponse === "success") {
				alert("인증 코드가 이메일로 전송되었습니다.");
				$("#email-form").hide();
				$("#auth-form").show();
			} else {
				$("#err-email").text("<span class='error'>" + trimmedResponse + "</span>");
			}
		});
	});

	// Step 3: 인증 코드 확인
	$("#verifyAuthCode").click(function() {
		$("#err-auth").text("");
		var authCode = $("#authCode").val();
		if (!authCode) {
			$("#err-auth").html("<span class='error-auth'>인증 코드를 입력해주세요.</span>");
			return;
		}
		$.post("/member/findPwCode.do", {
			authCode : authCode
		}, function(response) {
			var trimmed = response.trim();
			if (trimmed === "success") {
				alert("이메일 인증이 완료되었습니다.");
				$("#auth-form").hide();
				$("#send-link-form").show();
			} else {
				$("#err-auth").html("<span class='error-auth'>" + trimmed + "</span>");
			}
		});
	});

	// Step 4: 재설정 링크 전송
	$("#sendResetLink").click(function() {
		$("#link-msg-suc").html(""); // 성공 메시지 초기화
	    $("#link-msg-err").html(""); // 에러 메시지 초기화

	    $.post("/member/findPwToken.do", {}, function(response) {
	        var trimmed = response.trim();
	        
	        if (trimmed === "비밀번호 재설정 이메일이 전송되었습니다.") {
	            $("#link-msg").html("<span class='link-msg-suc'>" + trimmed + "</span>");
	        } else {
	            $("#link-msg").html("<span class='link-msg-err'>" + trimmed + "</span>");
	        }
	    });
	});
});
</script>

<%@ include file="/fragments/footer.jsp" %>
