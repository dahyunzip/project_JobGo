package com.itwillbs.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.service.ComBoardService;

@Controller
@RequestMapping("/comboard/*")
public class ComBoardController {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(ComBoardController.class);
	
	@Inject private ComBoardService cbsrv;
	
	@GetMapping("/test")
	public void test() {
		logger.debug(" test() 실행! ");
	}
	
	@GetMapping("/comListCri")
	public void comListCriGET() {
		logger.debug(" /comboard/comListCri -> comListCri() 실행! ");
		
		
		
		logger.debug(" /comboard/comListCri -> comListCri() 끝! ");		
	}
	
	@GetMapping("/add")
	public void addGET() {
		logger.debug(" /comboard/add -> addGET() 실행! ");
	}
	

}
