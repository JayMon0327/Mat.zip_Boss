//package com.mat.zip.boss.controller;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import com.mat.zip.boss.dao.Boss_memberDAO;
//import com.mat.zip.boss.model.Boss_memberVO;
//import com.mat.zip.mzMember.model.MzMemberDAOImpl;
//import com.mat.zip.mzMember.model.MzMemberDTO;
//import com.mat.zip.mzMember.service.MzMemberserviceImpl;
//
// 로그인을 담당하는 컨트롤러 였으나, 로그인 담당하는 팀원에게 코드 넘겨줌.

//	@Controller
//	public class Boss_memberController {
//	    @Autowired
//	    Boss_memberDAO dao;
//	    @Autowired
//	    MzMemberDAOImpl dao2;
//	    
//	    @GetMapping("/boss_login")
//	    public String loginPage(HttpServletRequest request, HttpSession session) {
//	        // 로그인 페이지에 접근하기 전의 페이지 URL을 세션에 저장
//	        String referrer = request.getHeader("Referer");
//	        session.setAttribute("prevPage", referrer);
//
//	        // 로그인 페이지 뷰를 반환
//	        return "boss_login";
//	    }

//	    @PostMapping("/boss/member_login")
//	    public String member_login(MemberVO bag, HttpSession session, HttpServletRequest request, Model model) {
//	        System.out.println(bag + "login실행됨");
//	        
//	        // Member 테이블 로그인
//	        MemberVO vo = dao2.login(bag);
//	        
//	        // Boss_member 테이블 로그인
//	        Boss_memberVO bossBag = new Boss_memberVO();
//	        bossBag.setUser_id(bag.getUser_id());
//	        bossBag.setPassword(bag.getPassword());
//	        Boss_memberVO bossVo = dao.login(bossBag);
//
//	        // member 또는 boss 테이블 중 하나라도 로그인 성공 시
//	        if (vo != null || bossVo != null) {
//	            if (vo != null) {
//	                // Member 로그인 성공 시, user_id와 nickName을 세션에 저장
//	                session.setAttribute("user_id", vo.getUser_id());
//	                session.setAttribute("nickName", vo.getNickName());
//	            }
//
//	            if (bossVo != null) {
//	                // Boss_member 로그인 성공 시, boss_id와 store_id를 세션에 저장
//	                session.setAttribute("boss_id", bossVo.getUser_id());
//	                session.setAttribute("store_id", bossVo.getStore_id());
//	            }
//
//	            // 로그인 성공 후 이전 페이지로 리다이렉트
//	            String prevPage = (String) session.getAttribute("prevPage");
//	            if (prevPage != null) {
//	                return "redirect:" + prevPage;
//	            } else {
//	                // 이전 페이지 정보가 없는 경우, 기본 페이지로 리다이렉트
//	                return "redirect:board_index.jsp";
//	            }
//	        } else {
//	            model.addAttribute("msg", "로그인에 실패했습니다. 다시 시도해주세요.");
//	            return "forward:boss_login.jsp";
//	        }
//	    }

//	    @GetMapping("/boss/logout")
//	    public String logout(HttpSession session) {
//	        // 모든 세션 제거
//	        session.invalidate();
//	        return "redirect:board_index.jsp"; // 로그아웃 후 리다이렉트 될 페이지
//	    }
//
//	} 
	    
	    //사장회원등록 메서드 
//	    @PostMapping("/boss/innerJoinAndInsert")
//	    public String innerJoinAndInsert(@RequestParam String store_id, HttpSession session) {
//	    	// 세션에서 현재 로그인한 사용자의 ID를 가져옵니다.
//	    	String user_id = (String) session.getAttribute("user_id");
//
//	    	// bag에 사용자 ID와 store_id를 저장합니다.
//	    	Boss_memberVO bag = new Boss_memberVO();
//	    	bag.setUser_id(user_id);
//	    	bag.setStore_id(store_id);
//
//	    	// member 테이블과 bossmember 테이블을 inner join해서 회원가입 처리를 합니다.
//	    	dao.innerJoinAndInsert(bag);
//	    	// 이제 이 사용자는 사장님 계정으로도 로그인되어 있으므로, 'boss_id' 세션에도 사용자 ID를 저장합니다.
//	        session.setAttribute("boss_id", user_id);
//	        // log 확인용 (삭제가능)
//	    	System.out.println("사장회원가입완료");
//	    	 System.out.println("store_id: " + store_id);
//	    	// 회원가입 처리가 완료되면 메인 페이지로 리다이렉트합니다.
//	    	return "forward:board_index.jsp";
//	    }
	    




