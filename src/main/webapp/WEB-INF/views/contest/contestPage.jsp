<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/headTag.jsp" %>
<style type="text/css">
.contest-wrap{
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
		<h2 class="page-header"><i class="fa fa-bullhorn" aria-hidden="true"></i>공모전 정보</h2>
		<span class="help-block"><i class="fa fa-share-alt"></i>군인 공모전  정보들을 열람해보세요</span>
	</div>
	<div class="section-body">
		<div class="row">
			<div class="col-md-11 col-sm-12 col-xs-12 well contest-wrap">
				<%@ include file="../contest/contestList.jsp" %>	
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>