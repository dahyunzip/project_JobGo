package com.itwillbs.controller;

import java.util.List;

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
	public String list(@RequestParam("memberId") int memberId,
						HttpSession session,
						Model model,
						RedirectAttributes rttr) {
		
		Integer sessionMemberId = (Integer) session.getAttribute("memberId");
		
		// 로그인 안된 경우
		if(sessionMemberId == null) {
			rttr.addFlashAttribute("msg", "loginRequired");
			return "redirect:/member/login";
		}
		
		// 로그인된 회원과 요청한 memberId가 다를 경우 -> 접근 차단
		if(!sessionMemberId.equals(memberId)) {
			rttr.addFlashAttribute("msg", "unauthorizedAccess");
			return "redirect:/resume/list?memberId=" + sessionMemberId;
		}
		
		List<ResumeVO> resumeList = rService.getResumeList(memberId);
		model.addAttribute("resumeList", resumeList);
		return "/resume/list";
	}
	
	// ===== [이력서 상세보기] =====
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public String detail(@RequestParam("resumeId") int resumeId,
						HttpSession session,
						Model model,
						RedirectAttributes rttr) {
		
		Integer sessionMemberId = (Integer) session.getAttribute("memberId");
		if (sessionMemberId == null) {
	        rttr.addFlashAttribute("msg", "loginRequired");
	        return "redirect:/member/login";
	    }
		
		ResumeVO resume = rService.getResume(resumeId);
		
		// 이력서 없는 경우
		if (resume == null) {
	        rttr.addFlashAttribute("msg", "resumeNotFound");
	        return "redirect:/resume/list?memberId=" + sessionMemberId;
	    }
		
		// 로그인한 사용자의 이력서가 아닐 경우 접근 차단
	    if (resume.getMemberId() != sessionMemberId) {
	        rttr.addFlashAttribute("msg", "unauthorizedAccess");
	        return "redirect:/resume/list?memberId=" + sessionMemberId;
	    }
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
	public String writePOST(@ModelAttribute ResumeVO resume,
							RedirectAttributes rttr) {
		logger.debug("writePOST 진입 / memberId = {}", resume.getMemberId());
		logger.debug("resume : {}", resume);
		rService.createResume(resume);
		rttr.addFlashAttribute("msg", "writeDone");
		return "redirect:/resume/list?memberId=" + resume.getMemberId();
	}
	
	// ===== [이력서 삭제] =====
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(@RequestParam("resumeId") int resumeId,
						 @RequestParam("memberId") int memberId,
						 RedirectAttributes rttr) {
		rService.deleteResume(resumeId);
		rttr.addFlashAttribute("msg", "deleteDone");
		return "redirect:/resume/list?memberId=" + memberId;
	}
	
	// ===== [이력서 수정 폼] =====
	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public String editGET(@RequestParam("resumeId") int resumeId, Model model) {
	    ResumeVO resume = rService.getResume(resumeId);
	    model.addAttribute("resume", resume);
	    return "/resume/edit";
	}

	// ===== [이력서 수정 처리] =====
	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public String editPOST(@ModelAttribute ResumeVO resume,
							RedirectAttributes rttr) {
	    rService.updateResume(resume);
	    rttr.addFlashAttribute("msg","editDone");
	    return "redirect:/resume/detail?resumeId=" + resume.getResumeId();
	}

}
