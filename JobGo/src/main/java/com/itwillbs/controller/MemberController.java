package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String memberJoinGET() {
		return "/member/join";
	}
	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String memberJoinPOST(MemberVO vo, RedirectAttributes rttr) throws Exception {
		mService.registerMember(vo);
		rttr.addFlashAttribute("msg", "joinSuccess");
		return "redirect:/member/login";
	}
	
	// 로그인
	// http://localhost:8088/member/login
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String memberLoginGET() {
		return "/member/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String memberLoginPOST(@RequestParam("userid") String userid,
								  @RequestParam("userpw") String userpw,
								  HttpSession session,
								  Model model,
								  RedirectAttributes rttr) throws Exception {
		
		MemberVO loginVO = mService.login(userid, userpw);
		
		if(loginVO != null && !loginVO.isDeleted()) {
			session.setAttribute("userid", loginVO.getUserid());
			session.setAttribute("memberName", loginVO.getName());
			logger.info(" 로그인 성공 ");
			rttr.addFlashAttribute("msg", "loginSuccess");
			return "redirect:/";
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
			return "";
		}
	}
	
	// 로그아웃
	// http://localhost:8088/member/logout
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String memberLogoutGET(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/mypage", method=RequestMethod.GET)
	public String memberInfoGET(HttpSession session, Model model) throws Exception{
		String memberId = (String) session.getAttribute("userid");
		MemberVO userVO = mService.getMember(memberId);
		model.addAttribute("user", userVO);
		return "/member/mypage";
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String memberModifyGET(HttpSession session, Model model) throws Exception{
		String memberId = (String) session.getAttribute("userid");
		MemberVO userVO = mService.getMember(memberId);
		model.addAttribute("user", userVO);
		return "/member/modify";
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String memberModifyPOST(MemberVO vo, RedirectAttributes rttr) throws Exception{
		logger.debug(" memberModifyPOST(MemberVO vo) 실행!");
		logger.debug("vo : " + vo);
		mService.modifyMember(vo);
		rttr.addFlashAttribute("msg", "modifySuccess");
		return "redirect:/member/mypage";
	}
	
}
