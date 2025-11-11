package com.itwillbs.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itwillbs.domain.NoticeVO;
import com.itwillbs.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Inject
	private NoticeService nService;
	
	private static final String UPLOAD_PATH = "c:\\spring\\upload";
	
	//관리자 체크
	private boolean isAdmin(HttpSession session) {
		String type = (String) session.getAttribute("membertype");
		return type != null && type.equals("A");
	}
	
	@RequestMapping(value = "/write", method=RequestMethod.GET)
	public String writeForm(HttpSession session) {
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}
		return "/notice/write";
	}
	
	@RequestMapping(value = "/write", method=RequestMethod.POST)
	public String insertNotice(NoticeVO vo,
		@RequestParam(value="file", required=false) MultipartFile file,
		HttpSession session) {

		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}

		vo.setAdminId(Integer.parseInt(session.getAttribute("id").toString()));

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

		nService.insertNotice(vo);
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
	public String getNotice(@RequestParam("noticeId") int noticeId, Model model, HttpSession session) {
		
		NoticeVO notice = nService.getNotice(noticeId);
		String memberType = (String) session.getAttribute("membertype");
		boolean isCorpNotice = notice.getNoticeTitle() != null && notice.getNoticeTitle().contains("[기업공지]");

		// 기업공지인데 일반회원/비회원이면 접근 차단
		if (isCorpNotice && (memberType == null || !(memberType.equals("C") || memberType.equals("A")))) {
			return "redirect:/error/403"; // 접근 제한 페이지로 이동
		}
		
		// 관리자(A)는 모든 공지 접근 가능
		if ("A".equals(memberType)) {
			
		}

		nService.updateViewCnt(noticeId);
		model.addAttribute("notice", notice);
		return "/notice/detail";
	}
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public String getNoticeList(HttpSession session, Model model) {
		String memberType = (String) session.getAttribute("membertype");
		
		List<NoticeVO> allList = nService.getNoticeList();
		List<NoticeVO> filteredList = new ArrayList<>();
		
		for (NoticeVO vo : allList) {
			// 제목에 [기업공지] 포함 여부로
			boolean isCorpNotice = vo.getNoticeTitle() != null && vo.getNoticeTitle().contains("[기업공지]");

			if (isCorpNotice) {
				// 기업공지 -> 관리자(A) 기업회원(C)
				if ("A".equals(memberType) || "C".equals(memberType)) {
					filteredList.add(vo);
				}
			} else {
				// 일반 공지 -> 아무나
				filteredList.add(vo);
			}
		}

		model.addAttribute("noticeList", filteredList);
		return "/notice/list";
	}
	
	@RequestMapping(value = "/edit", method=RequestMethod.GET)
	public String updateNoticeForm(@RequestParam("noticeId") int noticeId, Model model, HttpSession session) {
		
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}
		
		model.addAttribute("notice", nService.getNotice(noticeId));
		return "/notice/edit";
	}
	
	@RequestMapping(value = "/edit", method=RequestMethod.POST)
	public String updateNotice(NoticeVO vo,
		@RequestParam(value="file", required=false) MultipartFile file,
		HttpSession session) {

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
	public String deleteNotice(@RequestParam("noticeId") int noticeId, HttpSession session) {
		
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}
		
		nService.deleteNotice(noticeId);
		return "redirect:/notice/list";
	}
	
}
