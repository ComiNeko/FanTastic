<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../fragments/header.jsp" %>
<link rel="stylesheet" href="../css/postsellinglist.css">


	<div class="wrapBody"><!-- list페이지 처음부터 끝까지 -->
	
	<div class="sub_menu_back">
	<div class="siteWidth left_ul">
		<ul class="head_title" style="padding-top:63px">
			<span>작품 리스트</span>
			<span class="head_title_s">커미션은 상업적인 용도로 사용할 수 없습니다</span>
		</ul>

<ul id="sub_menu">
    <li style="width:112px"><a href="postsellinglist.jsp" onclick="loading('1');">캐릭터 일러스트</a></li>
    <li class="on" style="width:112px"><a href="postsellingillustration.jsp" onclick="loading('1');">일러스트</a></li>
    <li style="width:112px"><a href="postselling2D.jsp" onclick="loading('1');">라이브2D</a></li>
    <li style="width:112px"><a href="postselling3D.jsp" onclick="loading('1');">버추얼 3D</a></li>
</ul>

	</div>	
</div>

	
	<div class="subContent">
	<!-- MAIN CENTER START -->
	<div id="list_banner">
		
	</div>
	
	<div class="clear" style="height:55px;">&nbsp;</div>
	
	
	<div id="listFocus" class="clear" style="height:6px;">&nbsp;</div>
	<div id="list_top" class="cf">
		<!--    @SEARCH BOX START -->
		<ul class="left" style="padding-top:10px; width:930px; ">
			<form name="searchForm2" method="get" action="index.php">				
			<input type="hidden" name="channel" value="list">
			<input type="hidden" name="cate" value="100000000000">
			<input type="hidden" name="order" value="mod">
			<input type="hidden" name="limit" value="30">
			<input type="hidden" name="field" value="">
			<!-- <input type="hidden" name="field2" value="" />
			<input type="hidden" name="search2" value="" /> -->

			<div id="search_Box"><input type="text" name="search" value="" onkeydown="ckEnter(document.searchForm2);"></div>
			<div class="searchBtn">
				<a onclick="subSearchOk();return false;">검색</a>
			</div>
			<div class="left checks etrans" style="margin:9px 10px 0px 18px"><input type="checkbox" name="detail" id="detail" value=""> <label for="detail">결과 내 검색</label></div>
			</form>
			<!--    @SEARCH BOX END-->
			<li class="left" style="margin-left: 8px">
				<select name="order" style="padding-left: 6px; font-size: 13px; width:80px" onchange="return getLists.cgOrder(this.value,1);">
					<option value="mod">최신순</option>
					<option value="best">인기순</option>
				</select>
			</li>
			<li class="left" style="margin-left: 8px">
				<select name="commers" style="padding-left: 6px; font-size: 13px; " onchange="return getLists.cgCommers(this.value,1);">
					<option value="">상업용 / 비상업용</option>
					<option value="Y">방송 · 상업용(외주)</option>
					<option value="N">비상업용</option>
				</select>
			</li>
			<li class="left" style="margin-left: 8px">
				<select name="filter" style="padding-left: 6px; font-size: 13px; " onchange="return getLists.cgFilter(this.value,1);">
					<option value="">기타 선택</option>
					<option value="1">빠른마감</option>
					<option value="2">당일마감</option>
					<option value="3">벡터이미지</option>
				</select>
			</li>
			<li class="left" style="margin-left: 8px">
				<div class="lgBtn" onclick="location.href='index.php?channel=today'">최근 본 작가</div>
			</li>
		</ul>
		<ul class="right">
			<div class="sBtn1" style="height:42px;line-height: 42px;" onclick="location.href='postwrite.jsp'">작품 등록 / 수정</div>
		</ul>

	</div>	
	
	<div class="tagList">
		<ul class="tag_box cf">
		
		<ol><a onclick="tagSearchOk('SD'); loading('3');" class="">#SD</a></ol>
		
		<ol><a onclick="tagSearchOk('방송용'); loading('3');" class="">#방송용</a></ol>
		
		<ol><a onclick="tagSearchOk('LD'); loading('3');" class="">#LD</a></ol>
		
		<ol><a onclick="tagSearchOk('방송화면'); loading('3');" class="">#방송화면</a></ol>
		
		<ol><a onclick="tagSearchOk('썸네일'); loading('3');" class="">#썸네일</a></ol>
		
		<ol><a onclick="tagSearchOk('구독티콘'); loading('3');" class="">#구독티콘</a></ol>
		
		<ol><a onclick="tagSearchOk('캐릭터디자인'); loading('3');" class="">#캐릭터디자인</a></ol>
		
		<ol><a onclick="tagSearchOk('빠른마감'); loading('3');" class="">#빠른마감</a></ol>
		
		<ol><a onclick="tagSearchOk('남캐'); loading('3');" class="">#남캐</a></ol>
		
		<ol><a onclick="tagSearchOk('짚톡'); loading('3');" class="">#짚톡</a></ol>
		
		<ol><a onclick="tagSearchOk('유튜브'); loading('3');" class="">#유튜브</a></ol>
		
		<ol><a onclick="tagSearchOk('자캐'); loading('3');" class="">#자캐</a></ol>
		
		<ol><a onclick="tagSearchOk('대기화면'); loading('3');" class="">#대기화면</a></ol>
		
		<ol><a onclick="tagSearchOk('귀여운'); loading('3');" class="">#귀여운</a></ol>
		
		<ol><a onclick="tagSearchOk('치지직'); loading('3');" class="">#치지직</a></ol>
		
		<ol><a onclick="tagSearchOk('버츄얼'); loading('3');" class="">#버츄얼</a></ol>
		
		<ol><a onclick="tagSearchOk('방송'); loading('3');" class="">#방송</a></ol>
		
		<ol><a onclick="tagSearchOk('R18'); loading('3');" class="">#R18</a></ol>
		
		<ol><a onclick="tagSearchOk('움짤'); loading('3');" class="">#움짤</a></ol>
		
		<ol><a onclick="tagSearchOk('고정틀'); loading('3');" class="">#고정틀</a></ol>
		
		<ol><a onclick="tagSearchOk('배너'); loading('3');" class="">#배너</a></ol>
		
		<ol><a onclick="tagSearchOk('구독뱃지'); loading('3');" class="">#구독뱃지</a></ol>
		
		<ol><a onclick="tagSearchOk('커버곡'); loading('3');" class="">#커버곡</a></ol>
		
		<ol><a onclick="tagSearchOk('미소녀'); loading('3');" class="">#미소녀</a></ol>
		
		<ol><a onclick="tagSearchOk('19'); loading('3');" class="">#19</a></ol>
		
		<ol><a onclick="tagSearchOk('이모티콘'); loading('3');" class="">#이모티콘</a></ol>
		
		<ol><a onclick="tagSearchOk('외주'); loading('3');" class="">#외주</a></ol>
		
		<ol><a onclick="tagSearchOk('여캐'); loading('3');" class="">#여캐</a></ol>
		
		<ol><a onclick="tagSearchOk('미소년'); loading('3');" class="">#미소년</a></ol>
		
		<ol><a onclick="tagSearchOk('웹소설'); loading('3');" class="">#웹소설</a></ol>
		
		<ol><a onclick="tagSearchOk('수위'); loading('3');" class="">#수위</a></ol>
		
		<ol><a onclick="tagSearchOk('반실사'); loading('3');" class="">#반실사</a></ol>
		
		<ol><a onclick="tagSearchOk('낙서'); loading('3');" class="">#낙서</a></ol>
		
		<ol><a onclick="tagSearchOk('배경화면'); loading('3');" class="">#배경화면</a></ol>
		
		<ol><a onclick="tagSearchOk('채널아트'); loading('3');" class="">#채널아트</a></ol>
		
		<ol><a onclick="tagSearchOk('동물'); loading('3');" class="">#동물</a></ol>
		
		<ol><a onclick="tagSearchOk('시트'); loading('3');" class="">#시트</a></ol>
		
		<ol><a onclick="tagSearchOk('설정표'); loading('3');" class="">#설정표</a></ol>
		
		<ol><a onclick="tagSearchOk('애니메이션'); loading('3');" class="">#애니메이션</a></ol>
		
		<ol><a onclick="tagSearchOk('메이플'); loading('3');" class="">#메이플</a></ol>
		
		<ol><a onclick="tagSearchOk('삼면도'); loading('3');" class="">#삼면도</a></ol>
		
		<ol><a onclick="tagSearchOk('마인크래프트'); loading('3');" class="">#마인크래프트</a></ol>
		
		</ul>

	</div>
	
	<div class="clear" style="height:30px;">&nbsp;</div>

	<form name="listForm" method="post" action="">
	<div id="list_list">
		<table cellspacing="0" cellpadding="0" border="0" width="100%">			
		<tbody id="list_table"></tbody>
		<!-- id:listTable 에 리스트가 나옵니다. -->
		</table>
	</div>

	<!-- 여기서부터 본문, 작가와 가격,판매물건 등이 보여지는 부분 -->
	
	<!-- 본문 왼쪽 박스 시작 -->
	<div id="list_img"><div class="list_img_box both left"><ul>	
	<ol style="height: 145px;"><a href="../posts/postselling.jsp" target="_blank">		
	<dl class="thumb3" style="margin-left:0; background: url(image/goods_img2/4/43813.jpg?ver=1739568356) no-repeat center 15%"></dl>		
	<dl class="thumb3" style="background: url(image/goods_img2/4/43813B.jpg?ver=1739568356) no-repeat center 15%"></dl>		
	<dl class="thumb3" style="background: url(image/goods_img2/4/43813C.jpg?ver=1739568356) no-repeat center 15%"></dl>	</a></ol>	
	<ol style="height: 28px;">	
	<dl class="left ellip" style="padding-left:6px; width:360px;">YSJIN4 작가&nbsp;&nbsp;/&nbsp;&nbsp;SD(2~3등신) / 방송용, 비상업용, 상업용</dl>		
	<dl class="right" style="margin-top:-6px;"><a onclick="wishListAdd('43813')">
	<img src="../listimages/heart.png" id="wish43813" title="관심 작가"></a></dl></ol>	
	<ol><dl class="starBg_list">
	<div style="width:101%;overflow:hidden">
	<img src="../listimages/star.png"></div></dl>		
	<dl class="commercial">방송 · 상업용 / 비상업용</dl>		
	<dl class="price">40,000~</dl>	
	</ol></ul><div class="clear" style="height:10px;">&nbsp;</div></div>
	<!-- 여기까지가 본문 왼쪽 부분, 지금은 하드코딩했는데,작가이름이나 가격에다 속성부여해서 반복문 돌리면 될듯-->
	<!-- 앞으로 할 것 -->
	<!-- 하트버튼 눌렀을 때, 로그인 안했으면 로그인하라는 문구 출력할 것 -->
	
	
	<!-- 오른쪽 본문 부분 -->
	<div class="list_img_box right"><ul>	<ol style="height: 145px;"><a href="index.php?channel=view&amp;uid=40204" target="_blank">		<dl class="thumb3" style="margin-left:0; background: url(image/goods_img2/4/40204.jpg?ver=1713327907) no-repeat center 15%"></dl>		<dl class="thumb3" style="background: url(image/goods_img2/4/40204B.jpg?ver=1713327907) no-repeat center 15%"></dl>		<dl class="thumb3" style="background: url(image/goods_img2/4/40204C.jpg?ver=1713327907) no-repeat center 15%"></dl>	</a></ol>	<ol style="height: 28px;">		<dl class="left ellip" style="padding-left:6px; width:360px;">에크 작가&nbsp;&nbsp;/&nbsp;&nbsp;동물잠옷</dl>		<dl class="right" style="margin-top:-6px;"><a onclick="wishListAdd('40204')"><img src="skin/default/img/common/icon_list_wish.png" id="wish40204" title="관심 작가"></a></dl>	</ol>	<ol>		<dl class="starBg_list">			<div style="width:101%;overflow:hidden"><img src="skin/default/img/shop/icon_star.gif"></div>		</dl>		<dl class="commercial">방송 · 상업용 / 비상업용</dl>		<dl class="price">5,000~</dl>	</ol></ul><div class="clear" style="height:10px;">&nbsp;</div></div>
	<!-- 오른쪽 본문 부분 끝, 여기도 반복문 돌리면 되지 않을까 생각중. 안되면 하드코딩해야할 듯-->
	
	<div class="helpBox clear" id="noGoods" style="display:none">
		<font class="gdHelp">해당되는 게시물이 없습니다.</font>
		<div class="gdSmall gray" style="padding-top:10px;"></div>
	</div>	
	</form>
	
	

	
		

	
	<div class="clear" style="height:64px">&nbsp;</div>	
	
	<div class="clear" style="height:50px">&nbsp;</div>	

</div>
<!-- @MAIN CENTER END -->
	
<script>
	$(".favoriteBtn").on("click", function(){
		var userid = "${sessionScope.user.getUserid()}";
		var blog_bno = $(this).data('blog_bno'); //클릭한 찜하기 버튼의 data 속성의 값을 불러온다
//		alert(userid);
//		alert(blog_bno);
//		console.write(userid);

		//로그인 상태여부 검사
		
		if(userid==""){
			alert("블로그를 찜 하려면 로그인이 필요 합니다")
			return false;
		}
		
		$.ajax({
			type:'post',
			data:{userid:userid, blog_bno:blog_bno},
			url:"/member/favorite.do",
			success: function(response){
				alert("찜한 블로그를 마이페이지에 추가 완료");
			},error:function(){
				alert("오류발생");
			}
		})
	})
</script>	
<%@ include file="/fragments/footer.jsp" %>



</div><!-- wrapBody -->