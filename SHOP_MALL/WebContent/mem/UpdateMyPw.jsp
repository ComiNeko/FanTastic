<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/MyP.css">


<body>
<div id="mypage-container">
    <!-- 좌측 사이드바 -->
    <div id="mypage-sidebar">
        <h3>마이페이지</h3>
        <ul>
            <li><a href="/member/orders.do">구매내역</a></li>
            <li><a href="/member/wishlist.do">좋아요</a></li>
            <li><a href="/member/cart.do">장바구니</a></li>
            <li><a href="/member/points.do">최근 본 상품</a></li>
            <li><a href="/member/reviews.do">レビュー</a></li>
        </ul>
    </div>
    <div id="mypage-sidebar">
        <ul>
            <li><a href="/member/updateMyInfo.do">계정 설정</a></li>
            <li><a href="/member/updateMyPw.do">비밀번호 변경</a></li>
        </ul>
    </div>
    		
    		<!-- 우측 메인 컨텐츠 -->
    		<div id="mypage-content">
				<form id="UpdatePwForm" action="/member/updateMyPwPro.do" method="post" novalidate>
				    <div id="myInfo-page">
				        <div class="signup-form-group">
				            <label for="newPassword">비밀번호</label>
				            <input type="password"
				                   id="newPassword"
				                   name="newPassword"
				                   placeholder="변경 시 새 비밀번호 입력"
				                   maxlength="25" required>
				        </div>
				        <div class="signup-form-group">
				            <label for="passwordConfirm">비밀번호 확인</label>
				            <input type="password"
				                   id="passwordConfirm"
				                   name="passwordConfirm"
				                   placeholder="비밀번호를 확인해주세요."
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

</body>
    
<script>
	$(document).ready(function(){
	    var $newPwd = $("#newPassword"),
	        $pwdConfirm = $("#passwordConfirm"),
	        $errPwdc = $("#err-pwdc"),
	        $updatePwForm = $("#UpdatePwForm");
	    
	    // 입력 도중 300ms 지연 후 유효성 검사 (비동기식 처리)
	    var validateTimeout;
	    function asyncValidatePassword() {
	        clearTimeout(validateTimeout);
	        validateTimeout = setTimeout(function(){
	            var pwd = $newPwd.val().trim();
	            var cpwd = $pwdConfirm.val().trim();
	            
	            // 비밀번호 확인란에만 입력된 경우
	            if(cpwd !== "" && pwd === ""){
	                $errPwdc.html("먼저 비밀번호를 입력해 주세요!");
	            }
	            // 두 필드 모두 입력되었으나 값이 일치하지 않으면
	            else if(pwd !== "" && cpwd !== "" && pwd !== cpwd){
	                $errPwdc.html("비밀번호가 일치하지 않습니다.");
	            } else {
	                $errPwdc.html("");
	            }
	        }, 300);
	    }
	    
		    $newPwd.on("keyup blur", asyncValidatePassword);
		    $pwdConfirm.on("keyup blur", asyncValidatePassword);
		    
		    // 폼 제출 시 최종 유효성 검사
		    $updatePwForm.on("submit", function(e){
		        var pwd = $newPwd.val().trim();
		        var cpwd = $pwdConfirm.val().trim();
		        
		        if(pwd === "" || cpwd === ""){
		            e.preventDefault();
		            alert("모든 필드를 입력해 주세요.");
		            return;
		        }
		        if(pwd !== cpwd){
		            e.preventDefault();
		            alert("비밀번호와 확인이 일치하지 않습니다.");
		            return;
		        }
		    });
	    
			    // 서버에서 전달된 결과 메시지 (동기식 처리 후 페이지 리로딩 시)
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