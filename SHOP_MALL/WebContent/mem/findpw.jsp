<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/loginsignup.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<div class="FP-sign">
    <h2 class="FP-high-T">비밀번호 찾기</h2>
    <div id="id-form">
        <label for="userid">아이디:</label>
        <input type="text" id="userid" name="userid" placeholder="아이디 입력" required>
        <button type="button" id="requestReset">비밀번호 재설정 이메일 받기</button>
        <span id="id-error" class="error-message"></span>
    </div>
</div>

<script>
$(document).ready(function() {
    $("#requestReset").click(function() {
        $("#id-error").text("");
        var userid = $("#userid").val();
        if (!userid) {
            $("#id-error").text("아이디를 입력해주세요.");
            return;
        }
        $.post("/member/findPwToken.do", { userid: userid }, function(response) {
            var trimmedResponse = response.trim();
            alert(trimmedResponse);
        });
    });
});
</script>

<%@ include file="/fragments/footer.jsp" %>
