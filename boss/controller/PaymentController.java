package com.mat.zip.boss.controller;

import com.google.gson.JsonObject;
import com.mat.zip.boss.dao.Boss_memberDAO;
import com.mat.zip.boss.dao.PaymentDAO;
import com.mat.zip.boss.model.Boss_memberVO;
import com.mat.zip.boss.model.PaymentVO;
import com.mat.zip.boss.service.MemberAndPaymentService;
import com.mat.zip.boss.service.PaymentService;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping("/boss")
public class PaymentController {
    @Autowired
    PaymentService paymentService;
    @Autowired
    PaymentDAO dao;
    @Autowired
    Boss_memberDAO bossdao;
    @Autowired
    MemberAndPaymentService memberAndPaymentService; //회원등록과 결제하기 트랜잭션
    @Autowired
    HttpSession session;  // 세션을 사용하기 위해 주입

    //결제전 중복체크
    @PostMapping("/checkStoreId")
    @ResponseBody
    public String checkStoreId(@RequestParam String storeId) {
        int count = bossdao.checkStoreId(storeId);
        if (count > 0) {
            return "1";  // "중복"
        } else {
            return "0";  // "사용 가능"
        }
    }
    
    //결제하기 성공 and 실패
    @GetMapping("/tossSuccess")
    public String processPayment(@RequestParam("paymentKey") String paymentKey, @RequestParam("amount") int amount, @RequestParam("orderId") String orderId, Model model) {
        // 결제를 처리하고 그 결과를 받습니다.
        JsonObject paymentResponse = paymentService.processPayment(paymentKey, amount, orderId);

        // 결제가 성공했다면, success 페이지로 리다이렉트합니다.
        if (paymentResponse != null) {
            // 결제 응답 정보를 model에 추가합니다.
            model.addAttribute("paymentResponse", paymentResponse);
            return "/boss/tossSuccess";
        }
        // 결제가 실패했다면, fail 페이지로 리다이렉트합니다.
        else {
            return "/boss/tossFail";
        }
    }
    
    // 결제 실패 처리
    @GetMapping("/tossFail")
    public String processPaymentFail() {
        return "/boss/tossFail";
    }
    
    // 결제 후 실행 회원등록, 결제내역DB등록
    // 회원등록
    @PostMapping("/innerJoinAndInsert")
    public String innerJoinAndInsert(@RequestParam String store_id, HttpSession session, Model model) {
    	String user_id = (String) session.getAttribute("user_id");
    	Boss_memberVO member = new Boss_memberVO();
    	member.setUser_id(user_id);
    	member.setStore_id(store_id);
    	
    	int count = bossdao.checkStoreId(store_id);
    	if (count > 0) {
    		model.addAttribute("error", "중복된 상점 ID입니다.");
    		return "1";  
    	}
    	
    	memberAndPaymentService.registerAndPay(member);
    	
    	//성공시 사장세션부여
    	String boss_id = member.getUser_id();
    	session.setAttribute("boss_id", boss_id);
    	
    	return "/boss/tossSuccess";
    }
    
    //결제내역 DB등록
    @PostMapping("/payment")
    public ResponseEntity<String> insert(@RequestBody PaymentVO bag) {

        String orderName = bag.getOrderName();
        String[] parts = orderName.split(" ", 2);
        bag.setStoreId(parts[0]);  // storeId에 parts[0] 설정
        bag.setOrderName(parts[1]);  // orderName에 parts[1] 설정
        
        String userId = (String) session.getAttribute("user_id"); // 세션에서 user_id를 가져옴
        bag.setOrderId(userId);
        dao.insert(bag);
        return ResponseEntity.ok().body("결제 정보가 성공적으로 전송되었습니다.");
    }
}


 

    




