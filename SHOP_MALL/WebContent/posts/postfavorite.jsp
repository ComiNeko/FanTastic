<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/mypage.css">

<style>
    .favorite-container { margin: 20px; }
    .favorite-category-bar { margin-bottom: 10px; }
    .favorite-category-item { margin-right: 10px; cursor: pointer; }
    .favorite-category-item.active { font-weight: bold; color: #d9534f; }
    .favorite-list { display: flex; flex-wrap: wrap; gap: 10px; }
    .favorite-item { border: 1px solid #ddd; padding: 10px; width: 120px; text-align: center; border-radius: 4px; position: relative; }
    .favorite-item img { width: 100%; height: auto; }
    .delete-btn { position: absolute; top: 2px; right: 2px; background: #f44336; color: #fff; border: none; border-radius: 50%; width: 20px; height: 20px; cursor: pointer; font-size: 12px; }
    .pagination { margin-top: 20px; text-align: center; }
    .pagination a { margin: 0 5px; text-decoration: none; }
    .pagination a.current { font-weight: bold; color: #d9534f; }
</style>

<div class="favorite-container">
    <h2>찜하기 목록</h2>

    <!-- 카테고리 바 -->
    <div class="favorite-category-bar">
        <span class="favorite-category-item ${categoryId == 0 ? 'active' : ''}" data-categoryid="0">전체</span>
        <span class="favorite-category-item ${categoryId == 1 ? 'active' : ''}" data-categoryid="1">키링</span>
        <span class="favorite-category-item ${categoryId == 2 ? 'active' : ''}" data-categoryid="2">아크릴</span>
        <span class="favorite-category-item ${categoryId == 3 ? 'active' : ''}" data-categoryid="3">포토카드</span>
        <span class="favorite-category-item ${categoryId == 4 ? 'active' : ''}" data-categoryid="4">틴케이스</span>
        <span class="favorite-category-item ${categoryId == 5 ? 'active' : ''}" data-categoryid="5">키캡</span>
        <span class="favorite-category-item ${categoryId == 6 ? 'active' : ''}" data-categoryid="6">거울/핀버튼</span>
        <span class="favorite-category-item ${categoryId == 7 ? 'active' : ''}" data-categoryid="7">커버/클리너</span>
    </div>

    <form id="favoriteForm" method="post" action="/post/remove.do">
        <div class="favorite-list">
            <c:forEach var="item" items="${favoriteList}">
                <div class="favorite-item" id="favitem_${item.productid}">
                    <input type="checkbox" name="productId" value="${item.productid}" class="fav-checkbox" style="position:absolute; top:2px; left:2px;">
                    
                    <img src="${item.productImage}" alt="${item.productName}">
                    <div class="product-name">${item.productName}</div>
                    <div class="product-price">${item.productPrice}원</div>
                    
                    <button type="button" class="delete-btn" data-productid="${item.productid}">×</button>
                </div>
            </c:forEach>
        </div>
        
        <div style="margin-top:10px;">
            <button type="button" id="bulkDeleteBtn">선택 삭제</button>
        </div>
    </form>

    <div class="pagination">
        <c:if test="${startPage > 1}">
            <a href="javascript:goPage(${startPage - 1});">이전</a>
        </c:if>
        <c:forEach var="p" begin="${startPage}" end="${endPage}">
            <a href="javascript:goPage(${p});" class="${p == currentPage ? 'current' : ''}">${p}</a>
        </c:forEach>
        <c:if test="${endPage < totalPages}">
            <a href="javascript:goPage(${endPage + 1});">다음</a>
        </c:if>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 카테고리 이동
    $('.favorite-category-item').click(function(){
        var catId = $(this).data('categoryid');
        window.location.href = "/post/list.do?categoryId=" + catId;
    });

    // 단일 삭제 (클릭 시 상세 페이지 이동 이벤트와 충돌하지 않도록 stopPropagation)
    $('.delete-btn').on('click', function(e){
        e.stopPropagation();
        var productId = $(this).data('productid');
        if(confirm("해당 상품을 찜 목록에서 삭제하시겠습니까?")){
            $.ajax({
                url: '/post/remove.do',
                type: 'POST',
                data: { productId: productId },
                success: function(result){
                    if(result.trim() == "success"){
                        $("#favitem_" + productId).remove();
                    } else {
                        alert("삭제 실패!");
                    }
                },
                error: function(){
                    alert("삭제 중 오류 발생!");
                }
            });
        }
    });

    // 선택 삭제
    $('#bulkDeleteBtn').on('click', function(){
        if(confirm("선택한 상품들을 찜 목록에서 삭제하시겠습니까?")){
            $.ajax({
                url: '/post/remove.do',
                type: 'POST',
                data: $('#favoriteForm').serialize(),
                success: function(result){
                    if(result.trim() == "success"){
                        location.reload();
                    } else {
                        alert("삭제 실패!");
                    }
                },
                error: function(){
                    alert("삭제 중 오류 발생!");
                }
            });
        }
    });

    // 찜한 상품 클릭 시 (체크박스, 삭제 버튼 제외) 상세 페이지로 이동
    $('.favorite-item').on('click', function(e) {
        if (!$(e.target).hasClass('delete-btn') && !$(e.target).is(':checkbox')) {
            var productId = $(this).attr('id').split('_')[1];
            window.location.href = "/post/postdetail.do?productid=" + productId;
        }
    });

    // 페이지 이동 함수
    function goPage(page){
        var categoryId = "${categoryId}";
        window.location.href = "/post/list.do?page=" + page + "&categoryId=" + categoryId;
    }
</script>

<%@ include file="../fragments/footer.jsp" %>
