<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/mypage.css">

<h2>폴더 관리</h2>

<!-- 뒤로가기 or 찜 목록으로 돌아가기 -->
<a href="/post/postfavorite.do" style="color:#999; margin-bottom:10px; display:inline-block;">
    ← 돌아가기
</a>

<div id="folderManageContainer">
    <!-- 폴더 목록 표시 영역 -->
    <div id="folderManageList"></div>
    
    <!-- 새 폴더 추가 버튼 -->
    <button id="addNewFolderBtn">새 폴더 추가</button>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    // 1) 페이지 로딩 시 폴더 목록 불러오기
    loadFolderManageList();
    
    // 2) 새 폴더 추가
    $('#addNewFolderBtn').click(function(){
        let folderName = prompt("새 폴더 이름을 입력하세요");
        if(folderName && folderName.trim() !== ""){
            $.ajax({
                url: '/post/folderAjax.do',
                type: 'POST',
                data: {
                    action: 'createFolder',
                    folderName: folderName
                },
                success: function(){
                    alert("폴더가 추가되었습니다.");
                    loadFolderManageList(); // 목록 갱신
                },
                error: function(err){
                    console.log(err);
                    alert("폴더 추가 실패");
                }
            });
        }
    });
});

// (A) 폴더 목록 불러오기
function loadFolderManageList(){
    $.ajax({
        url: '/post/folderList.do', // 폴더 목록을 JSON으로 반환하는 API
        type: 'GET',
        dataType: 'json',
        success: function(folderData){
            renderFolderManageList(folderData);
        },
        error: function(err){
            console.log(err);
        }
    });
}

// (B) 폴더 목록 렌더링
function renderFolderManageList(folderArray){
    let $list = $('#folderManageList');
    $list.empty();

    // 기본 폴더 (편집 불가)
    let defaultFolderHtml = `
        <div class="folder-edit-item" style="margin-bottom:10px;">
            <span style="color:#999;">기본 폴더 (수정/삭제 불가)</span>
        </div>
    `;
    $list.append(defaultFolderHtml);

    // 나머지 폴더
    folderArray.forEach(function(folder){
        // folderid, foldername
        let folderHtml = `
        <div class="folder-edit-item" data-folderid="${folder.folderid}" style="margin-bottom:10px;">
            <!-- 삭제 버튼 -->
            <button class="delete-folder-btn" style="background:none; border:none; color:red; font-size:1.2rem;">-</button>
            <!-- 폴더 이름 입력창 -->
            <input type="text" class="folder-name-input" value="${folder.foldername}" style="width:60%; margin-left:5px;" />
            <!-- 저장 버튼 -->
            <button class="save-folder-btn" style="margin-left:5px;">저장</button>
        </div>
        `;
        $list.append(folderHtml);
    });

    // 동적 요소 이벤트 바인딩
    $('.delete-folder-btn').off('click').on('click', function(){
        let folderId = $(this).closest('.folder-edit-item').data('folderid');
        if(confirm("정말 삭제하시겠습니까?")){
            deleteFolder(folderId);
        }
    });

    $('.save-folder-btn').off('click').on('click', function(){
        let $parent = $(this).closest('.folder-edit-item');
        let folderId = $parent.data('folderid');
        let newName = $parent.find('.folder-name-input').val().trim();
        if(newName){
            renameFolder(folderId, newName);
        }
    });
}

// (C) 폴더 삭제
function deleteFolder(folderId){
    $.ajax({
        url: '/post/folderAjax.do',
        type: 'POST',
        data: {
            action: 'deleteFolder',
            folderId: folderId
        },
        success: function(res){
            if(res === 'OK'){
                alert("폴더가 삭제되었습니다.");
                loadFolderManageList();
            } else {
                alert("폴더 삭제 실패");
            }
        },
        error: function(err){
            console.log(err);
        }
    });
}

// (D) 폴더 이름 수정
function renameFolder(folderId, folderName){
    $.ajax({
        url: '/post/folderAjax.do',
        type: 'POST',
        data: {
            action: 'renameFolder',
            folderId: folderId,
            folderName: folderName
        },
        success: function(res){
            if(res === 'OK'){
                alert("폴더 이름이 수정되었습니다.");
                loadFolderManageList();
            } else {
                alert("폴더 이름 수정 실패");
            }
        },
        error: function(err){
            console.log(err);
        }
    });
}
</script>
<%@ include file="../fragments/footer.jsp" %>
