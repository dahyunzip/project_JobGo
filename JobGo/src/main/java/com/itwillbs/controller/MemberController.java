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
		logger.debug(" 회원가입 완료, 정보 : " + vo);
		return "redirect:/member/login";
	}
	
	// 로그인
	// http://localhost:8088/member/login
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String memberLoginGET(@ModelAttribute(value = "oldPath") String oldPath) {
		logger.debug(" @@@ oldPath  "+oldPath);
		return "/member/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String memberLoginPOST(@RequestParam("userid") String userid,
								  @RequestParam("userpw") String userpw,
								  @RequestParam(value = "oldPath", required = false) String oldPath,
								  HttpSession session,
								  Model model,
								  RedirectAttributes rttr) throws Exception {
		
		MemberVO loginVO = mService.login(userid, userpw);
		
		if(loginVO != null && !loginVO.isDeleted()) {
			session.setAttribute("userid", loginVO.getUserid());
			session.setAttribute("memberName", loginVO.getName());
			session.setAttribute("membertype", loginVO.getMembertype());
			logger.info(" 로그인 성공 ");
			logger.debug(" loginVO = " + loginVO);
			rttr.addFlashAttribute("msg", "loginSuccess");
			logger.debug(" oldPath "+oldPath);
			
			// oldPath정보가 있다면,
			if (oldPath != null && !oldPath.isEmpty()) {
		        return "redirect:" + oldPath;
		    } else {		    
		    	// oldPath정보가 없다면,
		    	return "redirect:/";
		    }
			
		} else {
			rttr.addFlashAttribute("msg", "loginFail");
			return "redirect:/member/login";
		}
	}
	
	// 로그아웃
	// http://localhost:8088/member/logout
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String memberLogoutGET(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 마이페이지 (내 정보 조회)
	@RequestMapping(value="/mypage", method=RequestMethod.GET)
	public String memberInfoGET(HttpSession session, Model model) throws Exception{
		String memberId = (String) session.getAttribute("userid");
		MemberVO userVO = mService.getMember(memberId);
		model.addAttribute("user", userVO);
		return "/member/mypage";
	}
	
	// 내 정보 수정하기 GET
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String memberModifyGET(HttpSession session, Model model) throws Exception{
		String memberId = (String) session.getAttribute("userid");
		MemberVO userVO = mService.getMember(memberId);
		model.addAttribute("user", userVO);
		return "/member/modify";
	}
	
	// 내 정보 수정하기 POST
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String memberModifyPOST(MemberVO vo, RedirectAttributes rttr) throws Exception{
		logger.debug(" memberModifyPOST(MemberVO vo) 실행!");
		logger.debug("vo : " + vo);
		
		// 체크박스 미선택 시 N으로 설정
	    if (vo.getAgreeLocation() != 'Y') vo.setAgreeLocation('N');
	    if (vo.getAgreeEmail() != 'Y') vo.setAgreeEmail('N');
	    if (vo.getAgreeSms() != 'Y') vo.setAgreeSms('N');
	    
	    
		// 회원 기본 정보 수정
		mService.modifyMember(vo);
		
		// 프로필 사진 업로드
		if(vo.getUpload() != null && !vo.getUpload().isEmpty()) {
			logger.debug(" 새 프로필 이미지 업로드 감지 ! ");
			String storedFileName = mService.uploadPhoto(vo);
			vo.setStoredFileName(storedFileName);
		} else {
			logger.debug(" 프로필 이미지 변경 없음");
		}
		
		rttr.addFlashAttribute("msg", "modifySuccess");
		logger.debug(" memberModifyPOST 종료 ! ");
		return "redirect:/member/mypage";
	}
	
	// 회원 탈퇴 GET
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public void memberDeleteGET(HttpSession session, Model model) throws Exception {
		String memberId = (String) session.getAttribute("userid");
		MemberVO userVO = mService.getMember(memberId);
		model.addAttribute("user", userVO);
		logger.debug(" memberDeleteGET() 실행 ");
		logger.debug(" /member/delete.jsp 뷰페이지 이동 ");
	}
	
	// 회원 탈퇴 POST
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String memberDeletePOST(HttpSession session, 
								@RequestParam("agreeCheck") String agreeCheck,
								@RequestParam("confirmText") String confirmText,
								RedirectAttributes rttr) throws Exception {
		logger.debug(" memberDeletePOST() 실행! ");
		String userid = (String) session.getAttribute("userid");
		
		// 기본 검증 
		if(userid == null) {
			return "redirect:/member/login";
		}
		
		if(!"on".equals(agreeCheck) || !"탈퇴하겠습니다.".equals(confirmText.trim())) {
			rttr.addFlashAttribute("msg", "dropFail");
			return "redirect:/member/delete";
		}
		
		// DB 상태 변경
		mService.dropMember(userid);
		
		session.invalidate();
		
		rttr.addFlashAttribute("msg", "dropComplete");
		return "redirect:/";
		
		
	}
	
}
