<%@ page pageEncoding="utf-8"%>
<%@ include file="../include/header.jsp" %>
	
	<section class="section" id="signup">
		<div class="row">
			<div class="col-md-6 col-md-pull-3 col-md-push-3 col-sm-8 col-sm-pull-2 col-sm-push-2">
				<form class="form-horizontal well">
				  <div class="form-header">
				  	
				  </div>
				  <div class="form-group">
				    <label for="email" class="col-sm-2 control-label">이메일</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="password" class="col-sm-2 control-label">비밀번호</label>
				    <div class="col-sm-10">
				      <input type="password" class="form-control" id="password" placeholder="비밀번호를 입력하세요 ">
				    </div>
				  </div>
				  <!-- <div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <div class="checkbox">
				        <label>
				          <input type="checkbox"> Remember me
				        </label>
				      </div>
				    </div>
				  </div> -->
				  <div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <button type="submit" class="btn btn-default">Sign in</button>
				    </div>
				  </div>
			</form>
			</div>
			
		</div>
	</section>
	
<%@ include file="../include/footer.jsp" %>