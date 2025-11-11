package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.ResumeVO;
import com.itwillbs.service.ResumeService;

@Controller
@RequestMapping("/resume/*")
public class ResumeController {
	
	private static final Logger logger = LoggerFactory.getLogger(ResumeController.class);
	
	@Inject
	private ResumeService rService;
	
	// ===== [이력서 목록] =====
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String list(@RequestParam("memberId") int memberId, Model model) {
		List<ResumeVO> resumeList = rService.getResumeList(memberId);
		model.addAttribute("resumeList", resumeList);
		return "/resume/list";
	}
	
	// ===== [이력서 상세보기] =====
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public String detail(@RequestParam("resumeId") int resumeId, Model model) {
		ResumeVO resume = rService.getResume(resumeId);
		model.addAttribute("resume", resume);
		return "/resume/detail";
	}
	
	// ===== [이력서 작성 폼] =====
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String writeGET() {
		return "/resume/write";
	}
	
	// ===== [이력서 작성 처리] =====
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String writePOST(@ModelAttribute ResumeVO resume) {
		logger.debug("writePOST 진입 / memberId = {}", resume.getMemberId());
		logger.debug("resume : {}", resume);
		rService.createResume(resume);
		return "redirect:/resume/list?memberId=" + resume.getMemberId();
	}
	
	// ===== [이력서 삭제] =====
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(@RequestParam("resumeId") int resumeId,
						 @RequestParam("memberId") int memberId) {
		rService.deleteResume(resumeId);
		return "redirect:/resume/list?memberId=" + memberId;
	}

}
