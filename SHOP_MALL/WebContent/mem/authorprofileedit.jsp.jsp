<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ include file="../fragments/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="../css/mypage.css">


<div class="wrapBody">
    <h2>프로필 수정</h2>

    <form action="/admin/updateProfile.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="authorid" value="${sessionScope.user.userid}">

    <div class="form-group">
        <label>작가 이름</label>
        <input type="text" name="authorname" value="${author.authorname}" required>
    </div>

    <div class="form-group">
        <label>작가 소개</label>
        <textarea name="authorinfo" required>${author.authorinfo}</textarea>
    </div>

    <div class="form-group">
        <label>프로필 이미지1</label>
        <input type="file" name="authorimg1" accept="image/*">
    </div>

    <div class="form-group">
        <label>프로필 이미지2</label>
        <input type="file" name="authorimg2" accept="image/*">
    </div>

    <div class="form-group">
        <label>프로필 이미지3</label>
        <input type="file" name="authorimg3" accept="image/*">
    </div>

    <div class="form-group">
        <input type="submit" value="수정하기" class="submit-btn">
    </div>
</form>

</div>

<%@ include file="../fragments/footer.jsp" %>