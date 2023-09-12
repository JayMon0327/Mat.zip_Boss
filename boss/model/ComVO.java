package com.mat.zip.boss.model;

public class ComVO {
	private int board_id;
	private int reply_id;
	private String writer;
	private String content;
	private java.sql.Timestamp regdate;

	// getters and setters
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

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	@Override
	public String toString() {
		return "ComVO [board_id=" + board_id + ", reply_id=" + reply_id + ", writer=" + writer + ", content=" + content
				+ ", regdate=" + regdate + "]";
	}

}
