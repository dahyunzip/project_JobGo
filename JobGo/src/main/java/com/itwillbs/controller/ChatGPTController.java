package com.itwillbs.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.service.ChatGPTService;

@Controller
public class ChatGPTController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChatGPTController.class);
	
	@Inject
	private ChatGPTService gptService;
	
	@RequestMapping(value="/resume/selfIntro/feedback", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String getSelfIntroFeedback(@RequestParam("content") String content) throws Exception {
	    logger.info("자기소개 첨삭 요청 도착: " + content);

	    // 프롬프트 설정 (GPT에게 요청할 문장)
	    String systemPrompt = "다음 자기소개서 문장을 이력서에 어울리게 문맥이 자연스러우면서 문법적으로 올바르게 첨삭해줘. "
	                  + "불필요한 표현은 간결하게 다듬되, 전체 의미는 유지해줘."
	                  + "가져올 때 최대 1000글자 이내로 가져오고 별 다른 설명없이 데이터만 가져와.";
	    
	    String userPrompt = content;

	    String result = gptService.askChatGPT(systemPrompt, userPrompt);

	    return result;
	}
	
	@RequestMapping(value="/comboard/grammarCheck", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String correctCommunityText(@RequestParam("content") String content) throws Exception {

	    logger.info("커뮤니티 맞춤법 요청 도착 : " + content);

	    String systemPrompt = "다음 문장의 맞춤법, 띄어쓰기, 오타만 수정해줘. "
	            + "문장의 표현 방식, 어투, 감정, 문체는 절대로 바꾸지 마. "
	            + "단어 선택이나 문장 구조를 바꾸지 말고, 원래 문장을 최대한 유지하면서 오류만 바로잡아줘. "
	            + "설명 없이 수정된 문장만 출력해줘.";
	   
	    String userPrompt = content;

	    return gptService.askChatGPT(systemPrompt, userPrompt);
	}
	
//	@RequestMapping(value="/ask", method=RequestMethod.GET)
//	public String startGPT() throws Exception{
//		logger.info(" startGPT() 실행!");
//		logger.info("/views/gpt/startGPT.jsp 페이지 이동");
//		return "/gpt/startGPT";
//	}
//	
//	@RequestMapping(value="/sendAsk", method=RequestMethod.POST)
//	public String sendGPT(@RequestParam("prompt") String prompt, Model model) throws Exception{
//		logger.info(" sendGPT() 실행! ");
//		
//		// 1. 전달된 파라메터 정보를 저장
//		logger.info(" prompt : " + prompt);
//		
//		// 2. 그 정보를 사용해서 처리 (API 호출)
//		String result = gptService.askChatGPT(prompt);
//		
//		// 3. 그 결과를 받아서 뷰페이지로 전달
//		model.addAttribute("prompt", prompt);
//	    model.addAttribute("result", result);
//	    
//		return "/gpt/startGPT";
//	}
	
}
