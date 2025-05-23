<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../css/loginsignup.css">

<div class="signup-page">
	<div class="signup-container">
		<div class="signup-sign">
			<h2 class="signup-high-T">Sign-Up</h2>
		</div>
		<div class="signup-part">
			<form id="signupForm" action="/member/signuppro.do" method="post" novalidate>
				<div class="signup-form-group">
				    <label for="name">이름</label>
				    <input type="text" id="name" name="name" placeholder="이름(실명)을 입력하세요." required>
				</div>
				<p id="err-name"></p>
				
				<div class="signup-form-group">
				    <label for="userid">아이디</label>
				    <input type="text" id="userid" name="userid" placeholder="아이디를 입력하세요." maxlength="20" required>
				</div>
				<p id="err-id"></p>
				
				<div class="signup-form-group">
					<label for="password">비밀번호</label>
					<input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요." maxlength="25" required>
				</div>
				<p id="err-pwd"></p>
				
				<div class="signup-form-group">
					<label for="passwordConfirm">비밀번호 확인</label>
					<input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호를 확인해주세요." maxlength="25" required>
				</div>
				<p id="err-pwdc"></p>
				
				<div class="signup-form-group">
					<label for="phonenumber">전화번호</label>
					<input type="text" id="phonenumber" name="phonenumber" placeholder="전화번호를 입력해주세요." required>
				</div>
				<p id="err-phonenumber"></p>

				<div class="signup-form-group-address">
					<label for="address">주소</label>
					<div class="signup-address">
						<input type="text" id="address" name="address" placeholder="주소를 입력하세요." required>
						<p id="err-address"></p>
						<button type="button" id="findAddressBtn">주소 찾기</button>
					</div>
					<div class="signup-detailAddress">
						<input type="text" id="detailAddress" name="detailAddress" placeholder="상세 주소(동/호 등)를 입력하세요.">
						<p id="err-detailAddress"></p>
					</div>
				</div>

				<div class="signup-form-group-email">
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
							<p id="err-email"></p>
						</div>
						<div class="email-container-right">
							<button type="button" id="sendEmailBtn">이메일 인증</button>
						</div>
					</div>
				</div>

				<div class="signup-form-group-auth">
					<div class="signup-auth-left">
						<label class="authCode" for="authCode">인증 코드</label>
					</div>
					<div class="signup-auth-right">
						<input type="text" id="authCode" name="authCode" placeholder="인증 코드를 입력하세요." required>
						<button type="button" id="verifyCodeBtn">인증 확인</button>
					</div>
				</div>
				<p id="err-code"></p>

				<!-- 약관 동의 -->
				<div class="checkbox-container">
					<div class="signup-checkbox-group">
						<input type="checkbox" id="terms" name="terms">
						<label for="terms">이용약관에 동의합니다.</label>
					</div>
					<div class="signup-checkbox-button">
						<button type="button" onclick="toggleDetails('termsDetails')">내용보기 ▼</button>
					</div>
				</div>
				<div id="termsDetails" class="details">
					이용약관의 상세 내용이 여기에 표시됩니다.
				</div>

				<div class="checkbox-container">
					<div class="signup-checkbox-group">
						<input type="checkbox" id="privacy" name="privacy">
						<label for="privacy">개인정보 수집, 이용에 동의합니다.</label>
					</div>
					<div class="signup-checkbox-button">
						<button type="button" onclick="toggleDetails('privacyDetails')">내용보기 ▼</button>
					</div>
				</div>
				<div id="privacyDetails" class="details">
					개인정보 수집 및 이용에 대한 상세 내용이 여기에 표시됩니다.
				</div>
				
				<div class="checkbox-container checkbox-minor">
					<div class="signup-checkbox-group">
						<input type="checkbox" id="minor" name="minor"> 
						<label class="minor" for="minor">미성년자는 법정대리인의 동의를 받은 후 이용이 가능합니다.</label>
					</div>
				</div>

				<!-- 체크박스 오류 메시지 -->
				<div class="error-message" id="err-checkbox"></div>
				<button type="submit" class="signup-btn">회원가입</button>
			</form>
		</div>
	</div>
</div>

<script>
	//회원가입 필드 검사
	function chkName() {
    	var name = $("#name").val().trim();
    	
	    if (!name) {
	        $("#err-name").html("<span class='error'>이름이 입력되지 않았습니다.</span>")
	        return false;
	    } else {
	        $("#err-name").html("");
	        return true;
	    }
	}

	function chkId() {
		var userid = $("#userid").val().trim();
		
		if (!userid) {
			$("#err-id").html("<span class='error'>아이디가 입력되지 않았습니다.</span>");
			$("#userid").focus();
			return false;
		}
		
		$.ajax({
			type : 'post',
			url : "/member/useridcheck.do",
			data : {userid : $("#userid").val()},
			success : function(response) {
				var result = parseInt(response.trim());
				if (result === -1) {
					$("#err-id").html("<span class='success'>사용 가능한 아이디입니다.</span>");
				} else {
					$("#err-id").html("<span class='error'>사용할 수 없는 아이디입니다.</span>");
					$("#userid").val("");
				}
			}, error : function() {
				alert("통신 에러");
			}
		});
		return ($("#err-id").text().indexOf("사용 가능한") !== -1);
	}

	function chkPwd() {
		var pwd = $("#password").val().trim();
		
		if (!pwd) {
			$("#err-pwd").html("<span class='error'>비밀번호가 입력되지 않았습니다.</span>");
			return false;
		} else {
			$("#err-pwd").html("");
			return true;
		}
	}

	function chkPwdC() {
		var pwd = $("#password").val().trim();
		var pwdC = $("#passwordConfirm").val().trim();
		
		if (!pwdC) {
			$("#err-pwdc").html("<span class='error'>비밀번호 확인이 입력되지 않았습니다.</span>");
			return false;
		} else if (pwd !== pwdC) {
			$("#err-pwdc").html("<span class='error'>비밀번호가 일치하지 않습니다.</span>");
			return false;
		} else {
			$("#err-pwdc").html("");
			return true;
		}
	}

	function chkPhone() {
		var phonenumber = $("#phonenumber").val().trim();
		
		if (!phonenumber) {
			$("#err-phonenumber").html("<span class='error'>전화번호는 필수 정보입니다.</span>");
			return false;
		} else {
			$("#err-phonenumber").html("");
			return true;
		}
	}

	// 주소 찾기 버튼 클릭 시 동작
	document.getElementById("findAddressBtn").addEventListener("click", function() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById("address").value = data.address; // 주소 입력
				}
			}).open();
		});
	
	function chkAddr() {
		var addr = $("#address").val().trim();
		
		if (!addr) {
			$("#err-addr").html("<span class='error'>주소는 필수 정보입니다.</span>");
			return false;
		} else {
			$("#err-addr").html("");
			return true;
		}
	}

	function getFullEmail() {
		var emailPrefix = $("#emailPrefix").val().trim();
		var emailDomain = $("#emailDomain").val();
		var customEmailDomain = $("#customEmailDomain").val().trim();

		if (!emailPrefix) {
			$("#err-email").html("<span class='error-email'>이메일 아이디를 입력해주세요.</span>");
			return null;
		}

		if (emailDomain === "custom") {
			if (!customEmailDomain) {
				$("#err-email").html("<span class='error-email'>이메일 도메인을 입력해주세요.</span>");
				return null;
			}
		return emailPrefix + "@" + customEmailDomain;
		
		} else {
			if (!emailDomain) {
				$("#err-email").html("<span class='error-email'>이메일 도메인을 선택해주세요.</span>");
				return null;
			}
			
		return emailPrefix + "@" + emailDomain;
		
		}
	}

	// 이메일 도메인 선택 시 직접 입력 필드 보이기/숨기기
	$("#emailDomain").change(function() {
		var customInput = $("#customEmailDomain");
		
		if ($(this).val() === "custom") {
			customInput.show().prop("required", true).prop("disabled", false);
		} else {
			customInput.hide().prop("required", false).prop("disabled", true).val("");
		}
	});

	// 이메일 인증 요청
	$("#sendEmailBtn").click(function() {
		var email = getFullEmail();
		
		if (!email) {
			return;
		}

		$("#err-email").html("");

		$.ajax({
			type : "POST",
			url : "/member/sendEmail.do",
			data : { email : email },
			success : function(response) {
				if (response.trim() !== "이메일 전송 실패") {
					receivedAuthCode = response.trim(); // 서버에서 받은 인증 코드 저장
					alert("인증 코드가 이메일로 전송되었습니다.");
				} else {
					alert("이메일 전송에 실패했습니다.");
				}
			},
			error : function() {
				alert("서버와 통신 중 오류가 발생했습니다.");
			}
		});
	});

	// 인증 코드 확인 (서버 검증 없이 클라이언트에서만 체크)
	$("#verifyCodeBtn").click(function() {
		
		var inputCode = $("#authCode").val().trim();
		
		if (!inputCode) {
			$("#err-code").html("<span class='error-code'>인증 코드를 입력해주세요.</span>");
			return;
		}

		if (inputCode === receivedAuthCode) {
			alert("이메일 인증이 완료되었습니다!");
			$("#authCode").prop("disabled", true); // 인증 성공 시 입력 필드 비활성화
		} else {
			alert("인증 코드가 일치하지 않습니다.");
		}
	});

	// 회원가입 시 이메일 입력 확인
	function chkEmail() {
		var email = getFullEmail();
		
		if (!email) {
			return false;
		}
		$("#err-email").html("");
		return true;
	}

	function chkCheckboxes() {
		if (!$("#terms").prop("checked") || !$("#privacy").prop("checked") || !$("#minor").prop("checked")) {
			$("#err-checkbox").html("<span class='error-checkbox'>모든 약관에 동의해야 합니다.</span>");
			return false;
		} else {
			$("#err-checkbox").html("");
			return true;
		}
	}
	
	// 약관 내용 토글 함수
	function toggleDetails(id) {
		var details = document.getElementById(id);
		if (details.style.display === "none" || details.style.display === "") {
			details.style.display = "block";
		} else {
			details.style.display = "none";
		}
	}

	$(function() {
		$("#name").on("blur", chkName);
		$("#userid").on("blur", chkId);
		$("#password").on("blur", chkPwd);
		$("#passwordConfirm").on("blur", chkPwdC);
		$("#phonenumber").on("blur", chkPhone);
		$("#address").on("blur", chkAddr);
		$("#email").on("blur", chkEmail);
 	
		$("#signupForm").submit(function(e) {
			
			var valid = true;
			
			if (!chkName())
				valid = false;
			if (!chkId())
				valid = false;
			if (!chkPwd())
				valid = false;
			if (!chkPwdC())
				valid = false;
			if (!chkPhone())
				valid = false;
			if (!chkAddr())
				valid = false;
			if (!chkEmail())
				valid = false;
			if (!chkCheckboxes())
				valid = false;
	
			if (!valid) {
				e.preventDefault();
			}
		});
	});
</script>
    
<%@ include file="../fragments/footer.jsp" %>