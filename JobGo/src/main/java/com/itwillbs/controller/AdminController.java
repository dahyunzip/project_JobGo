package com.itwillbs.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NoticeVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.NoticeService;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private MemberService mService;
	
	@Inject
	private AdminService adminService;
	
	@Inject
	private NoticeService noticeService;
	
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
	public String adminDashboard(HttpSession session, Model model) throws Exception {
		
		String adminId = (String) session.getAttribute("adminSession");
		
		if(adminId == null) {
			logger.debug(" 비로그인 접근 차단 -> 로그인 페이지로 이동");
			return "redirect:/admin/login";
		}
		
		model.addAttribute("totalMembers", adminService.getTotalMembers());
        model.addAttribute("generalMembers", adminService.getGeneralMembers());
        model.addAttribute("corpMembers", adminService.getCorpMembers());

        model.addAttribute("totalRecruits", adminService.getTotalRecruits());
        model.addAttribute("weeklyRecruits", adminService.getWeeklyRecruits());

        model.addAttribute("totalNotice", adminService.getTotalNoticeCount());
        model.addAttribute("latestNotice", adminService.getLatestNoticeTitle());

        model.addAttribute("totalReview", adminService.getTotalReviewCount());
        model.addAttribute("todayReview", adminService.getTodayReviewCount());
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

	    List<CorpMemberVO> corpList = adminService.getAllCorpMembers(cri);
	    int totalCount = adminService.getCorpMemberTotalCount();

	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    pageVO.setTotalCount(totalCount);

	    model.addAttribute("corpList", corpList);
	    model.addAttribute("pageVO", pageVO);

	    return "/admin/userManageCorp";
	}
	
	// PDF 파일 조회 (스트림 방식)
	@RequestMapping(value="/viewBusinessLicense", method=RequestMethod.GET)
	public void viewBusinessLicense(@RequestParam("corpId") int corpId,
	                                 HttpServletResponse response,
	                                 HttpSession session) throws Exception {
	    
	    if (session.getAttribute("adminSession") == null) {
	        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
	        return;
	    }
	    
	    // 기업 정보 조회
	    CorpMemberVO corp = adminService.getCorpMemberById(corpId);
	    
	    if (corp == null || corp.getBusinessLicenseUrl() == null) {
	        response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일이 존재하지 않습니다.");
	        return;
	    }
	    
	    String storedFileName = corp.getBusinessLicenseUrl();
	    String filePath = "/usr/local/tomcat/upload/business_license/" + storedFileName;
	    File file = new File(filePath);
	    
	    if (!file.exists()) {
	        response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일을 찾을 수 없습니다.");
	        return;
	    }
	    
	    // PDF를 브라우저에서 바로 볼 수 있도록 설정
	    response.setContentType("application/pdf");
	    response.setHeader("Content-Disposition", "inline; filename=\"" + 
	                      URLEncoder.encode(corp.getOriginalFileName(), "UTF-8") + "\"");
	    response.setContentLengthLong(file.length());
	    
	    // 파일 스트림 전송
	    try (FileInputStream fis = new FileInputStream(file);
	         OutputStream os = response.getOutputStream()) {
	        byte[] buffer = new byte[4096];
	        int bytesRead;
	        while ((bytesRead = fis.read(buffer)) != -1) {
	            os.write(buffer, 0, bytesRead);
	        }
	        os.flush();
	    } catch (IOException e) {
	        logger.error("PDF 파일 전송 중 오류 발생", e);
	        throw e;
	    }
	}
	
	// PDF 다운로드
	@RequestMapping(value="/downloadBusinessLicense", method=RequestMethod.GET)
	public void downloadBusinessLicense(@RequestParam("corpId") int corpId,
	                                     HttpServletResponse response,
	                                     HttpSession session) throws Exception {
	    
	    if (session.getAttribute("adminSession") == null) {
	        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
	        return;
	    }
	    
	    CorpMemberVO corp = adminService.getCorpMemberById(corpId);
	    
	    if (corp == null || corp.getBusinessLicenseUrl() == null) {
	        response.sendError(HttpServletResponse.SC_NOT_FOUND);
	        return;
	    }
	    
	    String storedFileName = corp.getBusinessLicenseUrl();
	    String filePath = "/usr/local/tomcat/upload/business_license/" + storedFileName;
	    File file = new File(filePath);
	    
	    if (!file.exists()) {
	        response.sendError(HttpServletResponse.SC_NOT_FOUND);
	        return;
	    }
	    
	    // 다운로드 방식
	    response.setContentType("application/pdf");
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + 
	                      URLEncoder.encode(corp.getOriginalFileName(), "UTF-8") + "\"");
	    response.setContentLengthLong(file.length());
	    
	    try (FileInputStream fis = new FileInputStream(file);
	         OutputStream os = response.getOutputStream()) {
	        byte[] buffer = new byte[4096];
	        int bytesRead;
	        while ((bytesRead = fis.read(buffer)) != -1) {
	            os.write(buffer, 0, bytesRead);
	        }
	        os.flush();
	    }
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
	
	// 기업회원 삭제
	@RequestMapping(value="/deleteCorp", method=RequestMethod.GET)
	public String deleteCorpMember(@RequestParam("id") int corpId,
	                               HttpSession session,
	                               RedirectAttributes rttr) throws Exception {

	    if (session.getAttribute("adminSession") == null) {
	        return "redirect:/admin/login";
	    }

	    int result = adminService.deleteCorpMember(corpId);

	    if (result > 0) {
	        rttr.addFlashAttribute("msg", "deleteSuccess");
	    } else {
	        rttr.addFlashAttribute("msg", "deleteFail");
	    }

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
	
	//공지사항
	@RequestMapping(value="/noticeManage", method=RequestMethod.GET)
	public String adminNoticeList(
			@RequestParam(value="search", required=false) String search,
			Criteria cri,
			HttpSession session,
			Model model) throws Exception {

		// 관리자 체크
		if (session.getAttribute("adminSession") == null) {
			return "redirect:/admin/login";
		}

		// 검색어 세팅
		cri.setSearch(search);

		// 목록 조회
		List<NoticeVO> noticeList = adminService.getNoticeListAll(cri);
		int totalCount = adminService.getTotalCountAll(cri);

		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(totalCount);

		model.addAttribute("search", search);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageVO", pageVO);

		return "/admin/noticeManage";
	}

	// 공지 상세
	@RequestMapping(value="/noticeDetail", method=RequestMethod.GET)
	public String adminNoticeDetail(
			@RequestParam("noticeId") int noticeId,
			HttpSession session,
			Model model) throws Exception {

		if (session.getAttribute("adminSession") == null) {
			return "redirect:/admin/login";
		}

		NoticeVO notice = adminService.getNotice(noticeId);
		model.addAttribute("notice", notice);

		return "/admin/noticeDetail";
	}

	// 공지 작성
	@RequestMapping(value="/noticeWrite", method=RequestMethod.GET)
	public String adminNoticeWriteForm(HttpSession session, Model model) {

	    if (session.getAttribute("adminSession") == null) {
	        return "redirect:/admin/login";
	    }

	    return "/admin/noticeWrite";
	}

	// 공지 작성
	@RequestMapping(value="/noticeWrite", method=RequestMethod.POST)
	public String adminNoticeWrite(
			NoticeVO vo,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpSession session) throws Exception {

		if (session.getAttribute("adminSession") == null) {
			return "redirect:/admin/login";
		}

		String userid = (String) session.getAttribute("adminSession");

		// 파일 업로드
		if (file != null && !file.isEmpty()) {

			String uploadPath = session.getServletContext().getRealPath("/resources/upload/");
			File dir = new File(uploadPath);
			if(!dir.exists()) dir.mkdirs();

			String origin = file.getOriginalFilename();
			String fileName = System.currentTimeMillis() + "_" + origin;

			file.transferTo(new File(uploadPath, fileName));
			vo.setStoredFileName(fileName);
		}

		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("noticeTitle", vo.getNoticeTitle());
		map.put("noticeContent", vo.getNoticeContent());
		map.put("storedFileName", vo.getStoredFileName());

		adminService.insertNotice(map);

		return "redirect:/admin/noticeManage";
	}

	// 공지 수정 (GET)
	@RequestMapping(value="/noticeEdit", method=RequestMethod.GET)
	public String adminNoticeEditForm(
			@RequestParam("noticeId") int noticeId,
			HttpSession session,
			Model model) throws Exception {

		if (session.getAttribute("adminSession") == null) {
			return "redirect:/admin/login";
		}
		
		NoticeVO notice = adminService.getNotice(noticeId);
		model.addAttribute("notice", notice);

		return "/admin/noticeEdit";
	}

	// 공지 수정 (POST)
	@RequestMapping(value="/noticeEdit", method=RequestMethod.POST)
	public String adminNoticeEdit(
			NoticeVO vo,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpSession session) throws Exception {

		if (session.getAttribute("adminSession") == null) {
			return "redirect:/admin/login";
		}

		// 파일 업로드
		if (file != null && !file.isEmpty()) {

			String uploadPath = session.getServletContext().getRealPath("/resources/upload/");
			File dir = new File(uploadPath);
			if (!dir.exists()) dir.mkdirs();

			String origin = file.getOriginalFilename();
			String fileName = System.currentTimeMillis() + "_" + origin;

			file.transferTo(new File(uploadPath, fileName));
			vo.setStoredFileName(fileName);
		}

		adminService.updateNotice(vo);

		return "redirect:/admin/noticeDetail?noticeId=" + vo.getNoticeId();
	}

	// 공지 삭제
	@RequestMapping(value="/noticeDelete", method=RequestMethod.POST)
	public String adminNoticeDelete(
			@RequestParam("noticeId") int noticeId,
			HttpSession session) throws Exception {

		if (session.getAttribute("adminSession") == null) {
			return "redirect:/admin/login";
		}

		adminService.deleteNotice(noticeId);

		return "redirect:/admin/noticeManage";
	}
	
	

	
	
}
