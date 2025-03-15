<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/mypage.css">


<body>
<div id="mypage">
    <!-- 1) 상단 프로필 영역 -->
    <div class="mypage-container">
        <div class="profile-top-container">
            <!-- 왼쪽: 프로필 이미지 + 사용자명 + 버튼 -->
            <div class="profile-info">
                <div class="username">${sessionScope.user.name}님, 반가워요!</div>
                <div class="profile-buttons">
                    <!-- 작가 등록 버튼 (폼 분리) -->
                    <form action="/member/authorinsert.do" method="get" style="display:inline;">
                        <button type="submit" class="auth-btn">작가등록</button>
                    </form>

                    <!-- 회원 정보 수정 -->
                    <button class="info-btn" onclick="location.href='/admin/editProfile.do'">
                        회원정보
                    </button>

                    <!-- 비밀번호 수정 -->
                    <button class="logout-btn" onclick="location.href='/member/updateMyPw.do'">
                        비밀번호 수정
                    </button>
                </div>
            </div>

            <!-- 오른쪽: 통계 정보 (예시) -->
            <div class="profile-right">
                <div class="status-box">
                    <div class="item">
                        <div class="count">0</div>
                        <div class="desc">최근 주문/배송중</div>
                    </div>
                    <div class="item">
                        <div class="count">0</div>
                        <div class="desc">작성한 리뷰</div>
                    </div>
                    <div class="item">
                        <div class="count">0</div>
                        <div class="desc">좋아요 한 상품</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    		
    <!-- 우측 메인 컨텐츠: 새 비밀번호 입력 -->
    <div id="mypage-pw">
        <form id="UpdatePwForm" action="/member/updateMyPwPro.do" method="post" novalidate>
            <div id="myInfo-page">
                <!-- 새 비밀번호 입력 필드 -->
                <div class="signup-form-group">
                    <label for="newPassword">새 비밀번호</label>
                    <input type="password"
                           id="newPassword"
                           name="newPassword"
                           placeholder="새 비밀번호 입력"
                           maxlength="25" required>
                    <span class="error-message" id="err-newPwd"></span>
                </div>
                <div class="signup-form-group">
                    <label for="passwordConfirm">비밀번호 확인</label>
                    <input type="password"
                           id="passwordConfirm"
                           name="passwordConfirm"
                           placeholder="비밀번호 확인"
                           maxlength="25" required>
                    <span class="error-message" id="err-pwdc"></span>
                </div>
                <div id="mypage-submit-btns">
                    <button type="submit" id="mypage-submit-btn">수정하기</button>
                    <button type="button" id="mypage-cancel-btn"
                            onclick="location.href='/member/mypage.do';">
                        취소
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    $(document).ready(function(){
        var $newPwd = $("#newPassword"),
            $pwdConfirm = $("#passwordConfirm"),
            $errNewPwd = $("#err-newPwd"),
            $errPwdc = $("#err-pwdc"),
            $updatePwForm = $("#UpdatePwForm");

        // 300ms 지연 후 입력값 유효성 검사
        var validateTimeout;
        function asyncValidatePasswords() {
            clearTimeout(validateTimeout);
            validateTimeout = setTimeout(function(){
                var newPwd = $newPwd.val().trim();
                var cpwd = $pwdConfirm.val().trim();
                
                // 새 비밀번호: 공백 체크
                if(newPwd === "") {
                    $errNewPwd.html("새 비밀번호를 입력해 주세요!");
                } else {
                    $errNewPwd.html("");
                }
                
                // 비밀번호 확인: 새 비밀번호와 일치 여부 확인
                if(cpwd !== "" && newPwd !== cpwd){
                    $errPwdc.html("비밀번호가 일치하지 않습니다.");
                } else {
                    $errPwdc.html("");
                }
            }, 300);
        }
        
        $newPwd.on("keyup blur", asyncValidatePasswords);
        $pwdConfirm.on("keyup blur", asyncValidatePasswords);
        
        // 폼 제출 시 최종 유효성 검사
        $updatePwForm.on("submit", function(e){
            var newPwd = $newPwd.val().trim();
            var cpwd = $pwdConfirm.val().trim();
            
            if(newPwd === "" || cpwd === ""){
                e.preventDefault();
                alert("모든 필드를 입력해 주세요.");
                return;
            }
            if(newPwd !== cpwd){
                e.preventDefault();
                alert("새 비밀번호와 확인이 일치하지 않습니다.");
                return;
            }
        });
        
        // 서버에서 전달된 결과 메시지 (페이지 리로딩 후)
        <% 
            String updateResult = (String) request.getAttribute("updateResult");
            String errorMsg = (String) request.getAttribute("errorMsg");
            if(updateResult != null) { 
        %>
            var updateResult = '<%= updateResult %>';
            var errorMsg = '<%= errorMsg != null ? errorMsg : "" %>';
            if(updateResult === "success") {
                alert("비밀번호가 성공적으로 변경되었습니다.");
            } else if(updateResult === "fail") {
                alert("비밀번호 변경에 실패했습니다. " + errorMsg);
            }
        <% } %>
    });
</script>

<%@ include file="../fragments/footer.jsp" %>
