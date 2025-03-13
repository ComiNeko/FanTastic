<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/mypage.css">

<style>
    .favorite-container { margin: 20px; }
    .favorite-category-bar { margin-bottom: 10px; }
    .favorite-category-item { margin-right: 10px; cursor: pointer; }
    .favorite-category-item.active { font-weight: bold; color: #d9534f; }
    #favoriteList { display: flex; flex-wrap: wrap; gap: 10px; }
    .favorite-item { border: 1px solid #ddd; padding: 10px; width: 120px; text-align: center; border-radius: 4px; }
    .favorite-item img { width: 100%; height: auto; }
</style>

<div class="favorite-container">
    <h2>찜하기 목록</h2>
    <div class="favorite-category-bar">
        <span class="favorite-category-item active" data-categoryid="0">전체</span>
        <span class="favorite-category-item" data-categoryid="1">키링</span>
        <span class="favorite-category-item" data-categoryid="2">아크릴</span>
        <span class="favorite-category-item" data-categoryid="3">포토카드</span>
        <span class="favorite-category-item" data-categoryid="4">틴케이스</span>
        <span class="favorite-category-item" data-categoryid="5">키캡</span>
        <span class="favorite-category-item" data-categoryid="6">거울/핀버튼</span>
        <span class="favorite-category-item" data-categoryid="7">커버/클리너</span>
    </div>
    
    <div id="favoriteList">
        <c:forEach var="item" items="${favoriteList}">
            <div class="favorite-item" id="favitem_${item.productid}">
                <img src="${item.productimage}" alt="${item.productname}">
                <div class="product-name">${item.productname}</div>
                <div class="product-price">${item.productprice}원</div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
let currentCategoryId = 0;
let currentPage = 1;
let pageSize = 10;
let isLoading = false;
let hasMoreData = true;

$(document).ready(function(){
    $('.favorite-category-item').click(function(){
        $('.favorite-category-item').removeClass('active');
        $(this).addClass('active');
        currentCategoryId = $(this).data('categoryid');
        resetAndLoad();
    });
    
    $(window).on('scroll', function(){
        if (!isLoading && hasMoreData) {
            if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
                isLoading = true;
                currentPage++;
                loadFavorites(currentCategoryId, currentPage);
            }
        }
    });
});

function resetAndLoad(){
    $('#favoriteList').empty();
    currentPage = 1;
    hasMoreData = true;
    loadFavorites(currentCategoryId, currentPage);
}

function loadFavorites(categoryId, page){
    $.ajax({
        url: "/post/list", 
        type: "GET",
        data: { categoryId: categoryId, page: page, pageSize: pageSize },
        success: function(html){
            if ($.trim(html).length > 0) {
                $('#favoriteList').append(html);
            } else {
                hasMoreData = false;
            }
            isLoading = false;
        },
        error: function(xhr, status, error){
            console.log("오류 발생", error);
            isLoading = false;
        }
    });
}
</script>

<%@ include file="../fragments/footer.jsp" %>
