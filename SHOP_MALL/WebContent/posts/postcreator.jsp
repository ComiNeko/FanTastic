<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../fragments/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>크리에이터 목록</title>
    <link rel="stylesheet" href="/css/postcreator.css">
</head>
<body>

<h2 class="creator-title">크리에이터 목록</h2>

<div class="creator-container">
    <c:forEach var="creator" items="${creatorList}">
    	<div class="creator-card" onclick="location.href='/post/creatordetail.do?authorid=${creator.authorid}'">
        <p>작가 이름: ${creator.authorname}</p>
        <p>작가 소개: ${creator.authorinfo}</p>
        <img src="/uploads/${creator.authorimg1}" alt="작가 이미지" width="100">
    </div>
</c:forEach>
</div>

<%@ include file="/fragments/footer.jsp" %>
</body>
</html>
