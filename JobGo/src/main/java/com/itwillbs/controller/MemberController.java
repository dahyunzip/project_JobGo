package com.itwillbs.controller;

import javax.inject.Inject;

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
}
