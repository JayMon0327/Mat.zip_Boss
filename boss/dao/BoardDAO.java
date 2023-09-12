package com.mat.zip.boss.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mat.zip.boss.model.BoardVO;

//테이블 하나당 DAO 하나 ! -->CUD를 완성 !! 
@Component
public class BoardDAO {
	
	@Autowired
	SqlSessionTemplate my;
	

	public int insert(BoardVO bag) {
		int result = my.insert("board.create", bag);
		return result;
	}
	public int update(BoardVO bag) {
		int result = my.update("board.up", bag);
		return result;
	}
	
	public int delete(int board_id) {
		int result = my.update("board.del", board_id);
		return result;
		
	}
	
	//게시판 검색 게시글숫자
	public BoardVO one(int board_id) {
		BoardVO bag = my.selectOne("board.one", board_id);
		return bag;
	}
	
	// 게시판 검색
	public List<BoardVO> searchByTitleOrContent(String keyword) {
	    return my.selectList("board.searchByTitleOrContent", keyword);
	}


	
	//게시판 상세페이지
	public BoardVO detail(int board_id) {
		BoardVO bag = my.selectOne("board.detail", board_id);
		return bag;
	}
	
	// 게시판과 게시판페이징처리 
	public List<BoardVO> list(int limit, int offset) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("limit", limit);
	    params.put("offset", offset);
	    return my.selectList("board.list", params);
	}
	
	public int count() {
        return my.selectOne("board.count");
    }

	
	//조회수
	public int view(int board_id) {
		int result = my.update("board.view",board_id);
		return result;
	}
	
	//좋아요버튼 관련 아래로 6개
	public void increaseLikeCount(int board_id) {
	    my.update("board.increaseLikeCount", board_id);
	}
	public void decreaseLikeCount(int board_id) {
        my.update("board.decreaseLikeCount", board_id);
    }

    public void addLike(String user_id, int board_id) {
        Map<String, Object> params = new HashMap<>();
        params.put("user_id", user_id);
        params.put("board_id", board_id);
        my.insert("board.addLike", params);
    }

    public void removeLike(String user_id, int board_id) {
        Map<String, Object> params = new HashMap<>();
        params.put("user_id", user_id);
        params.put("board_id", board_id);
        my.delete("board.removeLike", params);
    }

    public boolean isLikedByUser(String user_id, int board_id) {
        Map<String, Object> params = new HashMap<>();
        params.put("user_id", user_id);
        params.put("board_id", board_id);
        return my.selectOne("board.isLikedByUser", params);
    }
    
    public int getLikeCount(int board_id) {
        return my.selectOne("board.getLikeCount", board_id);
    }
    //좋아요 기능 끝.
}

	
	

