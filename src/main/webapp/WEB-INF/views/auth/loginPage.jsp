<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/jstlTag.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.signup-link{
		padding-left :20px;
	}
	.login-error{
		margin-left : 20px;
		color:red;
		
		font-weight:bold;
	}
</style>
<%@ include file="../include/headTag.jsp" %>
</head>
<body>
<%@ include file="../include/header.jsp" %>
	<section class="section" id="login">
		<div class="row">
			<div class="col-md-6 col-md-pull-3 col-md-push-3 col-sm-8 col-sm-pull-2 col-sm-push-2">
				<form class="form-horizontal well" action="/auth/login.do" method="POST" id="login-form" name='login_form'>
				  <div class="form-header">
				  	<h4 class="logo-header text-center">Growth</h4>
				  </div>
				  <div class="form-group">
				    <label for="email" class="col-sm-3 control-label">이메일</label>
				    <div class="col-sm-7">
				    	<div class="input-wrap">
				    		<input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="email" id="email-error"></label>
				    	</div>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="password" class="col-sm-3 control-label">비밀번호</label>
				    <div class="col-sm-7">
				    	<div class="input-wrap">
				      		<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요 ">
				      		<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				      		<label class="control-label" for="password" id="password-error"></label>
				    	</div>
				    </div>
				  </div>
				 <div class="form-group">
				 
				 	<div class="col-sm-offset-3">
				 		<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
						  	<c:if test="${ param.error != null  }">
						  		<span class="login-error">
						  			    <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>
						  		</span>
							    
						  	</c:if>
						</c:if>
				 	</div>
				 </div>
				  <div class="form-group">
				    <p class="col-sm-offset-3">
						<a  class="signup-link" href="${pageContext.request.contextPath}/auth/signupPage.do">아직 회원이 아니신가요?</a></br>
				    </p>
				  </div>
				  <div class="form-group">
				    <p class="text-center">
				    	<input type="submit" class="btn btn-primary" id="login-btn" value="로그인" />
				    </p>
				  </div>
				  
			</form>
			</div>
			
		</div>
	</section>
<%@ include file="../include/footer.jsp" %>