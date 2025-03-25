<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Model.MemberVo" %>
<%@ page session="true" %>
<%@ include file="../fragments/header.jsp"%>

<link rel="stylesheet" href="../css/insertauthor.css">

<%
    MemberVo user = (MemberVo) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("/member/login.do");
        return;
    }
%>

<section class="profileedit-section">
    <div class="profileedit-header">
        <div class="container">
            <h2 class="profileedit-title">クリエイター登録</h2>
        </div>
    </div>
    <div class="profileedit-content">
        <div class="container">
            <form action="/member/authorinsertpro.do" method="post" enctype="multipart/form-data" class="profileedit-form">
                <input type="hidden" name="userid" value="<%= user.getUserid() %>">

                <div class="form-group">
                    <label>クリエイター名</label>
                    <input type="text" id="authorname" name="authorname" required>
                </div>

                <div class="form-group">
                    <label>クリエイター紹介</label>
                    <textarea id="authorinfo" name="authorinfo" required></textarea>
                </div>

                <div class="form-group">
                    <label>プロフィール画像1</label>
                    <input type="file" id="authorimg1" name="authorimg1">
                </div>

                <div class="form-group">
                    <label>プロフィール画像2</label>
                    <input type="file" name="authorimg2">
                </div>

                <div class="form-group">
                    <label>プロフィール画像3</label>
                    <input type="file" name="authorimg3">
                </div>

                <button type="submit">クリエーター登録</button>
            </form>
        </div>
    </div>
</section>

<%@ include file="../fragments/footer.jsp"%>