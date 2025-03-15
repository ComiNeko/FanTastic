<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<%@ page import="Model.MemberVo" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // 세션에서 로그인 정보 가져오기
    HttpSession sessionObj = request.getSession();
    MemberVo user = (MemberVo) sessionObj.getAttribute("user");

    // 로그인하지 않은 경우 로그인 페이지로 이동
    if (user == null) {
        response.sendRedirect("/member/login.do");
        return;
    }
%>
<link rel="stylesheet" href="../css/postwrite.css">

<div class="wrapBody">
    <div class="subContent" id="gwrite">
        <div id="subTitle">
            <p class="s_title">작품 등록</p>
        </div>

        <form name="productForm" method="post" enctype="multipart/form-data" action="/post/ptwritepro.do">

            <!-- 로그인한 사용자 ID 숨겨서 전송 -->
            <input type="hidden" name="authorid" value="${sessionScope.user.userid}">

            <div class="form-group">
                <label>카테고리</label>
                <select name="categoryid" required>
                    <option value="">선택하세요</option>
                    <option value="1">키링</option>
                    <option value="2">아크릴</option>
                    <option value="3">포토카드</option>
                    <option value="4">틴케이스</option>
                    <option value="5">키캡</option>
                    <option value="6">거울/핀버튼</option>
                    <option value="7">커버/클리너</option>
                    <option value="8">기타</option>
                </select>
            </div>

            <div class="form-group">
                <label>제목</label>
                <input type="text" name="productName" maxlength="28" required>
                <p class="warning-text">* 특수문자로 제목을 강조하면 삭제될 수 있습니다.</p>
            </div>

            <div class="form-group">
                <label>가격 (₩)</label>
                <input type="number" name="productPrice" min="0" required>
            </div>

            <div class="form-group">
                <label>재고 수량</label>
                <input type="number" name="productStock" min="0" required>
            </div>

            <div class="form-group">
                <label>대표 이미지</label>
                <input type="file" name="productImage" accept="image/*" required>
                <p class="explain">권장: 4:3 (732x549) / 최대 12MB (jpg, png, gif)</p>
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
</div><!-- wrapBody 끝 -->

<%@ include file="../fragments/footer.jsp" %>
