<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/loginsignup.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<div class="FP-sign">
    <h2 class="FP-title">비밀번호 재설정 요청</h2>
    
    <!-- Step 1: 아이디 입력 및 확인 -->
    <div id="FP-id-form">
        <label for="userid">아이디:</label>
        <input type="text" id="userid" name="userid" placeholder="아이디 입력" required>
        <button type="button" id="checkUserId">아이디 확인</button>
        <span id="id-error" class="error-message"></span>
    </div>
    
    <!-- Step 2: 이메일 입력 및 인증 코드 발송 -->
    <div id="email-form" style="display: none;">
        <label for="email">이메일:</label>
        <div class="email-container">
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
        <button type="button" id="verifyEmail">이메일 인증</button>
        <span id="email-error" class="error-message"></span>
    </div>
    
    <!-- Step 3: 인증 코드 입력 -->
    <div id="auth-form" style="display: none;">
        <label for="authCode">인증 코드:</label>
        <input type="text" id="authCode" name="authCode" placeholder="인증 코드 입력" required>
        <button type="button" id="verifyAuthCode">인증 코드 확인</button>
        <span id="auth-error" class="error-message"></span>
    </div>
    
    <!-- Step 4: 재설정 링크 전송 요청 -->
    <div id="send-link-form" style="display: none;">
        <button type="button" id="sendResetLink">비밀번호 재설정 링크 전송</button>
        <span id="link-msg" class="success-message"></span>
    </div>
</div>

<script>
$(document).ready(function(){
    // 도메인 선택 시 직접 입력 필드 토글
    $("#emailDomain").change(function(){
        if($(this).val() === "custom"){
            $("#customEmailDomain").show().prop("required", true).prop("disabled", false);
        } else {
            $("#customEmailDomain").hide().prop("required", false).prop("disabled", true).val("");
        }
    });

    // Step 1: 아이디 확인
    $("#checkUserId").click(function(){
        $("#id-error").text("");
        var userid = $("#userid").val();
        if(!userid){
            $("#id-error").text("아이디를 입력해주세요.");
            return;
        }
        $.post("/member/findPwId.do", { userid: userid }, function(response){
            var trimmed = response.trim();
            if(trimmed === "success"){
                alert("아이디가 확인되었습니다.");
                $("#id-form").hide();
                $("#email-form").show();
            } else {
                $("#id-error").text(trimmed);
            }
        });
    });

    // 함수: 전체 이메일 주소 조합
    function getFullEmail(){
        var emailPrefix = $("#emailPrefix").val();
        var emailDomain = $("#emailDomain").val();
        var customDomain = $("#customEmailDomain").val();
        if(!emailPrefix) return null;
        if(emailDomain === "custom"){
            if(!customDomain) return null;
            return emailPrefix + "@" + customDomain;
        } else {
            if(!emailDomain) return null;
            return emailPrefix + "@" + emailDomain;
        }
    }

    // Step 2: 이메일 인증 (아이디와 이메일 검증 후 인증 코드 발송)
    $("#verifyEmail").click(function(){
        $("#email-error").text("");
        var userid = $("#userid").val();
        var email = getFullEmail();
        if(!email){
            $("#email-error").text("이메일을 정확히 입력해주세요.");
            return;
        }
        $.post("/member/findPwEmail.do", { userid: userid, email: email }, function(response){
            var trimmed = response.trim();
            if(trimmed === "success"){
                alert("인증 코드가 이메일로 전송되었습니다.");
                $("#email-form").hide();
                $("#auth-form").show();
            } else {
                $("#email-error").text(trimmed);
            }
        });
    });

    // Step 3: 인증 코드 확인
    $("#verifyAuthCode").click(function(){
        $("#auth-error").text("");
        var authCode = $("#authCode").val();
        if(!authCode){
            $("#auth-error").text("인증 코드를 입력해주세요.");
            return;
        }
        $.post("/member/findPwCode.do", { authCode: authCode }, function(response){
            var trimmed = response.trim();
            if(trimmed === "success"){
                alert("이메일 인증이 완료되었습니다.");
                $("#auth-form").hide();
                $("#send-link-form").show();
            } else {
                $("#auth-error").text(trimmed);
            }
        });
    });

    // Step 4: 재설정 링크 전송
    $("#sendResetLink").click(function(){
        $.post("/member/findPwToken.do", {}, function(response){
            var trimmed = response.trim();
            $("#link-msg").text(trimmed);
        });
    });
});
</script>

<%@ include file="/fragments/footer.jsp" %>
