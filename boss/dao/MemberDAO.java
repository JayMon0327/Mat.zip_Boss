package com.mat.zip.boss.dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mat.zip.boss.model.MemberVO;

@Repository
public class MemberDAO {
    @Autowired
    SqlSession sqlSession;
    
    @Autowired
	SqlSessionTemplate my;
    
    public MemberVO login(MemberVO bag) {
		return my.selectOne("member.member_login", bag);

	}
}
