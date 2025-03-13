<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="Model.MemberVo" %> <!-- MemberVo import 추가 -->
<%@ page session="true" %>
<%@ include file="../fragments/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link rel="stylesheet" href="../css/profileedit.css">
<%
    MemberVo user = (MemberVo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("/member/login.do");
        return;
    }
%>

<h2>작가 등록</h2>

<form action="/member/authorinsertpro.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="userid" value="<%= user.getUserid() %>">

    <div class="form-group">
        <label>작가 이름</label>
        <input type="text" id="authorname" name="authorname" required>

    <div class="form-group">
        <label>작가 소개</label>
        <textarea id="authorinfo" name="authorinfo" required></textarea>
    </div>

    <div class="form-group">
        <label>프로필 이미지1</label>
        <input type="file" id="authorimg1" name="authorimg1">
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
