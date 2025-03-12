<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/mypage.css">

<div class="favorite-container">
    <h2>찜하기</h2>
    
    <!-- (A) 카테고리 바 (회색 글씨) -->
    <div class="favorite-category-bar">
        <span class="favorite-category-item" data-categoryid="0">전체</span>
        <span class="favorite-category-item" data-categoryid="1">키링</span>
        <span class="favorite-category-item" data-categoryid="2">아크릴</span>
        <span class="favorite-category-item" data-categoryid="3">포토카드</span>
        <span class="favorite-category-item" data-categoryid="4">틴케이스</span>
        <span class="favorite-category-item" data-categoryid="5">키캡</span>
        <span class="favorite-category-item" data-categoryid="6">거울/핀버튼</span>
        <span class="favorite-category-item" data-categoryid="7">커버/클리너</span>
    </div>
    
    <!-- (B) 폴더 바 (까만 버튼) -->
    <div class="folder-bar">
        <!-- 기본 폴더: data-folderid="0"는 기본 폴더(실제 처리 시 null로 변환) -->
        <a href="#" class="folder-btn" data-folderid="0">
            기본폴더
            <span class="edit-btn" data-foldername="기본폴더"></span>
        </a>
        <!-- 동적으로 생성된 폴더 목록 -->
        <c:forEach var="folder" items="${folderList}">
            <a href="#" class="folder-btn" data-folderid="${folder.folderid}">
                ${folder.foldername}
                <span class="edit-btn" data-foldername="${folder.foldername}"></span>
            </a>
        </c:forEach>
        <!-- 폴더 추가 버튼 -->
        <button id="addFolderBtn" type="button">📁</button>
    </div>
    
    <!-- (C) 찜한 상품 목록 (무한 스크롤) -->
    <div id="favoriteList"></div>
</div>

<!-- JavaScript: jQuery를 이용한 무한 스크롤, 필터, 폴더 편집 -->
<script>
    // 전역 상태
    let currentCategoryId = 0; // 0: 전체
    let currentFolderId = null;  // 기본 폴더 (null)
    let currentPage = 1;
    let pageSize = 6;
    let isLoading = false;
    let hasMoreData = true;
    
    $(document).ready(function(){
        // 카테고리 클릭 이벤트
        $('.favorite-category-item').click(function(){
            $('.favorite-category-item').removeClass('active');
            $(this).addClass('active');
            currentCategoryId = parseInt($(this).data('categoryid'));
            resetAndLoad();
        });
        
        // 폴더 버튼 클릭 이벤트
        $('.folder-btn').click(function(e){
            e.preventDefault();
            $('.folder-btn').removeClass('active');
            $(this).addClass('active');
            // 기본 폴더는 data-folderid="0" → 처리 시 null
            let fid = $(this).data('folderid');
            currentFolderId = (fid == 0) ? null : parseInt(fid);
            resetAndLoad();
        });
        
        // 폴더 이름 수정 (✎ 아이콘)
        $('.edit-btn').click(function(e){
            e.stopPropagation();
            let oldName = $(this).data('foldername');
            let folderBtn = $(this).closest('.folder-btn');
            let fid = folderBtn.data('folderid');
            // 기본 폴더는 수정 불가
            if(fid == 0) {
                alert("기본 폴더는 수정할 수 없습니다.");
                return;
            }
            editFolderName(parseInt(fid), oldName);
        });
        
        // 폴더 추가 버튼 클릭 이벤트
        $('#addFolderBtn').click(function(){
            let folderName = prompt("새 폴더 이름을 입력하세요");
            if(folderName && folderName.trim() !== ""){
                $.ajax({
                    url: '/post/folderAjax.do',
                    type: 'POST',
                    data: { action: 'createFolder', folderName: folderName },
                    success: function(){
                        alert("폴더가 추가되었습니다.");
                        location.reload();
                    },
                    error: function(err){
                        console.log(err);
                    }
                });
            }
        });
        
        // 무한 스크롤
        $(window).on('scroll', function(){
            if(!isLoading && hasMoreData){
                if($(window).scrollTop() + $(window).height() >= $(document).height() - 100){
                    isLoading = true;
                    currentPage++;
                    loadFavorites(currentCategoryId, currentFolderId, currentPage);
                }
            }
        });
        
        // 초기 로딩
        loadFavorites(currentCategoryId, currentFolderId, currentPage);
    });
    
    function resetAndLoad(){
        $('#favoriteList').empty();
        currentPage = 1;
        hasMoreData = true;
        loadFavorites(currentCategoryId, currentFolderId, currentPage);
    }
    
    function loadFavorites(categoryId, folderId, page){
        isLoading = true;
        $.ajax({
            url: '/post/favoriteAjax.do',
            type: 'GET',
            data: {
                categoryId: categoryId,
                folderId: (folderId == null ? 0 : folderId), // 기본 폴더는 0로 전송
                page: page,
                pageSize: pageSize
            },
            dataType: 'json',
            success: function(data){
                if(data && data.length > 0){
                    renderFavoriteItems(data);
                } else {
                    hasMoreData = false;
                }
                isLoading = false;
            },
            error: function(err){
                console.log(err);
                isLoading = false;
            }
        });
    }
    
    function renderFavoriteItems(items){
        items.forEach(function(item){
            let html = 
            <div class="favorite-item">
                <img src="${item.productimage}" alt="${item.productname}">
                <div class="product-name">${item.productname}</div>
                <div class="product-price">${item.productprice}원</div>
            </div>
            `;
            $('#favoriteList').append(html);
        });
    }
    
    function editFolderName(folderId, oldName){
        let newName = prompt("새 폴더 이름을 입력하세요", oldName);
        if(newName && newName.trim() !== ""){
            $.ajax({
                url: '/post/folderAjax.do',
                type: 'POST',
                data: { action: 'renameFolder', folderId: folderId, folderName: newName },
                success: function(res){
                    if(res === "OK"){
                        alert("폴더 이름이 수정되었습니다.");
                        location.reload();
                    } else {
                        alert("폴더 이름 수정에 실패하였습니다.");
                    }
                },
                error: function(err){
                    console.log(err);
                }
            });
        }
    }
</script>
<%@ include file="/fragments/footer.jsp"%>