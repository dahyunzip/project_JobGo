package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.MemberService;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService mService;

	// 회원가입
	// http://localhost:8088/member/join
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public void memberJoinGET() {
		logger.debug(" /join -> memberJoinGet() 실행! ");
		logger.debug("/views/member/join.jsp 페이지 이동");
	}
	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String memberJoinPOST(@ModelAttribute MemberVO vo) {
		logger.debug(" /join -> memberJoinPOST 실행 !");
		logger.debug("vo : " + vo);
		
		mService.memberJoin(vo);
		logger.debug("회원가입 성공!");
		
		return "redirect:/member/login";
	}
	
	// 로그인
	// http://localhost:8088/member/login
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String memberLoginGET() {
		logger.debug(" /login -> memberLoginGet() 실행! ");
		logger.debug("/views/member/Login.jsp 페이지 이동");
		
		return "/member/login";
	}
	
	// 로그인
	// http://localhost:8088/member/login
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String memberLoginPOST(MemberVO loginVO, HttpSession session) {
		logger.debug(" /login -> memberLoginPOST() 실행! ");
		logger.debug(" loginVO : " + loginVO );
		
		MemberVO resultVO = mService.memberLoginCheck(loginVO);
		logger.debug(" resultVO : " + resultVO );
		
		if(resultVO == null) {
			logger.debug("로그인 실패");
			return "redirect:/member/login";
		}
		logger.debug("@@@@ SUCCESS || 로그인 성공");
		
		session.setAttribute("id", resultVO.getUserid());
		
		return "redirect:/";
	}
	
	// 로그아웃
	// http://localhost:8088/member/logout
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String memberLogoutGET(HttpSession session) {
		logger.debug(" /member/logout -> memberLogoutGET() 실행 ");
		
		// 로그인 정보를 제거 => 세션 정보 초기화
		session.invalidate();
		logger.debug("세션 정보 초기화, 로그아웃 성공!");
		return "redirect:/";
	}
	
}
