<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.help-block{
		
	}
	.help-block i.fa{
		margin-right:10px;
	}
	
	.tag{
	    display: inline-block;
	    padding: 5px;
	    border-radius: 10px;
	    border: 1px solid #ddd;
	}
	
	.tag .fa{
		margin-right:5px;
	}
	
	
	/* fluid 5 columns */
	.card-sizer,
	.card-wrap {
		 width: 23%;
		 margin-bottom:30px;
	 }
	/* 2 columns */
	.card-wrap--width2 {
		 width: 40%;
    }
	.card-gutter-sizer{
		width:1%;
	}
	.card-wrap{
	    border-radius: 10px;
	    border: 1px solid #ddd;
	    padding: 10px;
	    box-shadow: 1px 1px 1px 0px #ddd;
	}
	.card-content{
		height:100px;
		overflow:hidden;
	}
	.card-thumbnail{
		width:100%;
	}
	.card-desc i.fa{
		margin-right:5px;
	}
	.card-desc .seperate{
		margin-right:10px;
	}
	.btn .fa{
		margin-right:5px;
	}
	a.tag:hover , a.tag.active{
		background:#3bafda;
		color:white;
	}
	
	/* Large devices (large desktops, 1200px and up) */
	@media (min-width: 1200px ) {
		/* fluid 5 columns */
		.card-sizer,
		.card-wrap {
			 width: 23% !important;
		 }
		/* 2 columns */
		.card-wrap--width2 {
			 width: 40%;
	    }
	}
	
	@media( max-width : 480px ){
		.card-sizer,
		.card-wrap {
			 width: 100%;
		 }
	}
		/*태블릿 및 PC*/
	@media( max-width : 767px ){
	      /* fluid 5 columns */
		.card-sizer,
		.card-wrap {
			 width: 100% !important;
		 }
	}
	/*태블릿과 PC 중간 구역*/
	@media( min-width : 767px ) and (max-width:992px){
	    /* fluid 5 columns */
		.card-sizer,
		.card-wrap {
			 width: 47% !important;
		 }
	}
	
	/* Medium devices (desktops, 992px and up) */
	/*PC시작*/
	@media (min-width: 992px) and ( max-width:1200px) {
		.card-sizer,
		.card-wrap {
			 width: 31% !important;
		 }
	}
	
</style>
<%@ include file="../include/headTag.jsp" %>
<script type="text/javascript">
	var $masonryWrap = null;
	var masonryOption  = {
		  // set itemSelector so .grid-sizer is not used in layout
		  itemSelector: '.card-wrap',
		  // use element for option
		  columnWidth: '.card-sizer',
		  percentPosition: true,
		  gutter      : 30,
		  horizontalOrder: true
	};
	$(document).ready(function(){
		$masonryWrap = $(".post-list").masonry(masonryOption).imagesLoaded(function(){
			$masonryWrap.masonry('layout');
		});
		loadPostList();
		
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
			
			loadPostList(searchObject, true);
			
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
	
	function loadPostList( searchObject , reload ){
		var $postTemplate = $("#post-template");
		var $postList     = $(".post-list");
		var $cards   	  = $postList.find(".card-wrap");
		var isAsync  	  = $cards.size() > 0 ? true : false;
		
		searchObject = searchObject || {};
		
		if( reload ){
			$postList.empty();
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/post/postList.do',
			type : 'post',
			async : isAsync,
			data : searchObject,
		 	success : function(result){
				$masonryWrap.append( result );
				$masonryWrap.masonry('reloadItems').imagesLoaded(function(){
					$masonryWrap.masonry('layout');
				});
			}
		});
	}
</script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
	
	<section class="section" id="post">
		<div class="section-header">
			<h2 class="page-header"><i class="fa fa-bookmark" aria-hidden="true"></i>포스트</h2>
			<div class="section-header-right">
				<a href="#" id="refresh-btn" class="btn btn-primary" >
					<i class="fa fa-list"></i>전체보기</a>
				<sec:authorize access="isAuthenticated()">
					<a href="${pageContext.request.contextPath}/post/postWritePage.do" id="write-btn" class="btn btn-success" >
						<i class="fa fa-pencil" aria-hidden="true"></i>작성하기</a>
				</sec:authorize>
			</div>
			<span class="help-block"><i class="fa fa-share-alt"></i>당신의 경험담, 공부법, 운동법, 자기계발 정보 등을 자유롭게 포스팅해보세요</span>
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
			<div class="post-list">
				
			</div>
		</div>
	</section>

	
<%@ include file="../include/footer.jsp" %>