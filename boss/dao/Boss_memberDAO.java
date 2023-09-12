package com.mat.zip.boss.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mat.zip.boss.model.Boss_memberVO;

@Component
public class Boss_memberDAO { // CRUD
	@Autowired
	SqlSessionTemplate my;

	public void innerJoinAndInsert(Boss_memberVO bag) {
        my.insert("boss.insertJoinedData", bag);
    }

	public Boss_memberVO login(Boss_memberVO bag) {
		return my.selectOne("boss.boss_login", bag);
		
	}
	public int checkStoreId(String storeId) {
        return my.selectOne("boss.checkStoreId", storeId);
    }


}
