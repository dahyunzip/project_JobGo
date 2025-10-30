package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.itwillbs.service.ComBoardServiceImpl;
import com.itwillbs.service.MemberService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.ComBoardVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.ComBoardService;

@Controller
@RequestMapping("/comboard/*")
public class ComBoardController {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(ComBoardController.class);
	
	@Inject private ComBoardService comBoardService;
	@Inject private MemberService memberService;
	
	@GetMapping("/test")
	public void test() {
		logger.debug(" test() 실행! ");
	}
	
	// 게시판 글쓰기 - GET
	@GetMapping("/comRegist")
	public void comRegistGET(HttpSession session,
			                 Model model) throws Exception {
		logger.debug(" /comboard/comRegist -> comRegistGET() 실행! ");
		
		String memberLoginInfo = (String) session.getAttribute("userid");
		
		MemberVO memberInfo = memberService.getMember(memberLoginInfo);
		
		model.addAttribute("memberLoginInfo", memberInfo);
		
		logger.debug(" /views/comboard/comRegist.jsp 페이지 이동 ");
	}
	
	// 게시판 글쓰기 - POST
	@PostMapping("/comRegist")
	public String comRegistPOST() {
		logger.debug(" /comboard/comRegist -> comRegistPOST() 실행! ");
		
		
		logger.debug(" /comboard/comRegist -> comRegistPOST() 끝! ");
		return null;
	}
	
	
	// http://localhost:8088/comboard/comListCri
	// 게시판 리스트(페이징)
	@GetMapping("/comListCri")
	public void comListCriGET(Criteria cri,
			                  Model model) throws Exception {
		logger.debug(" /comboard/comListCri -> comListCri() 실행! ");
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(comBoardService.getTotalCount());
		
		List<ComBoardVO> cboardList
			= comBoardService.getComBoardListPage(cri);		
		// logger.debug("list:"+cboardList);
		logger.debug("list:"+cboardList.size());
		
		model.addAttribute(pageVO);
		model.addAttribute("cboardList",cboardList);
		
		logger.debug(" /comboard/comListCri -> comListCri() 끝! ");		
	}
	

}
