<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/loginsignup.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<%
    // 🔥 JSP에서 token 값을 제대로 받아오는지 디버깅
    String token = request.getParameter("token");
%>

<!-- 🚨 디버깅 메시지: token 값이 JSP에서 제대로 들어오는지 확인 -->
<h2 style="color:blue;">JSP에서 받은 토큰: <%= (token == null || token.isEmpty()) ? "토큰 없음" : token %></h2>

<!-- 🔴 토큰이 없을 경우 메시지 출력 -->
<%
    if (token == null || token.isEmpty()) {
        out.println("<h2 style='color:red;'>토큰이 없습니다. 올바른 링크를 사용해주세요.</h2>");
        return;
    }
%>

<div class="RP-reset">
    <h2 class="RP-reset-title">새 비밀번호 설정</h2>
    <form id="resetForm">
        <input type="hidden" id="token" name="token" value="<%= token %>">
        <label for="newPassword">새 비밀번호:</label>
        <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
        <label for="confirmPassword">비밀번호 확인:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
        <button type="button" id="resetPassword">비밀번호 재설정</button>
        <span id="reset-error" class="error-message"></span>
    </form>
</div>

<script>
$(document).ready(function(){
    $("#resetPassword").click(function(){
        $("#reset-error").text("");
        var token = $("#token").val();
        var newPassword = $("#newPassword").val();
        var confirmPassword = $("#confirmPassword").val();

        // 🚨 디버깅: AJAX 요청 전에 token 값을 콘솔에서 확인
        console.log("전송할 데이터:", { token, newPassword, confirmPassword });

        if(!newPassword || !confirmPassword){
            $("#reset-error").text("비밀번호 재설정을 위해 모두 입력해주세요.");
            return;
        }

        $.post("/member/resetPw.do", 
            { token: token, newPassword: newPassword, confirmPassword: confirmPassword },
            function(response){
                var trimmed = response.trim();
                console.log("서버 응답:", trimmed); // 서버 응답 디버깅
                if(trimmed.indexOf("성공적으로 변경되었습니다") !== -1){
                    alert(trimmed);
                    window.location.href = "/member/login.do";
                } else {
                    $("#reset-error").text(trimmed);
                }
            }
        );
    });
});
</script>


<%@ include file="/fragments/footer.jsp" %>
