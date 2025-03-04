<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fragments/header.jsp" %>
<link rel="stylesheet" href="/css/loginsignup.css">
  
<div class="signup-page">
	<div class="signup-container">
		<div class="signup-sign">
			<h2 class="signup-high-T">Sign-Up</h2>
		</div>
		<div class="signup-part">
			<form id="signupForm" action="/member/signuppro.do" method="post">
		        <div class="signup-form-group">
		            <label for="name">이름</label>
	            	<input type="text" id="name" name="name" placeholder="이름(실명)을 입력하세요." required>
		        </div>
		        <div class="signup-form-group">
		            <label for="username">닉네임</label>
		            <input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력하세요." required>
		        </div>
		        <div class="signup-form-group">
		            <label for="username">아이디</label>
		            <input type="text" id="user_id" name="user_id" placeholder="아이디를 입력하세요." required>
		        </div>
		        <div class="signup-form-group">
		            <label for="password">비밀번호</label>
		            <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요." maxlength="25" required>
		        </div>
		        <div class="signup-form-group">
		            <label for="passwordConfirm">비밀번호 확인</label>
		            <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호를 확인해주세요." maxlength="25" required>
		        </div>
		        <p id="OneSignUpMsg"></p>
		        <div class="signup-form-group">
		            <label for="phone">전화번호</label>
		            <input type="text" id="phone" name="phone" placeholder="전화번호를 입력해주세요." required>
		        </div>
		        <div class="signup-form-group">
		            <label for="phone">주소</label>
		            <input type="text" id="address" name="address" placeholder="주소를 입력해주세요." required>
		        </div>
		        <div class="signup-form-group">
		            <label for="email">이메일</label>
		            <input type="email" id="email" name="email" placeholder="이메일을 입력해주세요." required>
		        </div>
		        <p id="TwoSignUpMsg"></p>
		        <div class="checkbox-container">
		            <!-- 이용약관 동의 -->
			        <div class="signup-checkbox-group">
			            <input type="checkbox" id="terms" name="terms" required>
			            <label for="terms">이용약관에 동의합니다.</label>
			            <button type="button" class="details-btn" onclick="toggleDetails('termsDetails')">내용보기 ▼</button>
			        </div>
			        <div id="termsDetails" class="details">이용약관의 상세 내용이 여기에 표시됩니다.</div>
			        
			        <!-- 개인정보 수집 및 이용 동의 -->
			        <div class="signup-checkbox-group">
			            <input type="checkbox" id="privacy" name="privacy" required>
			            <label for="privacy">개인정보 수집, 이용에 동의합니다.</label>
			            <button type="button" class="details-btn" onclick="toggleDetails('privacyDetails')">내용보기 ▼</button>
			        </div>
			        <div id="privacyDetails" class="details">개인정보 수집 및 이용에 대한 상세 내용이 여기에 표시됩니다.</div>
			        
			        <!-- 미성년자 이용 동의 -->
		            <div class="signup-checkbox-group">
		                <input type="checkbox" id="minor" name="minor">
		                <label for="minor">미성년자는 법정대리인의 동의를 받은 후 이용이 가능합니다.</label>
		            </div>
		        </div>
		        <button type="submit" class="signup-btn">회원가입</button>
		    </form>
	    </div>
	</div>
</div>
<script>
	// 약관 내용 토글 함수
    function toggleDetails(id) {
        var details = document.getElementById(id);
        if (details.style.display === "none" || details.style.display === "") {
            details.style.display = "block";
        } else {
            details.style.display = "none";
        }
    }


    // 그룹1 유효성 즉시 검사 함수 
    function updateGroup1() {
        var errors = "";

        if (!$("#name").val().trim()) {
            errors += "<span class='error'> 이름: 필수 정보입니다.<br></span>";
        }
        // 아이디 선택자 수정: $("#user_id") 사용
        if (!$("#user_id").val().trim()) {
            errors += "<span class='error'> 아이디: 필수 정보입니다.<br></span>";
        }

        if (!$("#password").val().trim()) {
            errors += "<span class='error'>비밀번호: 필수 정보입니다<br></span>";
        }

        if ($("#password").val().length > 25) {
            errors += "<span class='error'>비밀번호: 최대 25자까지 입력할 수 있습니다.<br></span>";
        }
        
        if (!$("#passwordConfirm").val().trim()) {
            errors += "<span class='error'>비밀번호 확인: 필수 입력사항입니다.<br></span>";
        } else if ($("#password").val().trim() && $("#passwordConfirm").val().trim() &&
                   $("#password").val() !== $("#passwordConfirm").val()) {
            errors += "<span class='error'>비밀번호가 일치하지 않습니다.<br></span>";
        }

        $("#OneSignUpMsg").html(errors);
    } // updateGroup1()

	// 그룹2의 즉각 피드백 업데이트 함수
    function updateGroup2() {
        var errors = "";
        
        if(!$("#phone").val().trim()){
            errors += "<span class='error'>전화번호: 필수 정보입니다.<br></span>";
        }
        if(!$("#address").val().trim()){
            errors += "<span class='error'>주소: 필수 정보입니다.<br></span>";
        }
        if(!$("#email").val().trim()){
            errors += "<span class='error'>이메일: 필수 정보입니다.<br></span>";
        }
        
        $("#TwoSignUpMsg").html(errors);
    }

    $(document).ready(function(){
        // 그룹1 필드: name, password, passwordConfirm
        $("#name, #password, #passwordConfirm").on("blur keyup", function(){
            updateGroup1();
        });
        
        $("#user_id").on("blur", function(){
            if (!$("#user_id").val().trim()) {
                updateGroup1();
                $("#user_id").focus();
                return;
            }
            $.ajax({
                type: 'post',
                url: "/member/useridcheck.do",
                data: { user_id: $("#user_id").val().trim() },  // 공백 제거
                success: function(response) {
                    var result = parseInt(response.trim());
                    var msg = "";
                    if (result === -1) { // 사용 가능
                        msg = "<span class='success'>아이디: 사용가능한 아이디입니다.<br></span>";
                    } else { // 이미 존재
                        msg = "<span class='error'>아이디: 사용할 수 없는 아이디입니다.<br></span>";
                        $("#user_id").val("");
                        $("#user_id").focus();
                    }
                    $("#OneSignUpMsg").html(msg);
                },
                error: function() {
                    alert("통신 에러");
                }
            });
        });

        
        // 그룹2 필드: phone, address, email
        $("#phone, #address, #email").on("blur keyup", function(){
            updateGroup2();
        });
        
        // 폼 제출 시 최종 체크 (두 그룹 모두 에러가 없을 때만 제출)
        $("#signupForm").submit(function(e){
            updateGroup1();
            updateGroup2();
         // 에러 메시지가 있을 경우 제출 취소
            if($("#OneSignUpMsg").html() !== "" || $("#TwoSignUpMsg").html() !== ""){
                e.preventDefault();
            }	    	
        })
    })
</script>

    
<%@ include file="../fragments/footer.jsp" %>