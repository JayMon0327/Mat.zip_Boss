package com.mat.zip.boss.model;

public class return_OrderCountVO {

	private String store_id;
	private int twoOrderCustomers;
    private int threeOrderCustomers;
    private int fourOrderCustomers;
    private int fiveOrderCustomers;
    
    public String getStore_id() {
    	return store_id;
    }
    public void setStore_id(String store_id) {
    	this.store_id = store_id;
    }
	public int getTwoOrderCustomers() {
		return twoOrderCustomers;
	}
	public void setTwoOrderCustomers(int twoOrderCustomers) {
		this.twoOrderCustomers = twoOrderCustomers;
	}
	public int getThreeOrderCustomers() {
		return threeOrderCustomers;
	}
	public void setThreeOrderCustomers(int threeOrderCustomers) {
		this.threeOrderCustomers = threeOrderCustomers;
	}
	public int getFourOrderCustomers() {
		return fourOrderCustomers;
	}
	public void setFourOrderCustomers(int fourOrderCustomers) {
		this.fourOrderCustomers = fourOrderCustomers;
	}
	public int getFiveOrderCustomers() {
		return fiveOrderCustomers;
	}
	public void setFiveOrderCustomers(int fiveOrderCustomers) {
		this.fiveOrderCustomers = fiveOrderCustomers;
	}
    
}
