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

<section class="postwrite-section">
    <div class="postwrite-header">
        <div class="container">
            <h2 class="postwrite-title">商品登録</h2>
        </div>
    </div>
    <div class="postwrite-content">
        <div class="container">
            <form name="productForm" method="post" enctype="multipart/form-data" action="/post/ptwritepro.do" class="postwrite-form">

                <!-- 로그인한 사용자 ID 숨겨서 전송 -->
                <input type="hidden" name="authorid" value="${sessionScope.user.userid}">

                <div class="form-group">
                    <label>カテゴリー</label>
                    <select name="categoryid" required>
                        <option value="">選択してください</option>
                        <option value="1">キーホルダー</option>
                        <option value="2">アクリル</option>
                        <option value="3">フォトカード</option>
                        <option value="4">ティンケース</option>
                        <option value="5">キーキャップ</option>
                        <option value="6">ミラー/ピンバッジ</option>
                        <option value="7">カバー/クリーナー</option>
                        <option value="8">その他</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>タイトル</label>
                    <input type="text" name="productName" maxlength="28" required>
                    <p class="warning-text">* 特殊文字でタイトルを強調すると削除される可能性があります。</p>
                </div>

                <div class="form-group">
                    <label>価格(₩)</label>
                    <input type="number" name="productPrice" min="0" required>
                </div>

                <div class="form-group">
                    <label>在庫数</label>
                    <input type="number" name="productStock" min="0" required>
                </div>

                <div class="form-group">
                    <label>代表画像</label>
                    <input type="file" name="productImage" accept="image/*" required>
                    <p class="explain">推奨: 4:3 (732x549) / 最大 12MB (jpg, png, gif)</p>
                </div>

                <div class="form-group">
                    <label>商品説明</label>
                    <textarea name="productInfo" required></textarea>
                </div>

                <div class="form-group">
                    <input type="submit" value="商品登録" class="submit-btn">
                </div>

            </form>
        </div>
    </div>
</section>

<%@ include file="../fragments/footer.jsp" %>
