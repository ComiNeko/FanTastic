<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ page import="Model.MemberVo" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // 세션에서 로그인 정보 가져오기
    HttpSession sessionObj = request.getSession();
    MemberVo user = (MemberVo) sessionObj.getAttribute("user");

    // 로그인하지 않은 경우, 로그인 페이지로 이동
    if (user == null) {
        response.sendRedirect("/member/login.do");
        return;
    }
%>

<%@ include file="../fragments/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매페이지</title>
    <link rel="stylesheet" href="../css/postwrite.css">
    <style>
        /*  전체 스타일 개선 */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        .wrapBody {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            padding: 30px;
        }

        .subContent {
            width: 100%;
            max-width: 600px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        #subTitle {
            text-align: center;
            margin-bottom: 20px;
        }

        .s_title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        /* 폼 스타일 */
        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-size: 16px;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .inputH,
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            background: #fff;
            transition: 0.3s ease-in-out;
        }

        .inputH:focus,
        textarea:focus,
        select:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
        }

        textarea {
            height: 120px;
            resize: vertical;
        }

        /* 버튼 스타일 */
        .submit-btn {
            width: 100%;
            background-color: #3498db;
            color: white;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s ease-in-out;
        }

        .submit-btn:hover {
            background-color: #2980b9;
        }

        /* 파일 업로드 스타일 */
        input[type="file"] {
            border: none;
            background: #fff;
            padding: 5px;
        }

        .explain {
            font-size: 12px;
            color: #666;
        }

        .orange {
            color: #e67e22;
        }
    </style>
</head>
<body>

<div class="wrapBody">
    <div class="subContent" id="gwrite">
        <div id="subTitle">
            <p class="s_title">작품 등록</p>
        </div>

        <form name="productForm" method="post" enctype="multipart/form-data" action="/post/ptwritepro.do">

            <!-- 로그인한 사용자 ID를 숨겨진 필드로 추가 -->
            <input type="hidden" name="authorid" value="<%= user.getUserid() %>">

            <div class="form-group">
                <label>카테고리</label>
                <select name="categoryid" class="inputH" required>
                    <option value="">선택하세요</option>
                    <option value="1">키링</option>
                    <option value="2">아크릴</option>
                    <option value="3">포토카드</option>
                    <option value="4">틴케이스</option>
                    <option value="5">키캡</option>
                    <option value="6">거울/핀버튼</option>
                    <option value="7">커버/클리너</option>
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

            <div class="form-group">
                <label>대표 이미지</label>
                <input type="file" name="productImage" accept="image/*" required>
                <p class="explain">권장 사이즈: <b>4:3</b> (732px x 549px) / 최대 용량 <b>12MB</b><br>
                <span class="orange">jpg, png, gif</span> 파일만 가능.</p>
            </div>

            <div class="form-group">
                <label>작품 설명</label>
                <textarea name="productInfo" required></textarea>
            </div>
            
            <div class="form-group">
                <input type="submit" value="등록하기" class="submit-btn">
            </div>

        </form>

    </div>
</div><!-- wrapBody 끝나는 곳 -->

</body>
</html>

<%@ include file="../fragments/footer.jsp" %>
