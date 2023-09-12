package com.mat.zip.boss.model;

public class return_CustomerCountVO {

	private String store_id;
	private int new_customers;
	private int returning_customers;
	
	public int getNew_customers() {
		return new_customers;
	}
	public void setNew_customers(int new_customers) {
		this.new_customers = new_customers;
	}
	public int getReturning_customers() {
		return returning_customers;
	}
	public void setReturning_customers(int returning_customers) {
		this.returning_customers = returning_customers;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
    
	
    
}
