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
		            <label for="name">名前</label>
		            <input type="text" id="name" name="name" placeholder="名前（本名）を入力してください。" required>
		        </div>
		        <p id="err-name"></p>
		        
		        <div class="signup-form-group">
		            <label for="userid">ID</label>
		            <input type="text" id="userid" name="userid" placeholder="IDを入力してください。" maxlength="20" required>
		        </div>
		        <p id="err-id"></p>
		        
		        <div class="signup-form-group">
		            <label for="password">パスワード</label>
		            <input type="password" id="password" name="password" placeholder="パスワードを入力してください。" maxlength="25" required>
		        </div>
		        <p id="err-pwd"></p>
		        
		        <div class="signup-form-group">
		            <label for="passwordConfirm">パスワード確認</label>
		            <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="パスワードを確認してください。" maxlength="25" required>
		        </div>
		        <p id="err-pwdc"></p>
		        
		        <div class="signup-form-group">
		            <label for="phonenumber">電話番号</label>
		            <input type="text" id="phonenumber" name="phonenumber" placeholder="電話番号を入力してください。" required>
		        </div>
		        <p id="err-phonenumber"></p>
		
		        <div class="signup-form-group-address">
		            <label for="address">住所</label>
		            <div class="signup-address">
		                <input type="text" id="address" name="address" placeholder="住所を入力してください。" required>
		                <button type="button" id="findAddressBtn">住所検索</button>
		            </div>
		            <div class="signup-detailAddress">
		                <input type="text" id="detailAddress" name="detailAddress" placeholder="詳細住所（番地・建物名など）を入力してください。">
		            </div>
		        </div>
		        <p id="err-address"></p>
		        <p id="err-detailAddress"></p>
		
		        <div class="signup-form-group-email">
		            <label for="email">メールアドレス</label>
		            <div class="email-container">
		                <div class="email-container-left">
		                    <input type="text" id="emailPrefix" name="emailPrefix" placeholder="メールID" required>
		                    <span>@</span>
		                    <select id="emailDomain" name="emailDomain">
		                        <option value="" selected>選択してください</option>
		                        <option value="naver.com">naver.com</option>
		                        <option value="gmail.com">gmail.com</option>
		                        <option value="daum.net">daum.net</option>
		                        <option value="icloud.com">icloud.com</option>
		                        <option value="custom">直接入力</option>
		                    </select>
		                    <input type="text" id="customEmailDomain" name="customEmailDomain" placeholder="ドメインを入力" style="display: none;">
		                    <p id="err-email"></p>
		                </div>
		                <div class="email-container-right">
		                    <button type="button" id="sendEmailBtn">メール認証</button>
		                </div>
		            </div>
		        </div>
		
		        <div class="signup-form-group-auth">
		            <div class="signup-auth-left">
		                <label class="authCode" for="authCode">認証コード</label>
		            </div>
		            <div class="signup-auth-right">
		                <input type="text" id="authCode" name="authCode" placeholder="認証コードを入力してください。" required>
		                <button type="button" id="verifyCodeBtn">認証確認</button>
		            </div>
		        </div>
		        <p id="err-code"></p>
		
		        <!-- 利用規約の同意 -->
		        <div class="checkbox-container">
		            <div class="signup-checkbox-group">
		                <input type="checkbox" id="terms" name="terms">
		                <label for="terms">利用規約に同意します。</label>
		            </div>
		            <div class="signup-checkbox-button">
		                <button type="button" onclick="toggleDetails('termsDetails')">内容を見る</button>
		            </div>
		        </div>
		        <div id="termsDetails" class="details">
		            利用規約の詳細内容がここに表示されます。
		        </div>
		
		        <div class="checkbox-container">
		            <div class="signup-checkbox-group">
		                <input type="checkbox" id="privacy" name="privacy">
		                <label for="privacy">個人情報の収集・利用に同意します。</label>
		            </div>
		            <div class="signup-checkbox-button">
		                <button type="button" onclick="toggleDetails('privacyDetails')">内容を見る</button>
		            </div>
		        </div>
		        <div id="privacyDetails" class="details">
		            個人情報の収集・利用に関する詳細内容がここに表示されます。
		        </div>
		        
		        <div class="checkbox-container checkbox-minor">
		            <div class="signup-checkbox-group">
		                <input type="checkbox" id="minor" name="minor"> 
		                <label class="minor" for="minor">未成年者は法定代理人の同意を得た上で利用可能です。</label>
		            </div>
		        </div>
		
		        <!-- チェックボックスのエラーメッセージ -->
		        <div class="error-message" id="err-checkbox"></div>
		        <button type="submit" class="signup-btn">会員登録</button>
		    </form>
		</div>
	</div>
</div>

<script>
	//회원가입 필드 검사
	function chkName() {
    	var name = $("#name").val().trim();
    	
	    if (!name) {
	        $("#err-name").html("<span class='error'>名前が入力されていません。</span>")
	        return false;
	    } else {
	        $("#err-name").html("");
	        return true;
	    }
	}

	function chkId() {
		var userid = $("#userid").val().trim();
		
		if (!userid) {
			$("#err-id").html("<span class='error'>IDが入力されていません。</span>");
			return false;
		}
		
		$.ajax({
			type : 'post',
			url : "/member/useridcheck.do",
			data : {userid : $("#userid").val()},
			success : function(response) {
				var result = parseInt(response.trim());
				if (result === -1) {
					$("#err-id").html("<span class='success'>使用可能なIDです。</span>");
				} else {
					$("#err-id").html("<span class='error'>使用できないIDです。</span>");
					$("#userid").val("");
				}
			}, error : function() {
				alert("通信エラー");
			}
		});
		return ($("#err-id").text().indexOf("使用可能な") !== -1);
	}

	function chkPwd() {
		var pwd = $("#password").val().trim();
		
		if (!pwd) {
			$("#err-pwd").html("<span class='error'>パスワードが入力されていません。</span>");
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
			$("#err-pwdc").html("<span class='error'>パスワード確認が入力されていません。</span>");
			return false;
		} else if (pwd !== pwdC) {
			$("#err-pwdc").html("<span class='error'>パスワードが一致しません。</span>");
			return false;
		} else {
			$("#err-pwdc").html("");
			return true;
		}
	}

	function chkPhone() {
		var phonenumber = $("#phonenumber").val().trim();
		
		if (!phonenumber) {
			$("#err-phonenumber").html("<span class='error'>電話番号が入力されていません。</span>");
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
	
	// 상세 주소 필드 검사
	function chkDetailAddress() {
    	var detailAddress = $("#detailAddress").val().trim();
    	
	    if (!detailAddress) {
	        $("#err-detailAddress").html("<span class='error-detailaddress'>詳細住所が入力されていません。</span>")
	        return false;
	    } else {
	        $("#err-detailAddress").html("");
	        return true;
	    }
	}

	function getFullEmail() {
		var emailPrefix = $("#emailPrefix").val().trim();
		var emailDomain = $("#emailDomain").val();
		var customEmailDomain = $("#customEmailDomain").val().trim();

		if (!emailPrefix) {
			$("#err-email").html("<span class='error-email'>メールIDを入力してください。</span>");
			return null;
		}

		if (emailDomain === "custom") {
			if (!customEmailDomain) {
				$("#err-email").html("<span class='error-email'>メールドメインを入力してください。</span>");
				return null;
			}
		return emailPrefix + "@" + customEmailDomain;
		
		} else {
			if (!emailDomain) {
				$("#err-email").html("<span class='error-email'>メールドメインを選択してください。</span>");
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
				if (response.trim() !== "メール送信失敗") {
					receivedAuthCode = response.trim(); // 서버에서 받은 인증 코드 저장
					alert("認証コードがメールに送信されました。");
				} else {
					alert("メールの送信に失敗しました。");
				}
			},
			error : function() {
				alert("サーバーとの通信中にエラーが発生しました。");
			}
		});
	});

	// 인증 코드 확인 (서버 검증 없이 클라이언트에서만 체크)
	$("#verifyCodeBtn").click(function() {
		
		var inputCode = $("#authCode").val().trim();
		
		if (!inputCode) {
			$("#err-code").html("<span class='error-code'>認証コードを入力してください。</span>");
			return;
		}

		if (inputCode === receivedAuthCode) {
			alert("メール認証が完了しました！");
			$("#err-code").html("");
			$("#authCode").prop("disabled", true); // 인증 성공 시 입력 필드 비활성화
		} else {
			alert("認証コードが一致しません。");
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
			$("#err-checkbox").html("<span class='error-checkbox'>すべての利用規約に同意する必要があります。</span>");
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
		$("#detailAddress").on("blur", chkDetailAddress);
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
			if (!chkDetailAddress())
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