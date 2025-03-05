<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ include file="../fragments/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매페이지</title>
<link rel="stylesheet" href="/css/postwrite.css">
</head>
<body>
<div class="wrapBody">
    <div class="subContent" id="gwrite">
        <div id="subTitle">
            <p class="s_title">작품 등록</p>
        </div>

        <!-- 작품 등록 폼 -->
        <form name="productForm" method="post" enctype="multipart/form-data" action="/post/ptwritepro.do">
            <!-- 상품 기본 정보 -->
            <div class="form-group">
                <label>카테고리</label>
                <select name="categoryid" class="inputH" required>
                    <option value="">선택하세요</option>
                    <option value="1">크리에이터</option>
                    <option value="2">일러스트</option>
                    <option value="3">라이브2D</option>
                    <option value="4">버추얼 3D</option>
                </select>
            </div>

            <div class="form-group">
                <label>제목</label>
                <input type="text" name="productName" class="inputH" maxlength="28" required>
                <p class="warning-text">* 특수문자로 제목을 강조하면 삭제될 수 있습니다.</p>
            </div>

            <div class="form-group">
                <label>가격 (₩)</label>
                <input type="number" name="productPrice" class="inputH" min="0" required>
            </div>

            <div class="form-group">
                <label>재고 수량</label>
                <input type="number" name="productStock" class="inputH" min="0" required>
            </div>

            <!-- 대표 이미지 업로드 -->
            <div class="form-group">
                <label>대표 이미지</label>
                <input type="file" name="productImage" accept="image/*" required>
                <p class="explain">권장 사이즈: <b>4:3</b> (732px x 549px) / 최대 용량 <b>12MB</b><br>
                <font class="orange">jpg, png, gif</font> 파일만 가능.</p>
            </div>

            <div class="form-group">
                <label>작품 설명</label>
                <textarea name="productInfo" required></textarea>
            </div>
            
            <!-- 등록 버튼 -->
            <div class="form-group">
                <input type="submit" value="등록하기" class="submit-btn">
            </div>
        </form>
    </div>
</div>
</body>
</html>

<%@ include file="../fragments/footer.jsp" %>
