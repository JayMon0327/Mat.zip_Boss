package com.mat.zip.boss.model;

import java.util.Date;

public class PaymentResponse{
	private String paymentKey;
	private String orderId;
	private int amount;
	private int totalAmount;
	private String orderName;
	private Date requestedAt;
	
	public String getPaymentkey() {
		return paymentKey;
	}
	public void setPaymentkey(String paymentkey) {
		this.paymentKey = paymentkey;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public Date getRequestedAt() {
		return requestedAt;
	}
	public void setRequestedAt(Date requestedAt) {
		this.requestedAt = requestedAt;
	}
	
	
	
	
}