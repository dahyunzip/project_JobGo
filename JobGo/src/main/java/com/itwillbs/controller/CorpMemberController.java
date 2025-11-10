package com.itwillbs.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.service.CorpMemberService;

@Controller
@RequestMapping(value="/corp/*")
public class CorpMemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(CorpMemberController.class);
	
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
		rttr.addFlashAttribute("msg", "joinSuccess");
		return "redirect:/corp/login";
	}
	
	//아이디 중복 검사
	@RequestMapping(value="/corp/idCheck", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam("corpUserId") String corpUserId) throws Exception{
		logger.debug("idCheck 호출 — userid 값: {}", corpUserId);
		boolean available = cService.isUseridAvailable(corpUserId);
		Map<String, Object> result = new HashMap<>();
		result.put("available", available);
		result.put("message", available ? "사용 가능한 아이디입니다." : "이미 사용중인 아이디 입니다.");
		return result;
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
