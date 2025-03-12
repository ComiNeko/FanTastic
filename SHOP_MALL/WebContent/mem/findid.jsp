<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/findidpw.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<div class="findID-page">
	<div class="findID-container">
		<div class="findID-sign">
		    <h2 class="findID-high-T">Forgot ID?</h2>
	    </div>
		   
		<div class="findID-part">
		    <div class="findID-form-group-email" id="email-form">
		    	<p class="findID-inform">계정과 연결된 이메일 주소를 입력해주세요. 이메일 주소를 입력하시면, 인증코드를 해당 이메일 주소로 보내드립니다.</p>
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
		        		<button type="button" id="requestAuthCode">인증코드 받기</button>
		        	</div>
		        </div>
		    </div>
		    <p id="err-email"></p>
		
		    <!-- 인증 코드 입력 -->
		    <div class="findID-form-group-auth" id="auth-form" style="display: none;">
		    	<p class="findID-inform">메일함을 확인하신 후, 발송된 인증코드를 입력해 주세요. 인증코드는 2분 뒤에 만료됩니다.</p>
		    	<div class="findID-auth-part">
			    	<div class="findID-auth-left">
			        	<label>인증 코드</label>
			        </div>
			        <div class="findID-auth-right">
				        <input type="text" id="authCode" required>
				        <button type="button" id="verifyCode">인증하기</button>
			        </div>
		        </div>
		        <p id="err-auth"></p>
		    </div>
		
		    <!-- 아이디 결과 -->
		    <div class="findID-form-group-result" id="id-result" style="display: none;">
		    	<p class="findID-result-inform">귀하의 아이디 정보입니다.</p>
		    	<div class="findID-result-part">
			    	<div class="findID-result-left">
			        	<label>아이디</label>
			        </div>
			        <div class="findID-result-right">
			        	<p id="maskedUserId"></p>
			        </div>
		        </div>
		        <div class="findID-result-buttons">
			        <button type="button" onclick="location.href='/member/findPw.do'">비밀번호 찾기</button>
				    <button type="button" onclick="location.href='/member/login.do'">로그인</button>
			    </div>
		    </div>
	    </div>
    </div>
</div>

<script>
$(document).ready(function () {
    // 이메일 입력 필드 조합 함수
    function getFullEmail() {
        var emailPrefix = $("#emailPrefix").val().trim();
        var emailDomain = $("#emailDomain").val();
        var customEmailDomain = $("#customEmailDomain").val().trim();

        if (!emailPrefix) {
            $("#err-email").html("<span class='error'>이메일 아이디를 입력해주세요.</span>");
            return null;
        } else {
        	$("#err-email").html("");
        }

        if (emailDomain === "custom") {
            if (!customEmailDomain) {
                $("#err-email").html("<span class='error'>이메일 도메인을 입력해주세요.</span>");
                return null;
            } else {
            	$("#err-email").html("");
            	return emailPrefix + "@" + customEmailDomain;
            }
        } else {
            if (!emailDomain) {
                $("#err-email").html("<span class='error'>이메일 도메인을 선택해주세요.</span>");
                return null;
            } else {
            	$("#err-email").html("");
          		return emailPrefix + "@" + emailDomain;
            }
        }
    }

    // 이메일 도메인 선택 시 직접 입력 필드 활성화/비활성화
    $("#emailDomain").change(function() {
        if ($(this).val() === "custom") {
            $("#customEmailDomain").show().prop("required", true).prop("disabled", false);
        } else {
            $("#customEmailDomain").hide().prop("required", false).prop("disabled", true).val("");
        }
    });

    // 이메일 인증 요청 (아이디 찾기)
    $("#requestAuthCode").click(function () {
        // 에러 메시지 초기화
        $("#err-email").text("");
        var email = getFullEmail();
        console.log("DEBUG - final email:", email);
        if (!email) return;

        $.post("/member/findIdProcess.do", { email: email }, function (response) {
            var trimmedResponse = response.trim();
            // 성공 메시지인 경우에만 인증 단계로 넘어감
            if (trimmedResponse === "인증 코드가 이메일로 전송되었습니다.") {
                alert("인증 코드가 이메일로 전송되었습니다.");
                $("#email-form").hide();
                $("#auth-form").show();
            } else {
                // 그 외는 모두 에러 메시지로 처리
                $("#err-email").html("<span class='error'>" + trimmedResponse + "</span>");
            }
        });
    });

    // 인증 코드 확인
    $("#verifyCode").click(function () {
        $("#err-auth").text("");
        var authCode = $("#authCode").val().trim();
        if (!authCode) {
            $("#err-auth").html("<span class='error-auth'>인증 코드를 입력해주세요.</span>");
            return;
        }

        $.post("/member/verifyEmail.do", { authCode: authCode }, function (response) {
            var trimmedResponse = response.trim();
            
            if (trimmedResponse.startsWith("success:")) {
                var userId = trimmedResponse.split(":")[1];
                $("#maskedUserId").html("<span>" + userId + "</span>");
                $("#auth-form").hide();
                $("#id-result").show();
            }  else {
                // 서버에서 온 메시지를 <p id="err-auth">에 출력
                $("#err-auth").html("<span class='error-auth'>" + trimmedResponse + "</span>");
            }
        });
    });

});
</script>



<%@ include file="/fragments/footer.jsp"%>