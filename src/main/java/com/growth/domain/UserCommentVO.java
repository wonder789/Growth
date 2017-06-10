package com.growth.domain;

public class UserCommentVO {
	private int commentId;
	
	private String userId;
	
	private String content;
	
	private String writerId;
	
	private String writerName;
	
	private int writerPhoto = -1;
	
	private int grpCommentId = -1;
	
	private int pCommentId = -1;
	
	private int grpOrder;
	
	private int level;
	
	private String regDate;
	
	private String modDate;
	
	
	
	
	
	
	public int getpCommentId() {
		return pCommentId;
	}

	public void setpCommentId(int pCommentId) {
		this.pCommentId = pCommentId;
	}

	public int getGrpCommentId() {
		return grpCommentId;
	}

	public void setGrpCommentId(int grpCommentId) {
		this.grpCommentId = grpCommentId;
	}

	public int getGrpOrder() {
		return grpOrder;
	}

	public void setGrpOrder(int grpOrder) {
		this.grpOrder = grpOrder;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getWriterPhoto() {
		return writerPhoto;
	}

	public void setWriterPhoto(int writerPhoto) {
		this.writerPhoto = writerPhoto;
	}

	public String getWriterName() {
		return writerName;
	}

	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}


	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	
	
}
