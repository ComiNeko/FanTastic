<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Model.MemberVo" %>
<%@ page session="true" %>

<%
    MemberVo user = (MemberVo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("/member/login.do");
        return;
    }
%>

<h2>작가 등록</h2>

<form action="/member/authorinsertpro.do" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label>작가 이름</label>
        <input type="text" name="authorname" required>
    </div>

    <div class="form-group">
        <label>작가 소개</label>
        <textarea name="authorinfo" required></textarea>
    </div>

    <div class="form-group">
        <label>프로필 이미지1</label>
        <input type="file" name="authorimg1">
    </div>

    <div class="form-group">
        <label>프로필 이미지2</label>
        <input type="file" name="authorimg2">
    </div>

    <div class="form-group">
        <label>프로필 이미지3</label>
        <input type="file" name="authorimg3">
    </div>

    <button type="submit">등록하기</button>
</form>
