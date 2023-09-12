package com.mat.zip.boss.model;

public class BoardVO {
	private int board_id;
	private String writer;
	private String title;
	private String content;
	private java.sql.Timestamp regdate;
	private java.sql.Timestamp updatedate;
	private java.sql.Timestamp deletedate;
	private int viewscount;
	private int likecount;
	private boolean liked;
	private int commentCount;
	
	// getters and setters

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public boolean isLiked() {
		return liked;
	}

	public void setLiked(boolean liked) {
		this.liked = liked;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public java.sql.Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(java.sql.Timestamp regdate) {
		this.regdate = regdate;
	}

	public java.sql.Timestamp getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(java.sql.Timestamp updatedate) {
		this.updatedate = updatedate;
	}

	public java.sql.Timestamp getDeletedate() {
		return deletedate;
	}

	public void setDeletedate(java.sql.Timestamp deletedate) {
		this.deletedate = deletedate;
	}

	public int getViewscount() {
		return viewscount;
	}

	public void setViewscount(int viewscount) {
		this.viewscount = viewscount;
	}

	public int getLikecount() {
		return likecount;
	}

	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}

	@Override
	public String toString() {
		return "BoardVO [board_id=" + board_id + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", regdate=" + regdate + ", updatedate=" + updatedate + ", deletedate=" + deletedate + ", viewscount="
				+ viewscount + ", likecount=" + likecount + "]";
	}

}
