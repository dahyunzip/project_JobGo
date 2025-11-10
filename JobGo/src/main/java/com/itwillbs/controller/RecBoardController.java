package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.service.CorpMemberService;
import com.itwillbs.service.RecBoardService;

@Controller
@RequestMapping("/recboard/*")
public class RecBoardController {

	private static final Logger logger 
		= LoggerFactory.getLogger(RecBoardController.class);
	
	@Inject private RecBoardService recBoardService;
	@Inject private CorpMemberService corpMemberService;
	
	@GetMapping("/recListCri")
	public void recListCri(Model model,
			               Criteria cri) throws Exception {
		logger.debug(" /recboard/recListCri -> recListCri() 실행! ");
		
		// 1-1 페이징 처리 객체 pageVO 생성
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(recBoardService.getRecTotalCount());
		
		List<RecBoardVO> resultRecList = recBoardService.getRecBoardList(cri);
		logger.debug(" 채용 공고 리스트: "+resultRecList.size());
		logger.debug(" 채용 공고 리스트: "+resultRecList);
		
		model.addAttribute(pageVO);
		model.addAttribute("recBoardList", resultRecList);
		
		logger.debug(" /recboard/recListCri -> recListCri() 끝! ");
	}

	
}
