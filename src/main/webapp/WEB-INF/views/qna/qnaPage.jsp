<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/headTag.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	loadQnaList();
	
	$(".tag").click(function(){
		var $target      = $(this);
		var $activeTag   = null;
		var searchObject = null;
		var tagList      = [];
		
		$target.toggleClass("active");
		
		$activeTag = $(".tag.active");
		
		
		$activeTag.each(function(){
			tagList.push( $(this).text().trim() );
		});
		
		searchObject = {
			searchCondition : "tagName",
			tag : tagList.join(",")
		};
		
		loadQnaList(searchObject, true);
		
	});
	
	$("#refresh-btn").click(function(){
		$(".tag").removeClass("active");
		loadPostList( null, true );
	});
	
	$(".search-query").keypress(function(event){
		if( event.keyCode == 13 ){
			loadPostList({
				searchCondition : "keyword",
				searchKeyword   : $(this).val().trim()
			}, true);
			$(this).val('');
		}
	});
});

function loadQnaList( searchObject , reload ){
	var $qnaList     = $(".qna-list");
	var $cards   	  = $qnaList.find(".card-wrap");
	var isAsync  	  = $cards.size() > 0 ? true : false;
	
	searchObject = searchObject || {};
	
	if( reload ){
		$qnaList.empty();
	}
	$.ajax({
		url : '${pageContext.request.contextPath}/qna/qnaList.do',
		type : 'post',
		async : isAsync,
		data : searchObject,
	 	success : function(result){
			$qnaList.append( result );
		}
	});
}
</script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<section class="section" id="qna">
	<div class="section-header">
		<h2 class="page-header"><i class="fa fa-bookmark" aria-hidden="true"></i>질의응답</h2>
		<div class="section-header-right">
			<a href="#" id="refresh-btn" class="btn btn-primary" >
				<i class="fa fa-list"></i>전체보기</a>
			<sec:authorize access="isAuthenticated()">
				<a href="${pageContext.request.contextPath}/qna/qnaWritePage.do" id="write-btn" class="btn btn-success" >
					<i class="fa fa-pencil" aria-hidden="true"></i>작성하기</a>
			</sec:authorize>
		</div>
		<span class="help-block"><i class="fa fa-share-alt"></i>자격증,대외활동,운동 등 궁금한사항을 동료 전우에게  질문해보세요</span>
		<div class="form-search search-only clearfix">
                <i class="search-icon glyphicon glyphicon-search"></i>
               	<input type="text" class="form-control search-query" name="searchKeyword" placeholder="검색하실 내용일 입력하세요">
             </div>
		<div class="tag-list well">
			<c:forEach items="${hashTagList }" var="tagItem">
				<a href="#" class="tag"><i class="fa fa-hashtag"></i>${tagItem }</a>
			</c:forEach>
			
		</div>
	</div>
	<div class="section-body">
		<div class="qna-list">
			
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>