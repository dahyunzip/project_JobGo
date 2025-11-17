package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.service.RecBoardService;

@Controller
public class MainRecBoardController {
		
	private static final Logger logger 
		= LoggerFactory.getLogger(MainRecBoardController.class);

	@Inject private RecBoardService recBoardService;
	
	// 메인 페이지 구인 공고 리스트 뿌리기
	//@GetMapping("/")
	public String RecMainList(Model model) throws Exception{
		logger.debug(" RecMainList() 실행! ");
		
		List<RecBoardVO> recMainList = recBoardService.getRecMainList();
		List<RecBoardVO> recMainListVW = recBoardService.getRecMainListVIEW();
		model.addAttribute("recMainList", recMainList);
		model.addAttribute("recMainListVW", recMainListVW);
		
		logger.debug(" recMainList 개수: "+recMainList.size());
		logger.debug(" recMainListVW 개수: "+recMainListVW.size());
		logger.debug(" RecMainList() 끝! ");
		return "/home/main";
	}

}
