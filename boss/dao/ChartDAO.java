package com.mat.zip.boss.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mat.zip.boss.model.ChartVO;
import com.mat.zip.boss.model.return_CustomerCountVO;
import com.mat.zip.boss.model.return_OrderCountVO;
import com.mat.zip.boss.model.return_OrderTotalVO;

@Repository
public class ChartDAO {

    private final SqlSession sqlSession;

    @Autowired
    public ChartDAO(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }
// 최근 7일 매출
    public List<ChartVO> DailyTotalAmount(String storeId) {
        return sqlSession.selectList("chartMapper.DailyTotalAmount",storeId);
    }
    
// 한달전 7일 매출
    public List<ChartVO> XTotalAmount(String storeId) {
    	return sqlSession.selectList("chartMapper.XTotalAmount",storeId);
    }
    
// 2달전 7일 매출
    public List<ChartVO> twoTotalAmount(String storeId) {
    	return sqlSession.selectList("chartMapper.twoTotalAmount",storeId);
    }
    
//  이번달 총 매출
    public List<ChartVO> thisMonthTotalAmount(String storeId) {
        return sqlSession.selectList("chartMapper.thisMonthTotalAmount",storeId);
    }
    
//  저번달 총 매출
    public List<ChartVO> lastMonthTotalAmount(String storeId) {
        return sqlSession.selectList("chartMapper.lastMonthTotalAmount",storeId);
    }
    
//	2달전 총 매출
    public List<ChartVO> twoMonthsAgoTotalAmount(String storeId) {
        return sqlSession.selectList("chartMapper.twoMonthsAgoTotalAmount", storeId);
    } 
    
 // 재방문율 차트
 // 재방문 차트 이번달과 저번달 신규고객과 재방문 고객의 숫자를 찾는 쿼리
    public return_CustomerCountVO findthisMonthNewCustomers(String storeId){
        return sqlSession.selectOne("chartMapper.findthisMonthNewCustomers", storeId);
    }

    public return_CustomerCountVO findthisMonthReturningCustomers(String storeId){
        return sqlSession.selectOne("chartMapper.findthisMonthReturningCustomers", storeId);
    }
    public return_CustomerCountVO findLastMonthNewCustomers(String storeId){
    	return sqlSession.selectOne("chartMapper.findLastMonthNewCustomers", storeId);
    }
    
    public return_CustomerCountVO findLastMonthReturningCustomers(String storeId){
    	return sqlSession.selectOne("chartMapper.findLastMonthReturningCustomers", storeId);
    }

    // 여러번 주문한(2-5) 고객님들 수 찾기
    public return_OrderCountVO find2Customers(String storeId){
        return sqlSession.selectOne("chartMapper.find2Customers", storeId);
    }

    public return_OrderCountVO find3Customers(String storeId){
        return sqlSession.selectOne("chartMapper.find3Customers", storeId);
    }

    public return_OrderCountVO find4Customers(String storeId){
        return sqlSession.selectOne("chartMapper.find4Customers", storeId);
    }

    public return_OrderCountVO find5Customers(String storeId){
        return sqlSession.selectOne("chartMapper.find5Customers", storeId);
    }

    // 신규고객과 재방문 고객들이 주문한 총 금액
    public return_OrderTotalVO thisMonthNewCustomerOrderTotal(String storeId){
        return sqlSession.selectOne("chartMapper.thisMonthNewCustomerOrderTotal", storeId);
    }

    public return_OrderTotalVO thisMonthReturnCustomerOrderTotal(String storeId){
        return sqlSession.selectOne("chartMapper.thisMonthReturnCustomerOrderTotal", storeId);
    }
    public return_OrderTotalVO lastMonthNewCustomerOrderTotal(String storeId){
    	return sqlSession.selectOne("chartMapper.lastMonthNewCustomerOrderTotal", storeId);
    }
    
    public return_OrderTotalVO lastMonthReturnCustomerOrderTotal(String storeId){
    	return sqlSession.selectOne("chartMapper.lastMonthReturnCustomerOrderTotal", storeId);
    }
    

}
