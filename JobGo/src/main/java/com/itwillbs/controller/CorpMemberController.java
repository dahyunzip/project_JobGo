package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.service.CorpMemberService;

@Controller
@RequestMapping(value="/corp/*")
public class CorpMemberController {
	
	@Inject
	private CorpMemberService cService;
	
	// 기업회원 회원가입
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String corpJoinGET() {
		return "/corp/join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String corpJoinPOST(CorpMemberVO vo, RedirectAttributes rttr) throws Exception{
		cService.registerCorpMember(vo);
		rttr.addFlashAttribute("msg", "joinSucess");
		return "redirect:/corp/login";
	}
	
	// 기업회원 로그인
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginGET() {
		return "/corp/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginPOST(@RequestParam("corpUserId") String corpUserId,
							@RequestParam("corpUserPw") String corpUserPW,
							HttpSession session,
							Model model) throws Exception{
		CorpMemberVO loginVO = cService.login(corpUserId, corpUserPW);
		
		if(loginVO != null && !"D".equals(loginVO.getStatus())) {
			session.setAttribute("corpUserId", loginVO.getCorpUserId());
			session.setAttribute("companyName", loginVO.getCompanyName());
			return "redirect:/corp/main";
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않거나 탈퇴된 회원입니다.");
			return "/corp/login";
		}
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/corp/main";
	}
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String main() {
		return "/corp/main";
	}
}
