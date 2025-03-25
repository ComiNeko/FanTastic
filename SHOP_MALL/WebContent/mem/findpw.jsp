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
			<p class="findPW-inform">パスワードをお探しのアカウントのIDを入力してください。</p>
			<div class="findPW-ID-entry">
				<div class="findPW-ID-entry-left">
					<label for="userid">ID</label>
				</div>
				<div class="findPW-ID-entry-right">
					<input type="text" id="userid" name="userid" placeholder="ユーザーIDを入力" required>
					<button type="button" id="checkUserId">ID確認</button>
				</div>
			</div>
			<p id="err-id"></p>
	
			<!-- 2. 이메일 입력 및 인증 코드 발송 -->
			<div class="findPW-form-group-email" id="email-form" style="display: none;">
				<p class="findPW-inform">アカウントに登録されたメールアドレスを入力してください。入力すると、認証コードを送信します。</p>
				<label for="email">メールアドレス</label>
				<div class="email-container">
					<div class="email-container-left">
						<input type="text" id="emailPrefix" name="emailPrefix" placeholder="メールID" required>
						<span>@</span>
						<select id="emailDomain" name="emailDomain">
							<option value="" selected>選択してください</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="icloud.com">icloud.com</option>
							<option value="custom">直接入力</option>
						</select>
						<input type="text" id="customEmailDomain" name="customEmailDomain" placeholder="ドメイン入力" style="display: none;">
					</div>
					<div class="email-container-right">
						<button type="button" id="verifyEmail">メール認証</button>
					</div>
				</div>
			</div>
			<p id="err-email"></p>
	
			<!-- 3. 인증 코드 입력 -->
			<div class="findPW-form-group-auth" id="auth-form" style="display: none;">
				<p class="findPW-inform">メールボックスを確認し、送信された認証コードを入力してください。認証コードは2分後に無効になります。</p>
				<div class="findPW-auth-part">
					<div class="findPW-auth-left">
						<label for="authCode">認証コード</label>
					</div>
					<div class="findPW-auth-right">
						<input type="text" id="authCode" name="authCode" placeholder="認証コードを入力" required>
						<button type="button" id="verifyAuthCode">認証コード確認</button>
					</div>
				</div>
				<p id="err-auth"></p>
			</div>
	
			<!-- 4. 재설정 링크 전송 요청 -->
			<div class="findPW-form-group-reset" id="send-link-form" style="display: none;">
				<p class="findPW-inform">以下のボタンをクリックすると、パスワード変更用のリンクがメールで送信されます。安全にパスワードをリセットしてください！</p>
				<div class="findPW-reset-part">
					<button type="button" id="sendResetLink">パスワードリセットリンクを送信</button>
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
			$("#err-id").html("<span class='error' style='margin-left: 122px'>ユーザーIDを入力してください。</span>");
			return;
		}
		
		$.post("/member/findPwId.do", { userid : userid },
		function(response) {
			var trimmed = response.trim();
			if (trimmed === "success") {
				alert("ユーザーIDが確認されました。");
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
			$("#err-email").html("<span class='error'>正しくメールアドレスを入力してください。</span>");
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
				alert("認証コードがメールに送信されました。");
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
			$("#err-auth").html("<span class='error-auth'>認証コードを入力してください。</span>");
			return;
		}
		$.post("/member/findPwCode.do", {
			authCode : authCode
		}, function(response) {
			var trimmed = response.trim();
			if (trimmed === "success") {
				alert("メール認証が完了しました。");
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
	        
	        if (trimmed === "パスワードリセット用のメールが送信されました。") {
	            $("#link-msg").html("<span class='link-msg-suc'>" + trimmed + "</span>");
	        } else {
	            $("#link-msg").html("<span class='link-msg-err'>" + trimmed + "</span>");
	        }
	    });
	});
});
</script>

<%@ include file="/fragments/footer.jsp" %>
