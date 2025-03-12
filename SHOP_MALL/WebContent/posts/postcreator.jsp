<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../fragments/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>크리에이터 목록</title>
    <link rel="stylesheet" href="/css/creatorlist.css">
</head>
<body>

<h2 class="creator-title">크리에이터 목록</h2>

<div class="creator-container">
    <c:forEach var="creator" items="${creatorList}">
        <div class="creator-card" onclick="location.href='/post/creatordetail.do?authorid=${creator.authorid}'">
            <img src="${pageContext.request.contextPath}${creator.authorimg1}" alt="${creator.authorname}" class="creator-img">
            <h3 class="creator-name">${creator.authorname}</h3>
        </div>
    </c:forEach>
</div>

<%@ include file="/fragments/footer.jsp" %>
</body>
</html>
