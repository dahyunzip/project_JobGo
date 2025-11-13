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

import com.itwillbs.domain.ApplicationVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.ApplicationService;

@Controller
@RequestMapping("/application/*")
public class ApplicationController {
	
	@Inject
	private ApplicationService aService;
	
	private static final Logger logger = LoggerFactory.getLogger(ApplicationController.class);
	
//	@RequestMapping(value="/apply", method=RequestMethod.GET)
//	public String applyGET(@RequestParam("rec_bno") int  rec_bno, RedirectAttributes rttr) {
//		logger.debug("applyGET() 실행 - rec_bno=" + rec_bno);
//	    rttr.addFlashAttribute("msg", "잘못된 접근입니다.");
//	    return "redirect:/recboard/recRead?rec_bno=" + rec_bno;
//	}
	
	@RequestMapping(value="/apply", method=RequestMethod.POST)
	public String applyPOST(ApplicationVO vo,
							HttpSession session,
							@RequestParam(value = "page", defaultValue = "1") int page,
							RedirectAttributes rttr) throws Exception {
        Integer member_id = (Integer) session.getAttribute("memberId");
        if (member_id == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        vo.setMember_id(member_id);
        logger.debug("받은 VO 데이터: " + vo);

        try {
            aService.apply(vo);
            rttr.addFlashAttribute("msg", "applySuccess");
        } catch (IllegalStateException e) {
            rttr.addFlashAttribute("msg", e.getMessage());
        }
        //return "redirect:/application/list";
        return "redirect:/recboard/recRead?rec_bno=" + vo.getRec_bno() + "&page=" + page;
    }
	
	// 지원 내역 보기
    @RequestMapping(value="/list", method=RequestMethod.GET)
    public String list(HttpSession session,
			    		Model model,
			    		RedirectAttributes rttr,
			    		Criteria cri) throws Exception {
    	// 회원정보 가져오기
        Integer member_id = (Integer) session.getAttribute("memberId");
        
        // 회원별 전체 지원 개수
        int totalCount = aService.getTotalCount(member_id);
        
        // 페이징 처리 객체 PageVO 생성
        PageVO pageVO = new PageVO();
        pageVO.setCri(cri);
        pageVO.setTotalCount(totalCount);
        
        if (member_id == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }
        
        // 목록 조회
        List<ApplicationVO> list = aService.getApplications(member_id, cri);
        
        model.addAttribute(pageVO);
        model.addAttribute("cri", cri);
        model.addAttribute("applications", list);
        model.addAttribute("totalCount", totalCount);
        return "/application/list";
    }
    
    // 지원 취소
    @RequestMapping(value="/withdraw", method=RequestMethod.POST)
    public String withdraw(@RequestParam("application_id") int application_id, RedirectAttributes rttr) throws Exception {
    	logger.debug("withdraw() 실행! ");
        if (aService.withdraw(application_id)) {
            rttr.addFlashAttribute("msg", "drawSuccess");
            logger.debug("withdraw() 성공! ");
        } else {
            rttr.addFlashAttribute("msg", "drawFail");
            logger.debug("withdraw() 실패! ");
        }
        return "redirect:/application/list";
    }
}