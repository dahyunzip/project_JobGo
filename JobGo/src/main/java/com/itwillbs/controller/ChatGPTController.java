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
	
	// 커뮤니티 게시글 맞춤법 교정
	@RequestMapping(value="/comboard/grammarCheck", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String correctCommunityText(@RequestParam("content") String content) throws Exception {

	    logger.info("커뮤니티 맞춤법 요청 도착 : " + content);

	    String systemPrompt = "다음 문장의 맞춤법, 띄어쓰기, 오타를 정확하게 수정해줘. "
	            + "문장의 말투, 감정, 분위기, 표현 방식은 그대로 유지하되 "
	            + "잘못된 단어나 비표준어는 올바른 형태로 바꿔줘. "
	            + "단, 문장 구조를 크게 바꾸지 말고, 문장의 흐름을 해치지 않는 선에서만 최소한으로 수정해줘. "
	            + "설명 없이 수정된 문장만 출력해줘. ";
	   
	    String userPrompt = content;

	    return gptService.askChatGPT(systemPrompt, userPrompt);
	}
	
	// 회사 소개 및 주요 업무 첨삭
	@RequestMapping(value="/recboard/gpt/maintask", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String rewriteMainTask(@RequestParam("content") String content) throws Exception {
	    String systemPrompt =
	        "아래 내용은 회사 소개와 주요 업무가 섞여 있는 문장이다. "
	        + "이를 채용 공고에 어울리는 형식으로 자연스럽게 정리해줘. "
	        + "1) 회사 소개는 간단하고 친절한 문장으로 요약하고, "
	        + "2) 주요 업무는 • 또는 ✔️ 글머리 기호를 사용해 정돈하되, "
	        + "필요하다면 적절한 이모지를 소량만 사용해도 좋아. "
	        + "문체는 공고 스타일로 유지하되, 불필요한 표현은 다듬고 전체 의미는 유지해줘. "
	        + "설명 없이 정리된 결과만 출력해줘.";

	    return gptService.askChatGPT(systemPrompt, content);
	}

	// 자격 요건
	@RequestMapping(value="/recboard/gpt/qualification", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String rewriteQualification(@RequestParam("content") String content) throws Exception {
	    String systemPrompt =
	        "다음 '자격 요건' 내용을 깔끔하게 정리해줘. "
	        + "조건을 불릿 포인트로 정리하고, 문장은 간결하게 유지해줘. "
	        + "설명 없이 결과만 출력.";

	    return gptService.askChatGPT(systemPrompt, content);
	}

	// 우대 사항
	@RequestMapping(value="/recboard/gpt/preference", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String rewritePreference(@RequestParam("content") String content) throws Exception {
	    String systemPrompt =
	        "다음 '우대 사항' 내용을 정돈해줘. "
	        + "중복 표현은 줄이고, 보기 좋게 불릿 리스트로 작성해줘. "
	        + "설명 없이 결과만 출력.";

	    return gptService.askChatGPT(systemPrompt, content);
	}

	// 복리 후생
	@RequestMapping(value="/recboard/gpt/benefit", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String rewriteBenefit(@RequestParam("content") String content) throws Exception {
	    String systemPrompt =
	        "다음 '복리 후생' 내용을 깔끔하고 보기 좋게 정리해줘. "
	        + "이모지를 과하지 않게 적절히 사용해도 좋고, 리스트는 간결하게 구성해줘. "
	        + "설명 없이 결과만 출력.";

	    return gptService.askChatGPT(systemPrompt, content);
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
