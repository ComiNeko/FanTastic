<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/mypage.css">



<div class="favorite-container">
    <h2>찜하기</h2>

    <!-- (A) 카테고리 바 -->
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

    <!-- (B) 폴더 바 -->
    <div class="folder-bar">
        <c:forEach var="folder" items="${folderList}">
            <a href="#" class="folder-btn" data-folderid="${folder.folderid}">
                ${folder.foldername}
                <span class="edit-btn" data-foldername="${folder.foldername}"></span>
            </a>
        </c:forEach>

        <a href="/mylikefolder.do">📁</a>
        <span id="editModeToggle" style="color: #999; font-size: 0.9rem; margin-left: 15px; cursor: pointer;">편집</span>
    </div>

    <!-- (C) 찜한 상품 목록 -->
    <div id="favoriteList">
        <c:forEach var="item" items="${favoriteList}">
            <div class="favorite-item" id="favitem_${item.productid}">
                <input type="checkbox" class="select-checkbox" style="display:none;" onchange="toggleSelectItem(${item.productid}, this.checked)">
                <img src="${item.productimage}" alt="${item.productname}">
                <div class="product-name">${item.productname}</div>
                <div class="product-price">${item.productprice}원</div>
            </div>
        </c:forEach>
    </div>

    <!-- (D) 하단 바 (삭제, 폴더 이동) -->
<div class="bottom-bar" id="editBottomBar" style="display: none;">
    <button id="deleteBtn">삭제</button>
    <button id="moveFolderBtn">폴더 이동</button>
</div>
</div> <!-- favorite-container 닫는 태그 (필요한 경우) -->

<!-- (E) 폴더 선택 모달 -->
<div class="modal-backdrop" id="folderModal">
    <div class="modal-content">
        <h3>폴더 선택</h3>
        <div class="folder-list" id="folderListContainer">
            <!-- JS에서 동적으로 폴더 목록 렌더링 -->
        </div>
        <div style="margin-top:10px; text-align:right;">
            <button id="closeModalBtn">닫기</button>
        </div>
    </div>
</div>


<script>
let currentCategoryId = 0;
let currentFolderId = null;
let currentPage = 1;
let pageSize = 6;
let isLoading = false;
let hasMoreData = true;

let editMode = false;
let selectedItems = [];

$(document).ready(function(){

    // (1) 카테고리 클릭
    $('.favorite-category-item').click(function(){
        $('.favorite-category-item').removeClass('active');
        $(this).addClass('active');
        currentCategoryId = parseInt($(this).data('categoryid'));
        resetAndLoad();
    });

    // (2) 폴더 버튼 클릭
    $('.folder-btn').click(function(e){
        e.preventDefault();
        $('.folder-btn').removeClass('active');
        $(this).addClass('active');
        let fid = $(this).data('folderid');
        currentFolderId = (fid == 0) ? null : parseInt(fid);
        resetAndLoad();
    });

    // (3) 무한 스크롤
    $(window).on('scroll', function(){
        if(!isLoading && hasMoreData){
            if($(window).scrollTop() + $(window).height() >= $(document).height() - 100){
                isLoading = true;
                currentPage++;
                loadFavorites(currentCategoryId, currentFolderId, currentPage);
            }
        }
    });

    // (4) 초기 로딩
    loadFavorites(currentCategoryId, currentFolderId, currentPage);

    // (5) 편집 모드 토글
    $('#editModeToggle').click(function(){
        editMode = !editMode;
        if(editMode){
            $(this).text("편집 완료");
            $('#editBottomBar').show();
            $('.select-checkbox').show();
        } else {
            $(this).text("편집");
            $('#editBottomBar').hide();
            $('.select-checkbox').hide();
            selectedItems = [];
        }
    });

    // (6) 삭제 버튼
    $('#deleteBtn').click(function(){
        if(selectedItems.length === 0){
            alert("선택된 상품이 없습니다.");
            return;
        }
        if(!confirm("선택된 상품을 삭제하시겠습니까?")) return;

        $.ajax({
            url: '/post/favorite/remove.do',
            type: 'POST',
            traditional: true,
            data: { productId: selectedItems },
            success: function(res){
                alert("삭제 완료");
                selectedItems.forEach(function(id){
                    $('#favitem_'+id).remove();
                });
                selectedItems = [];
            },
            error: function(err){
                console.log(err);
                alert("삭제 실패");
            }
        });
    });

    // (7) 폴더 이동 버튼 클릭 -> 모달 열기
    $('#moveFolderBtn').click(function(){
        $('#folderModal').addClass('active');

        // 폴더 리스트 렌더링
        let folderHtml = '';
        $('.folder-btn').each(function(){
            const folderId = $(this).data('folderid');
            const folderName = $(this).text().trim();

            folderHtml += `<div class="folder-item" data-folderid="${folderId}">${folderName}</div>`;
        });

        $('#folderListContainer').html(folderHtml);
    });

    // (8) 모달 닫기 버튼 클릭
    $('#closeModalBtn').click(function(){
        $('#folderModal').removeClass('active');
    });

    // (9) 폴더 아이템 선택 시 -> 폴더 이동 기능 추가 가능
    $(document).on('click', '.folder-item', function(){
        const selectedFolderId = $(this).data('folderid');
        console.log('선택한 폴더:', selectedFolderId);

        // TODO: 폴더 이동 처리 로직 구현
        $('#folderModal').removeClass('active');
    });

    // (A) 목록 초기화 후 로딩
    function resetAndLoad(){
        $('#favoriteList').empty();
        currentPage = 1;
        hasMoreData = true;
        loadFavorites(currentCategoryId, currentFolderId, currentPage);
    }

    // (B) 찜 목록 로딩
    function loadFavorites(categoryId, folderId, page) {
    $.ajax({
        url: "/post/favorite/list.do",
        type: "GET",
        data: {
            categoryId: categoryId,
            folderId: folderId,
            page: page,
            pageSize: pageSize,
            ajax: true  // ✅ 이걸 보내야 Controller에서 조각으로 forward 함
        },
        success: function(html) {
            $('#favoriteList').append(html);
        },
        error: function(xhr, status, error) {
            console.log(error);
        }
    });
}

    // (C) 체크박스 선택 처리
    window.toggleSelectItem = function(productId, isChecked){
        if(isChecked){
            if(!selectedItems.includes(productId)){
                selectedItems.push(productId);
            }
        } else {
            selectedItems = selectedItems.filter(function(id){ return id !== productId; });
        }
        console.log("현재 선택된 상품:", selectedItems);
    }

});
</script>
<%@ include file="/fragments/footer.jsp"%>
<style>
/* ============================
   전체 찜하기 컨테이너 스타일
   ============================ */
.favorite-container {
    margin: 20px; /* 바깥 여백 */
}

/* ============================
   카테고리 바와 폴더 바 영역
   ============================ */
.favorite-category-bar, .folder-bar {
    margin-bottom: 10px; /* 아래 여백 */
}

/* ============================
   카테고리 아이템 & 폴더 버튼 스타일
   ============================ */
.favorite-category-item, .folder-btn {
    margin-right: 10px; /* 오른쪽 여백 */
    cursor: pointer;    /* 마우스 오버 시 커서 변경 */
}

/* ============================
   선택된 카테고리 및 폴더 버튼 활성화 상태
   ============================ */
.favorite-category-item.active, .folder-btn.active {
    font-weight: bold;  /* 글씨 굵게 */
    color: #d9534f;     /* 강조 색상 (붉은색 계열) */
}

/* ============================
   찜한 상품 목록 리스트 스타일
   ============================ */
#favoriteList {
    display: flex;      /* 가로 정렬 (flex) */
    flex-wrap: wrap;    /* 줄바꿈 허용 */
    gap: 10px;          /* 아이템 간격 */
}

/* ============================
   찜한 상품 개별 아이템 박스 스타일
   ============================ */
.favorite-item {
    border: 1px solid #ddd; /* 테두리 */
    padding: 10px;          /* 안쪽 여백 */
    width: 120px;           /* 고정 너비 */
    position: relative;     /* 내부 요소 포지션 기준 */
    text-align: center;     /* 텍스트 가운데 정렬 */
    border-radius: 4px;     /* 모서리 둥글게 */
}

/* ============================
   상품 이미지 스타일
   ============================ */
.favorite-item img {
    width: 100%;  /* 너비 꽉 채우기 */
    height: auto; /* 비율 유지하며 높이 자동 조정 */
}

/* ============================
   편집 모드 시 선택용 체크박스
   ============================ */
.select-checkbox {
    position: absolute; /* 부모(favorite-item) 기준 배치 */
    top: 5px;           /* 위에서 5px */
    left: 5px;          /* 왼쪽에서 5px */
    display: none;      /* 기본 상태는 숨김 (편집 모드에서만 보이게) */
}

/* ============================
   편집 모드 하단 바 (삭제/폴더 이동 버튼)
   ============================ */
.bottom-bar {
    position: fixed;            /* 화면 하단 고정 */
    bottom: 0; left: 0;         /* 화면 하단 왼쪽 기준 */
    width: 100%;                /* 가로 전체 차지 */
    background: #f9f9f9;        /* 배경 색 */
    border-top: 1px solid #ccc; /* 상단 테두리 */
    padding: 10px;              /* 안쪽 여백 */
    display: flex;              /* 가로 정렬 */
    justify-content: space-around; /* 버튼 간격 */
    display: none;              /* 기본은 숨김 (편집 모드에서만 노출) */
}

/* ============================
   모달 전체 배경 (어두운 반투명 배경)
   ============================ */
.modal-backdrop {
    position: fixed;          /* 전체 화면 고정 */
    top: 0; left: 0; right: 0; bottom: 0; /* 화면 전체 크기 */
    background: rgba(0,0,0,0.5); /* 반투명 검은 배경 */
    display: none;            /* 기본 숨김 상태 */
    justify-content: center;  /* 가운데 정렬 */
    align-items: center;      /* 세로 방향 가운데 정렬 */
}

/* ============================
   모달이 활성화되었을 때 (모달 열림)
   ============================ */
.modal-backdrop.active {
    display: flex; /* flex로 보이게 */
}

/* ============================
   모달 내부 콘텐츠 박스
   ============================ */
.modal-content {
    background: #fff;       /* 흰 배경 */
    padding: 20px;          /* 안쪽 여백 */
    width: 300px;           /* 고정 너비 */
    border-radius: 8px;     /* 모서리 둥글게 */
}

/* ============================
   모달 내 폴더 리스트 스타일
   ============================ */
.folder-list .folder-item {
    cursor: pointer;            /* 클릭 가능한 커서 */
    padding: 5px 0;             /* 위아래 간격 */
    border-bottom: 1px solid #eee; /* 구분선 */
}

/* ============================
   마지막 폴더 항목은 구분선 없앰
   ============================ */
.folder-list .folder-item:last-child {
    border-bottom: none; /* 마지막 항목은 테두리 없음 */
}
</style>
