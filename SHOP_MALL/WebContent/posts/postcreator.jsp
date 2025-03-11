<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="/css/postcreator.css">

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>크리에이터 리스트</title>
</head>
<body>
<h2 style="text-align:center;">크리에이터 리스트</h2>
    <div class="creator-list">
        <c:forEach var="creator" items="${creatorList}">
            <div class="creator-card">
                <a href="/post/creatordetail.do?authorid=${creator.authorid}">
                    <img src="${creator.authorimg1}" alt="${creator.authorname}">
                    <h3>${creator.authorname}</h3>
                </a>
            </div>
        </c:forEach>
    </div>

<%@ include file="/fragments/footer.jsp"%>
</body>
</html>
