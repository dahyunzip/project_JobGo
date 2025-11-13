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

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.RecBoardVO;
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
	public String adminCorpBoard(HttpSession session, Criteria cri, Model model) throws Exception {

	    if (session.getAttribute("adminSession") == null)
	        return "redirect:/admin/login";

	    String search = cri.getSearch();

	    List<RecBoardVO> recList = adminService.getRecBoardList(cri);

	    
	    int totalCount = adminService.getRecTotalCount(search);

	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    pageVO.setTotalCount(totalCount);

	    model.addAttribute("recList", recList);
	    model.addAttribute("pageVO", pageVO);

	    return "/admin/corpBoard";
	}
	
	// 채용공고 삭제
	@RequestMapping(value="/deleteRecBoard", method=RequestMethod.GET)
	public String deleteRecBoard(@RequestParam("rec_bno") int rec_bno,
	                             HttpSession session,
	                             RedirectAttributes rttr) throws Exception {

	    if (session.getAttribute("adminSession") == null)
	        return "redirect:/admin/login";

	    adminService.deleteRecBoard(rec_bno);
	    rttr.addFlashAttribute("msg", "deleteSuccess");

	    return "redirect:/admin/corpBoard";
	}
	
	// 일반회원 관리
	@RequestMapping(value="/userManageMember", method=RequestMethod.GET)
	public String userManageMember(HttpSession session, Criteria cri, Model model) throws Exception {
		
		if (session.getAttribute("adminSession") == null) {
	        return "redirect:/admin/login";
	    }
		
		List<MemberVO> memberList = adminService.getAllNormalMembers(cri);
	    int totalCount = adminService.getNormalMemberTotalCount();
		
	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    pageVO.setTotalCount(totalCount);
		
	    model.addAttribute("memberList", memberList);
	    model.addAttribute("pageVO", pageVO);
		
	    return "/admin/userManageMember";
	}
	
	// 기업회원 관리
	@RequestMapping(value="/userManageCorp", method=RequestMethod.GET)
	public String userManageCorp(HttpSession session, Criteria cri, Model model) throws Exception {
		
		if (session.getAttribute("adminSession") == null) {
	        return "redirect:/admin/login";
	    }

	    List<MemberVO> corpList = adminService.getAllCorpMembers(cri);
	    int totalCount = adminService.getCorpMemberTotalCount();

	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    pageVO.setTotalCount(totalCount);

	    model.addAttribute("corpList", corpList);
	    model.addAttribute("pageVO", pageVO);

	    return "/admin/userManageCorp";
	}
	
	// 기업회원 승인
	@RequestMapping(value="/approveCorp", method=RequestMethod.GET)
	public String approveCorp(@RequestParam("id") int id,
	                          HttpSession session,
	                          RedirectAttributes rttr) throws Exception {

	    if (session.getAttribute("adminSession") == null) 
	        return "redirect:/admin/login";

	    adminService.approveCorp(id);
	    rttr.addFlashAttribute("msg", "approveSuccess");
	    return "redirect:/admin/userManageCorp";
	}

	// 기업회원 거절
	@RequestMapping(value="/denyCorp", method=RequestMethod.GET)
	public String denyCorp(@RequestParam("id") int id,
	                       HttpSession session,
	                       RedirectAttributes rttr) throws Exception {

	    if (session.getAttribute("adminSession") == null)
	        return "redirect:/admin/login";

	    adminService.denyCorp(id);
	    rttr.addFlashAttribute("msg", "denySuccess");
	    return "redirect:/admin/userManageCorp";
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
	public String reviewManage(HttpSession session, Criteria cri, Model model) throws Exception {
		
		if (session.getAttribute("adminSession") == null) {
	        return "redirect:/admin/login";
	    }

	    List<ReviewVO> reviewList = adminService.getAllReviews(cri);
	    int totalCount = adminService.getReviewTotalCount();

	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    pageVO.setTotalCount(totalCount);

	    model.addAttribute("reviewList", reviewList);
	    model.addAttribute("pageVO", pageVO);

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
