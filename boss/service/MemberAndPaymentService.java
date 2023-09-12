package com.mat.zip.boss.service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mat.zip.boss.dao.Boss_memberDAO;
import com.mat.zip.boss.model.Boss_memberVO;

@Service
public class MemberAndPaymentService {

    private final Boss_memberDAO memberDAO;

    @Autowired
    public MemberAndPaymentService(Boss_memberDAO memberDAO, PaymentService paymentService) {
        this.memberDAO = memberDAO;
    }

    @Transactional
    public void registerAndPay(Boss_memberVO member) {
        // 회원 정보 저장
        memberDAO.innerJoinAndInsert(member);
    }
}

