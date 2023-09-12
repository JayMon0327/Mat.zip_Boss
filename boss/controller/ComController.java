package com.mat.zip.boss.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mat.zip.boss.dao.BoardDAO;
import com.mat.zip.boss.dao.ComDAO;
import com.mat.zip.boss.model.BoardVO;
import com.mat.zip.boss.model.ComVO;

@Controller
public class ComController {

	@Autowired
	ComDAO comDAO;
	@Autowired
	BoardDAO BoardDAO;

	// 댓글 등록
	@RequestMapping("/boss/Board_insertcom")
	public void insert(ComVO bag, int board_id, Model model) {
		List<ComVO> list = comDAO.list(board_id);
		model.addAttribute("Com_list", list);
		comDAO.insert(bag);
	}

	// 댓글 수정
	@RequestMapping("/boss/Com_update")
	public void update(ComVO bag, HttpSession session) {
		String currentUserId = (String) session.getAttribute("user_id");
		ComVO existingComment = comDAO.one(bag.getReply_id());
		if (currentUserId.equals(existingComment.getWriter())) {
			comDAO.update(bag);
		} else {
			// 현재 사용자가 댓글 작성자와 일치하지 않는 경우 예외를 발생시킵니다.
			throw new RuntimeException("Only the original author can edit the comment.");
		}
	}

	@RequestMapping("/boss/Com_delete")
	public void delete(int reply_id, HttpSession session) {
		String currentUserId = (String) session.getAttribute("user_id");
		ComVO existingComment = comDAO.one(reply_id);
		if (currentUserId.equals(existingComment.getWriter())) {
			comDAO.delete(reply_id);
		} else {
			// 현재 사용자가 댓글 작성자와 일치하지 않는 경우 예외를 발생시킵니다.
			throw new RuntimeException("Only the original author can delete the comment.");
		}
	}



	@RequestMapping("Com_one")
	public void one(int Com_id, Model model) {
		ComVO bag = comDAO.one(Com_id);
		model.addAttribute("bag", bag);
	}
	
	@RequestMapping("Board_view")
	public String view(BoardVO bag, Model model, int board_id) {
	    // 게시글 정보를 불러옴
	    BoardVO board = BoardDAO.one(board_id);
	    model.addAttribute("bag", board);
	  
	    // 해당 게시글의 댓글 목록을 불러옴
	    List<ComVO> list = comDAO.list(board_id);
	    model.addAttribute("Com_list", list);
	  
	    return "Board_detail";
	}

}