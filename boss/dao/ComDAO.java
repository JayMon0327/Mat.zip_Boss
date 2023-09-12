package com.mat.zip.boss.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mat.zip.boss.model.ComVO;

@Component
public class ComDAO {

	@Autowired
	SqlSessionTemplate my;

	//board_insertcom 에서 사용
	public int insert(ComVO bag) {
		int result = my.insert("com.create", bag);
		return result;
	} 

	public int update(ComVO bag) {
		int result = my.update("com.up", bag);
		return result;
	}

	public int delete(int com_id) {
		int result = my.update("com.del", com_id);
		return result;

	}

	public ComVO one(int board_id) {
		ComVO bag = my.selectOne("com.one", board_id);
		return bag;
	}

	// 댓글list
	public List<ComVO> list(int board_id) {
		List<ComVO> list = my.selectList("com.list", board_id);
		System.out.println(list.size());
		return list;

	} 
	
	//댓글개수세기
	public int getCommentCount(int boardId) {
	    return my.selectOne("com.count", boardId);
	}


}
