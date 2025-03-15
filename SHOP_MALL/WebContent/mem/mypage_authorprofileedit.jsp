<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>

<link rel="stylesheet" href="../css/profileedit.css">

<script>
	function check() {
	    if (my.authorname.value.length > 20) {
	        alert("작가 이름은 20자 이하로 입력해야 합니다.");
	        my.authorname.value.focus();
	        return false; // 폼 제출 방지
	    }
	    if (my.authorinfo.value.length > 255) {
	    	alert("소개문은 255자 이하로 입력해주세요.");
	    	my.authorinfo.value.focus();
	    	return false;
	    }
	    return true; // 정상 제출
	}
</script>
<section class="author-profile-edit-page">
	<h2>프로필 수정</h2>
	<form name="my" action="/admin/updateProfile.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
		
		<!-- 반드시 authorid가 form에 포함되어야 update 가능 -->
		<input type="hidden" name="authorid" value="${author.authorid}">
		<div class="form-group">
			<label>작가 이름</label> <input type="text" name="authorname" value="${author.authorname}" required>
		</div>

		<div class="form-group">
			<label>작가 소개</label>
			<textarea name="authorinfo" required>${author.authorinfo}</textarea>
		</div>

		<div class="form-group">
			<label>프로필 이미지1</label> <input type="file" name="authorimg1" accept="image/*">
		</div>

		<div class="form-group">
			<label>프로필 이미지2</label> <input type="file" name="authorimg2" accept="image/*">
		</div>

		<div class="form-group">
			<label>프로필 이미지3</label> <input type="file" name="authorimg3" accept="image/*">
		</div>

		<div class="form-group">
			<input type="submit" value="수정하기" class="submit-btn">
		</div>
	</form>
</section>

<%@ include file="../fragments/footer.jsp" %>