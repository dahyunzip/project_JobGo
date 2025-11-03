package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.NoticeVO;
import com.itwillbs.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Inject
	private NoticeService nService;
	
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
	public String insertNotice(NoticeVO vo, HttpSession session) {
		
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
		}
		
		nService.insertNotice(vo);
		return "redirect:/notice/list";
	}
	
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public String getNotice(@RequestParam("noticeId") int noticeId, Model model) {
		
		model.addAttribute("notice", nService.getNotice(noticeId));
		return "/notice/detail";
	}
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public String getNoticeList(Model model) {
		model.addAttribute("noticeList", nService.getNoticeList());
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
	public String updateNotice(NoticeVO vo, HttpSession session) {
		
		if(!isAdmin(session)) {
			return "redirect:/notice/list";
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
