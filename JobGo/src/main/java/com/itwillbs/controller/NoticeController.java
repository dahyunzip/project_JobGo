package com.itwillbs.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.NoticeVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Inject
	private NoticeService nService;
	
	private static final String UPLOAD_PATH = "c:\\spring\\upload";
	
	//관리자 체크
	private boolean isAdmin(HttpSession session) throws Exception{
		String type = (String) session.getAttribute("membertype");
		return type != null && type.equals("A");
	}
	
	@RequestMapping(value = "/write", method=RequestMethod.GET)
	public String writeForm(HttpSession session) throws Exception{
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}
		return "/notice/write";
	}
	
	@RequestMapping(value = "/write", method=RequestMethod.POST)
	public String insertNotice(NoticeVO vo,
		@RequestParam(value="file", required=false) MultipartFile file,
		@RequestParam(value="corpNotice", required=false, defaultValue="A") String corpNotice,
		HttpSession session) throws Exception {
		
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}

		String userid = (String) session.getAttribute("userid");
		if (userid == null) return "redirect:/member/login";

		if(file != null && !file.isEmpty()) {
			String uploadPath = session.getServletContext().getRealPath("/resources/upload/");
			File dir = new File(uploadPath);
			if(!dir.exists()) dir.mkdirs();

			String origin = file.getOriginalFilename();
			String fileName = System.currentTimeMillis() + "_" + origin;
			file.transferTo(new File(uploadPath, fileName));
			vo.setStoredFileName(fileName);
		}
		
		if ("corp".equals(corpNotice) && !vo.getNoticeTitle().startsWith("[기업공지]")) {
			vo.setNoticeTitle("[기업공지] " + vo.getNoticeTitle());
		}
		
		Map<String, Object> noticeData = new HashMap<>();
		noticeData.put("userid", userid);
		noticeData.put("noticeTitle", vo.getNoticeTitle());
		noticeData.put("noticeContent", vo.getNoticeContent());
		noticeData.put("storedFileName", vo.getStoredFileName());

		nService.insert_notice_with_userid(noticeData);
		return "redirect:/notice/list";
	}
	
	private List<String> fileUploadProcess(MultipartHttpServletRequest multiRequest) {
		List<String> fileList = new ArrayList<>();

		Iterator<String> fileNames = multiRequest.getFileNames();
		while(fileNames.hasNext()) {
			String fileParam = fileNames.next();
			MultipartFile file = multiRequest.getFile(fileParam);

			if(!file.isEmpty()) {
				String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
				String uploadPath = multiRequest.getSession().getServletContext()
					.getRealPath("/resources/upload/");

				File dest = new File(uploadPath, fileName);
				try {
					file.transferTo(dest);
					fileList.add(fileName);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return fileList;
	}
	
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public String getNotice(@RequestParam("noticeId") int noticeId, Model model, HttpSession session) throws Exception{
		
		NoticeVO notice = nService.getNotice(noticeId);
		String memberType = (String) session.getAttribute("membertype");
		String userType = (String) session.getAttribute("userType");
		
		boolean isCorpNotice = notice.getNoticeTitle() != null && notice.getNoticeTitle().contains("[기업공지]");

		// 일반회원(G) 또는 비회원이고 userType도 corp이 아니면 차단
		if (isCorpNotice && (memberType == null && userType == null ||
				!( "A".equals(memberType) || "corp".equals(userType) ))) {
				return "redirect:/error/403";
			}

		nService.updateViewCnt(noticeId);
		model.addAttribute("notice", notice);
		return "/notice/detail";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String getNoticeList(Criteria cri, Model model, HttpSession session) throws Exception {
		String memberType = (String) session.getAttribute("membertype");
		String userType = (String) session.getAttribute("userType");
		
		
		Map<String, Object> param = new HashMap<>();
		param.put("cri", cri);
		param.put("memberType", memberType);
		param.put("userType", userType);

		List<NoticeVO> noticeList = nService.getNoticeListPaging(param);
		int totalCount = nService.getNoticeCount(param);

		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(totalCount);

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageVO", pageVO);
		return "/notice/list";
	}
	
	@RequestMapping(value = "/edit", method=RequestMethod.GET)
	public String updateNoticeForm(@RequestParam("noticeId") int noticeId, Model model, HttpSession session) throws Exception{
		
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}
		
		model.addAttribute("notice", nService.getNotice(noticeId));
		return "/notice/edit";
	}
	
	@RequestMapping(value = "/edit", method=RequestMethod.POST)
	public String updateNotice(NoticeVO vo,
		@RequestParam(value="file", required=false) MultipartFile file,
		HttpSession session) throws Exception{

		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}

		if(file != null && !file.isEmpty()) {
			String uploadPath = session.getServletContext().getRealPath("/resources/upload/");
			File dir = new File(uploadPath);
			if(!dir.exists()) dir.mkdirs();

			String origin = file.getOriginalFilename();
			String fileName = System.currentTimeMillis() + "_" + origin;
			try {
				file.transferTo(new File(uploadPath, fileName));
				vo.setStoredFileName(fileName);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		nService.updateNotice(vo);
		return "redirect:/notice/detail?noticeId="+vo.getNoticeId();
	}
	
	@RequestMapping(value = "/delete", method=RequestMethod.POST)
	public String deleteNotice(@RequestParam("noticeId") int noticeId, HttpSession session) throws Exception{
		
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}
		
		nService.deleteNotice(noticeId);
		return "redirect:/notice/list";
	}
	
}
