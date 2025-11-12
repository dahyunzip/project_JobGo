package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.MemberService;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private MemberService mService;
	
	@Inject
	private AdminService adminService;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String adminLoginGET() {
		logger.debug(" 관리자 로그인 페이지 요청");
		return "/admin/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String adminLoginPOST(@RequestParam("userid") String userid,
								@RequestParam("userpw") String userpw,
								HttpSession session,
								RedirectAttributes rttr,
								Model model) throws Exception {
		logger.debug(" 관리자 로그인 시도 : {}", userid);
		
		
		MemberVO admin = mService.login(userid, userpw);
		if(admin == null) {
			rttr.addFlashAttribute("msg", "loginFail");
			logger.debug(" 로그인 실패 : 존재하지 않는 계정 또는 비밀번호 불일치");
			return "redirect:/admin/login";
		}
		
		// 관리자 여부 확인
		if(!"A".equals(admin.getMembertype())) {
			rttr.addFlashAttribute("msg", "notAdmin");
			logger.debug(" 일반 회원이 관리자 로그인 시도 : {}", userid);
			return "redirect:/admin/login";
		}
		
		//로그인 성공
		session.setAttribute("adminSession", admin.getUserid());
		session.setAttribute("adminName", admin.getName());
		
		logger.debug(" 관리자 로그인 성공 : {}", admin.getUserid());
		rttr.addFlashAttribute("msg", "loginSuccess");
		
		return "redirect:/admin/home";
	}
	
	// 관리자 대시보드
	@RequestMapping(value="/home", method=RequestMethod.GET)
	public String adminDashboard(HttpSession session, Model model) {
		
		String adminId = (String) session.getAttribute("adminSession");
		
		if(adminId == null) {
			logger.debug(" 비로그인 접근 차단 -> 로그인 페이지로 이동");
			return "redirect:/admin/login";
		}
		
		model.addAttribute("adminId", adminId);
		return "/admin/home";
	}
	
	// 로그아웃
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String adminLogout(HttpSession session, RedirectAttributes rttr) {
		session.invalidate();
		rttr.addFlashAttribute("msg", "logoutSuccess");
		logger.debug(" 관리자 로그아웃 완료");
		return "redirect:/admin/login";
	}
	
	// 관리자 채용공고 관리
	@RequestMapping(value="/corpBoard", method=RequestMethod.GET)
	public String adminCorpBoard() throws Exception {
		
		return "/admin/corpBoard";
	}
	
	// 기업회원 관리
	@RequestMapping(value="/userManageCorp", method=RequestMethod.GET)
	public String userManageCorp(HttpSession session, Model model) throws Exception {
		String adminUserid = (String) session.getAttribute("adminSession");
		if (adminUserid == null) return "redirect:/admin/login";

		List<MemberVO> corpList = adminService.getAllCorpMembers();
		model.addAttribute("corpList", corpList);

		return "/admin/userManageCorp";
	}

	// 일반회원 관리
	@RequestMapping(value="/userManageMember", method=RequestMethod.GET)
	public String userManageMember(HttpSession session, Model model) throws Exception {
		String adminUserid = (String) session.getAttribute("adminSession");
		if (adminUserid == null) return "redirect:/admin/login";
		
		List<MemberVO> memberList = adminService.getAllNormalMembers();
		model.addAttribute("memberList", memberList);

		return "/admin/userManageMember";
	}
	
	// 회원 삭제 (관리자 전용)
	@RequestMapping(value="/deleteMember", method=RequestMethod.GET)
	public String deleteMember(@RequestParam("id") int id,
	                           HttpSession session,
	                           RedirectAttributes rttr) throws Exception {
		
		String adminUserid = (String) session.getAttribute("adminSession");
		if (adminUserid == null) {
			rttr.addFlashAttribute("msg", "noAdminSession");
			return "redirect:/admin/login";
		}

		int result = adminService.deleteMember(id);
		if (result > 0) {
			rttr.addFlashAttribute("msg", "deleteSuccess");
		} else {
			rttr.addFlashAttribute("msg", "deleteFail");
		}

		return "redirect:/admin/userManageMember";
	}
	
	// 리뷰 관리
	@RequestMapping(value="/reviewManage", method=RequestMethod.GET)
	public String reviewManage(HttpSession session, Model model) throws Exception {
		String adminUserid = (String) session.getAttribute("adminSession");
		if (adminUserid == null) return "redirect:/admin/login";

		List<ReviewVO> reviewList = adminService.getAllReviews();
		model.addAttribute("reviewList", reviewList);

		return "/admin/reviewManage";
	}
	
	// 리뷰 삭제 (관리자 전용)
	@RequestMapping(value="/deleteReview", method=RequestMethod.POST)
	public String deleteReview(@RequestParam("reviewId") int reviewId, HttpSession session, RedirectAttributes rttr) throws Exception {
		String adminUserid = (String) session.getAttribute("adminSession");
		if (adminUserid == null) return "redirect:/admin/login";

		adminService.deleteReview(reviewId);
		rttr.addFlashAttribute("msg", "deleteSuccess");

		return "redirect:/admin/reviewManage";
	}
	
	
	
}
