package com.itwillbs.controller;

import java.util.Enumeration;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.itwillbs.component.RecFileComponent;
import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.RecBottomCategoryVO;
import com.itwillbs.service.CorpMemberService;
import com.itwillbs.service.RecBoardService;

@Controller
@RequestMapping("/recboard/*")
public class RecBoardController {

	private static final Logger logger 
		= LoggerFactory.getLogger(RecBoardController.class);
	
	@Inject private RecBoardService recBoardService;
	@Inject private CorpMemberService corpMemberService;
	
	@Inject private RecFileComponent recFileComponent;
	
	// 게시글 작성 (대분류 리스트)
	@GetMapping("/recWrite")
	public String recWriteGET(Model model,
							  HttpSession session) throws Exception {
		logger.debug(" recWriteGET() 실행! ");
		
		// DB에서 대분류, 지역 목록 불러와 JSP로 전달
		model.addAttribute("topCategoryList", recBoardService.getRecTopCategoryList());
		model.addAttribute("topLocationList", recBoardService.getRecTopLocationList());
		
		// 회원 정보 불러오기
		String recLoginInfo = (String) session.getAttribute("corpUserId");
		CorpMemberVO recMemInfo = corpMemberService.getCorpMember(recLoginInfo);
		logger.debug(" 기업 회원 정보: "+recLoginInfo);
		
		model.addAttribute("recLoginInfo", recMemInfo);
		logger.debug(" recWriteGET() 끝! ");
		return "/recboard/recWrite";
	}
	
	// 게시글 작성 (소분류 리스트)
	@ResponseBody
    @GetMapping("/getBottomCategory")
    public List<RecBottomCategoryVO> getBottomCategory(@RequestParam("topctg_id") int topctg_id) {
        return recBoardService.getRecBottomCategoryList(topctg_id);
    }
	
	// 게시글 쓰기
	@PostMapping("/recWrite")
	public String recWritePOST(RecBoardVO vo,
							   HttpSession session,
							   @RequestParam(value="thumbFileName", required=false) MultipartFile thumbFileName,
							   @RequestParam(value="attachFileName", required=false) MultipartFile[] attachFileName) throws Exception {
		logger.debug(" recWritePOST() 실행! ");
		
		// 회원 정보 가져오기
		String recLoginInfo = (String) session.getAttribute("corpUserId");
		CorpMemberVO recMemInfo = corpMemberService.getCorpMember(recLoginInfo);
		logger.debug(" 기업 회원 정보: "+recLoginInfo);
		
		vo.setCorp_id(recMemInfo.getCorpId());
		vo.setCorpUserId(recMemInfo.getCorpUserId());
		vo.setManagerName(recMemInfo.getManagerName());
		vo.setManagerEmail(recMemInfo.getManagerEmail());
		vo.setCompanyName(recMemInfo.getCompanyName());
		
		logger.debug("작성자 기업ID : " + vo.getCorp_id());
	    logger.debug("작성자 기업UserId : " + vo.getCorpUserId());
	    logger.debug("담당자명 : " + vo.getManagerName());
	    logger.debug("담당자 이메일 : " + vo.getManagerEmail());
	    logger.debug("담당자 소속 회사명 : " + vo.getCompanyName());
		 
		// 게시판 정보 DB저장
		recBoardService.writeRecBoard(vo);
	    
		// 썸네일 업로드
		if(!thumbFileName.isEmpty()) {
			String storedFileName = recFileComponent.thumbUpload(thumbFileName);
			recBoardService.uploadFiles(vo.getRec_bno(), "THUMB", 
					                    thumbFileName.getOriginalFilename(), 
					                    storedFileName);
		}
		
		// 첨부 파일 저장
		if(attachFileName != null && attachFileName.length > 0) {
			for (MultipartFile file : attachFileName) {
	            if (!file.isEmpty()) {
	                String stored = recFileComponent.thumbUpload(file);
	                recBoardService.uploadFiles(vo.getRec_bno(), "ATTACH",
	                                            file.getOriginalFilename(), stored);
	            }
	        }
		}
		
		logger.debug(" recWritePOST() 끝! ");
		return "redirect:/recboard/recListCri";
	}
	
	
	// 채용 공고 리스트(페이징)
	@GetMapping("/recListCri")
	public void recListCri(Model model,
			               Criteria cri,
			               HttpSession session,
			               @RequestParam(value = "search", required = false) String search) throws Exception {
		logger.debug(" /recboard/recListCri -> recListCri() 실행! ");
		logger.debug(" 검색어: "+search);
		
		// 회원정보 가져오기
		String recLoginInfo = (String) session.getAttribute("corpUserId");
		logger.debug(" 기업 회원 정보: "+recLoginInfo);
		
		model.addAttribute("recLoginInfo", recLoginInfo);
		// Criteria 객체에서 search 필드 불러오기
		cri.setSearch(search);
		
		// 전체 글 개수 (검색어 포함)
		int totalCount = recBoardService.getRecTotalCount(search);
		
		// 1-1 페이징 처리 객체 pageVO 생성
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(totalCount);
		
		List<RecBoardVO> resultRecList 
			= recBoardService.getRecBoardList(cri);
		logger.debug(" 채용 공고 리스트: "+resultRecList.size());
		logger.debug(" 채용 공고 리스트: "+resultRecList);
		
		model.addAttribute(pageVO);
		model.addAttribute("recBoardList", resultRecList);
		
		logger.debug(" /recboard/recListCri -> recListCri() 끝! ");
	}

	
}
