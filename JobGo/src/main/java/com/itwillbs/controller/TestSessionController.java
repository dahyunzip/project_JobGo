package com.itwillbs.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/test")
public class TestSessionController {

	// 관리자 세션 강제 생성
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String adminSession(HttpSession session) {
		session.setAttribute("userid", "adminTest");
		session.setAttribute("membertype", "A");
		session.setAttribute("name", "관리자 테스트");
		session.setAttribute("id", 2); // 관리자 id 임시 값
		session.setAttribute("adminId", 2);
		return "redirect:/notice/list";
	}

	// 일반 회원 세션 강제 생성
	@RequestMapping(value="/user", method=RequestMethod.GET)
	public String userSession(HttpSession session) {
		session.setAttribute("userid", "userTest");
		session.setAttribute("membertype", "G"); // 일반회원
		session.setAttribute("name", "일반테스트");
		return "redirect:/notice/list";
	}

	// 기업 회원 세션 강제 생성
	@RequestMapping(value="/corp", method=RequestMethod.GET)
	public String corpSession(HttpSession session) {
		session.setAttribute("userid", "corpTest");
		session.setAttribute("membertype", "C"); // 기업회원
		session.setAttribute("name", "기업테스트");
		return "redirect:/notice/list";
	}

	// 세션 초기화
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/notice/list";
	}
}
