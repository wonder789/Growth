<%@ page pageEncoding="utf-8"%>
<%@ include file="include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.carousel-heading{
		font-size:25px;
	}
	.carousel-desc-list{
		list-style:none;
		text-align:left;
	}
	.side-menu-wrap{
		padding: 7px 25px !important;
	}
	.side-menu-header .fa{
		margin-right:10px;
	}
	.side-menu-list{
		list-style: none;
    	padding: 0;
	}
	.side-menu-list > li{
		margin-bottom:15px;
	}
	.menu-list-item > a{
		color : black;
		font-size:14px;
		font-weight:bold;
	}
	.menu-list-item .rank{
		margin-right:4px;
	}
</style>
<%@ include file="include/headTag.jsp" %>
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
		
		$('.carousel').carousel({
		    interval: false
		}); 
		/* openApiCall(); */
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
	
	function openApiCall(){
		var apiKey = "3736313937363732343335393132303738";
		$.ajax({
			url :'http://openapi.mnd.go.kr/xml/DS_TB_MND_ND_QLFCOFAPRV_APLEXM/1/5/',
			type : 'GET',
			dataType: 'jsonp',
		    jsonpCallback: "myCallback",
			success : function(result){
				console.log(result);
			}
		});
		$.getJSON('http://openapi.mnd.go.kr/3736313937363732343335393132303738/xml/DS_TB_MND_ND_QLFCOFAPRV_APLEXM/1/5/', function(result){
			console.log(result);
		});
	}
</script>
</head>
<body>
	<%@ include file="include/header.jsp" %>
	
				<!-- Carousel
		================================================== -->
			<div class="row">
				<div id="main-image-slide" class="carousel slide col-md-8" data-ride="carousel">
				  <!-- Indicators -->
				  <ol class="carousel-indicators">
					<li data-target="#main-image-slide" data-slide-to="0" class="active"></li>
					<li data-target="#main-image-slide" data-slide-to="1"></li>
					<li data-target="#main-image-slide" data-slide-to="2"></li>
				  </ol>
				  <div class="carousel-inner" role="listbox">
					<div class="item active">
					<img class="second-slide" src="${pageContext.request.contextPath }/img/banner1.jpg" alt="Second slide">
					  <div class="container">
						<div class="carousel-caption">
						  <h1 class="carousel-heading">국방분야 - 국가자격검정 <br />응시자격 및 시험일정</h1>
						  	* 헬기정비사 <br /> 육군 헬기정비 특기병과정, 부사관(초, 중, 고급반) 과정이수 후 <br />1년 이상 실무경력이 있는자<br/>
						  	* 심해잠수사 <br /> 해군 해난구조 과정(장교, 부사관, 병) 과정 이수 후 <br />  1년 이상 실무경력<br />
						  	* 항공장구관리사 <br /> 공군 항공장구관리 부사관(초, 중, 고급반) 과정 이수 후 <br /> 1년 이상 실무경력<br />
						  <p>
						  
						  <span>2016.07.04 ~ 2017.07.22</span>
						  </p>
						  </div>
					  </div>
					</div>
					<div class="item">
					  <img class="second-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Second slide">
					  <div class="container">
						<div class="carousel-caption">
						  <h1>광고1</h1>
						</div>
					  </div>
					</div>
					<div class="item">
					  <img class="third-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Third slide">
					  <div class="container">
						<div class="carousel-caption">
						  <h1>광고2</h1>
						</div>
					  </div>
					</div>
				  </div>
				 <a class="left carousel-control" data-slide="prev" href="#gallery-carousel">
					<i class="fa fa-angle-left" aria-hidden="true"></i>
					<span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" data-slide="next" href="#gallery-carousel">
					<i class="fa fa-angle-right" aria-hidden="true"></i>
					<span class="sr-only">Next</span>
				  </a>
				</div><!-- /.carousel -->
				<div class="col-md-4">
					<div class="side-menu-wrap well">
						<div class="side-menu-header">
							<h5><i class="fa fa-line-chart" aria-hidden="true"></i>유저 활동 랭킹</h5>
						</div>
						<ul class="side-menu-list">
							<c:forEach items="${userList }" var="user" varStatus="status">
									<li class="menu-list-item"><a href="#"><span class='rank'>${status.index +1 }위</span>  <img src="${pageContext.request.contextPath }/image.do?id=${user.photo}" 
											alt="" class="user-image circular-square" />${user.gradeNm} ${user.name }</a><span class="pull-right">${user.point }점 </span></li>
							</c:forEach>
							
						</ul>
					</div>
				</div>
			</div>
			
			
						
				<section id="post" class="section">
					<div class="section-header">
						<h2 class="page-header text-center"><i class="fa fa-bookmark" aria-hidden="true"></i>인기 포스트</h2>
						<div class="section-header-right">
							<a href="${ pageContext.request.contextPath }/post/postPage.do" id="refresh-btn" class="btn btn-primary" >
								<i class="fa fa-plus"></i>더보기</a>
						</div>
					</div>
					<div class="section-body">
						<div class="post-list">
							
						</div>
					</div>
					
				</section><!-- board-->
				
				<section id="news" class="section">
				<div class="section-header">
					<h2 class="page-header text-center"><i class="fa fa-newspaper-o" aria-hidden="true"></i>관련 뉴스</h2>
				</div>
				<div class="section-body">
					<div class="row">
						<div class="col-md-pull-1 col-md-10 col-md-push-1 col-sm-12 col-xs-12">
							<%@ include file="news/newsList.jsp" %>	
						</div>
					</div>
				</div>
					
					
				</section> <!-- news -->
				
<%@ include file="include/footer.jsp" %>
