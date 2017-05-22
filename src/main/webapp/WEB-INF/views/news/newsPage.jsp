<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/headTag.jsp" %>
<style type="text/css">
.news-wrap{
	border-radius:10px !important;
    /* margin: -1px 10px; */
    margin-left: 36px;
    padding: 22px;
}

</style>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<section id="news" class="section">
	<div class="section-header">
		<h2 class="page-header"><i class="fa fa-newspaper-o" aria-hidden="true"></i>관련 뉴스</h2>
		<span class="help-block"><i class="fa fa-share-alt"></i>자기계발 관련 최신 뉴스들을 열람해보세요</span>
	</div>
	<div class="section-body">
		<div class="row">
			<div class="col-md-11 col-sm-12 col-xs-12 well news-wrap">
				<%@ include file="../news/newsList.jsp" %>	
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>