<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/findpwreset.css">
<script src="../js/jquery-3.7.1.min.js"></script>

<%
    // JSP에서 token 값을 제대로 받아오는지 디버깅
    String token = request.getParameter("token");
%>
<!-- 디버깅 메시지: token 값이 JSP에서 제대로 들어오는지 확인 
<h5 style="color:blue;">JSP에서 받은 토큰: <%= (token == null || token.isEmpty()) ? "토큰 없음" : token %></h5>

 토큰이 없을 경우 메시지 출력 -->
<%
    if (token == null || token.isEmpty()) {
        out.println("<h2 style='color:red;'>토큰이 없습니다. 올바른 링크를 사용해주세요.</h2>");
        return;
    }
%>

<div class="PWReset-page">
	<div class="PWReset-container">
		<div class="PWReset-sign">
			<h2 class="PWReset-high-T">New Password</h2>
		</div>
    	
    	<div class="PWReset-part">
		    <form id="resetForm">
		        <input type="hidden" id="token" name="token" value="<%= token %>">
		        <div class="PWReset-form-group" style="margin-top: 40px; margin-bottom: 10px">
				    <label for="newPassword">새 비밀번호</label>
				    <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
				</div>
		        <div class="PWReset-form-group">
		        	<label for="confirmPassword">새 비밀번호 확인</label>
		        	<input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
	        	</div>
	        	<p id="err-reset"></p>
	        	<div class="PWReset-button">
		        	<button type="button" id="resetPassword">비밀번호 재설정</button>
	        	</div>
		    </form>
	    </div>
    </div>
</div>

<script>
$(document).ready(function(){
    $("#resetPassword").click(function(){
        $("#err-reset").text("");
        var token = $("#token").val();
        var newPassword = $("#newPassword").val();
        var confirmPassword = $("#confirmPassword").val();

        // 🚨 디버깅: AJAX 요청 전에 token 값을 콘솔에서 확인
        console.log("전송할 데이터:", { token, newPassword, confirmPassword });

        if(!newPassword || !confirmPassword){
            $("#err-reset").html("<span class='error'>모두 입력해주세요.</span>");
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
                    $("#err-reset").html("<span class='error'>" + trimmed + "</span>");
                }
            }
        );
    });
});
</script>


<%@ include file="/fragments/footer.jsp" %>
