<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/MyP.css">


<head>
    <meta charset="UTF-8">
    <title>정보수정</title>
</head>

<body>
<form action="<c:url value='/member/updateMyPwPro.do'/>" method="post">
    <!-- 최상위 래퍼 -->
    <div id="myInfo-page">
        
        <!-- 비밀번호 -->
        <div class="form-row">
            <label for="newPassword">비밀번호</label>
            <input type="password"
                   id="newPassword"
                   name="newPassword"
                   placeholder="변경 시 새 비밀번호 입력" maxlength="25">
        </div>
        <div class="form-row">
            <label for="confirmNewPassword">비밀번호 확인</label>
            <input type="password"
                   id="confirmNewPassword"
                   name="confirmNewPassword"
                   placeholder="새 비밀번호 확인" maxlength="25">
        </div>
        
        <!-- 버튼 그룹 -->
        <div id="mypage-submit-btns">
            <button type="submit" id="mypage-submit-btn">수정하기</button>
            <button type="button" id="mypage-cancel-btn"
                    onclick="location.href='${pageContext.request.contextPath}/member/mypage.do';">
                취소
            </button>
        </div>
       
    </div>
</form>
</body>
<script>
    // "수정하기" 버튼 클릭 시 유효성 검사 수행
    document.getElementById("mypage-submit-btn").addEventListener("click", function(e) {
        var newPwd = document.getElementById("newPassword").value.trim();
        var confirmPwd = document.getElementById("confirmNewPassword").value.trim();

        // 새 비밀번호가 입력되지 않았으면 경고 후 제출 중단
        if(newPwd === "") {
            alert("새 비밀번호를 입력해 주세요.");
            e.preventDefault();
            return;
        }
        // 비밀번호 확인 입력이 없으면 경고 후 제출 중단
        if(confirmPwd === "") {
            alert("비밀번호 확인을 입력해 주세요.");
            e.preventDefault();
            return;
        }
        // 두 필드 값이 다르면 경고 후 제출 중단
        if(newPwd !== confirmPwd) {
            alert("비밀번호와 확인이 일치하지 않습니다.");
            e.preventDefault();
            return;
        }
    });
    
    <% 
    	String updateResult = (String) request.getAttribute("updateResult");
   		String errorMsg = (String) request.getAttribute("errorMsg");
    	if(updateResult != null) { 
	%>
		var updateResult = "<%= updateResult %>";
		var errorMsg = "<%= errorMsg != null ? errorMsg : "" %>";
		if(updateResult === "success") {
    		alert("비밀번호가 성공적으로 변경되었습니다.");
    		// 또는 메시지 영역에 표시하려면:
    		// document.getElementById("message").innerHTML = "<p style='color:green;'>비밀번호가 성공적으로 변경되었습니다.</p>";
		} else if(updateResult === "fail") {
   		 	alert("비밀번호 변경에 실패했습니다. " + errorMsg);
    		// 또는 메시지 영역에 표시하려면:
    		// document.getElementById("message").innerHTML = "<p style='color:red;'>비밀번호 변경에 실패했습니다. " + errorMsg + "</p>";
		}
	<% } %>
    
</script>

<%@ include file="../fragments/footer.jsp" %>