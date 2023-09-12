package com.mat.zip.boss.model;

public class LikesVO {
    private String user_id;
    private int board_id;
    
    // getters and setters
	public String getUser_id() {
		return user_id;
	}
	
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	@Override
	public String toString() {
		return "LikesVO [user_id=" + user_id + ", board_id=" + board_id + "]";
	}
  
}

