package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.component.RecFileComponent;
import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.ResumeVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.RecBottomCategoryVO;
import com.itwillbs.domain.RecTopCategoryVO;
import com.itwillbs.domain.RecTopLocationVO;
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
    public String recWritePOST(HttpSession session,
    		                   RecBoardVO vo,
    		                   @RequestParam(value="thumb", required=false) MultipartFile thumb,
    		                   @RequestParam(value="attachFiles", required=false) List<MultipartFile> attachFiles) throws Exception {

        logger.debug("recWritePOST() 실행!");

        // 로그인 정보
        String corpUserId = (String) session.getAttribute("corpUserId");
        CorpMemberVO recMemInfo = corpMemberService.getCorpMember(corpUserId);

        if (recMemInfo == null) {
            return "redirect:/corp/login";
        }

        vo.setCorp_id(recMemInfo.getCorpId());
        vo.setCorpUserId(recMemInfo.getCorpUserId());
        vo.setManagerName(recMemInfo.getManagerName());
        vo.setManagerEmail(recMemInfo.getManagerEmail());
        vo.setCompanyName(recMemInfo.getCompanyName());

        // 파일 업로드
        String storedThumb = recFileComponent.thumbUpload(thumb);
        List<String> storedAttachList = recFileComponent.attachUpload(attachFiles);
        
        // 첨부파일 업로드
        vo.setThumbFileName(storedThumb);
        vo.setAttachFileName(String.join(",", storedAttachList)); // 여러 파일일 경우 쉼표로 구분
        
        // 게시글 저장
        recBoardService.recUploadBoard(vo);

        logger.debug("recWritePOST() 끝!");
        return "redirect:/recboard/recListCri";
    }
	
	
	@GetMapping("/recListCri")
	public String listPage(Criteria cri,
							@RequestParam(required = false) Integer toplct_id,
							@RequestParam(required = false) Integer topctg_id,
							@RequestParam(required = false) Integer btmctg_id,
							@RequestParam(required = false) String search,
							Model model,
							HttpSession session) throws Exception {

		logger.debug(" recListCri() 실행");
		
        String corpUserId = (String) session.getAttribute("corpUserId");
        CorpMemberVO recMemInfo = corpMemberService.getCorpMember(corpUserId);
        model.addAttribute("recLoginInfo", recMemInfo);
        
        String loginUserId = (String) session.getAttribute("userid");
	    model.addAttribute("loginUserId", loginUserId);

		// 필터 파라미터 로그 확인용
		logger.debug("toplct_id : {}", toplct_id);
		logger.debug("topctg_id : {}", topctg_id);
		logger.debug("btmctg_id : {}", btmctg_id);
		logger.debug("search : {}", search);

		// 게시글 리스트 조회
		List<RecBoardVO> recBoardList = recBoardService.getRecBoardList(cri, toplct_id, topctg_id, btmctg_id, search);
		int totalCount = recBoardService.getRecTotalCount(toplct_id, topctg_id, btmctg_id, search);

		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(totalCount);

		// 직무 / 지역 대분류 목록
		List<RecTopCategoryVO> topCategoryList = recBoardService.getRecTopCategoryList();
		List<RecTopLocationVO> topLocationList = recBoardService.getRecTopLocationList();

		model.addAttribute("recBoardList", recBoardList);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("topCategoryList", topCategoryList);
		model.addAttribute("topLocationList", topLocationList);
		model.addAttribute("search", search);
		
		// 세션영역에 조회수 증가 여부를 판단하는 상태값을 생성
		session.setAttribute("incrementStatus", true);

		return "/recboard/recListCri";
	}

	// 대분류 선택 시 -> 중분류 Ajax 요청
	@ResponseBody
	@GetMapping("/getBottomCategoryList")
	public List<RecBottomCategoryVO> getBottomCategoryList(@RequestParam("topctg_id") int topctg_id) {
	    return recBoardService.getRecBottomCategoryList(topctg_id);
	}
	
	// 게시글 보기
	@GetMapping("/recRead")
	public String recReadGET(HttpSession session,
			                 Model model,
			                 @RequestParam("rec_bno") int rec_bno,
			                 @RequestParam(value="page", defaultValue = "1") int page) throws Exception {
		logger.debug(" recReadGET() 실행! ");
		
		// 회원 정보 불러오기
		String recLoginInfo = (String) session.getAttribute("corpUserId");
		Integer member_id = (Integer) session.getAttribute("memberId");
		//CorpMemberVO recMemInfo = corpMemberService.getCorpMember(recLoginInfo);
		if(recLoginInfo != null) {
			CorpMemberVO recMemInfo = corpMemberService.getCorpMember(recLoginInfo);
			model.addAttribute("recLoginInfo", recMemInfo);
			logger.debug(" 담당자 아이디: "+recMemInfo.getCorpUserId());
			logger.debug(" 소속 회사명: "+recMemInfo.getCompanyName());
			logger.debug(" 담당자 이름: "+recMemInfo.getManagerName());
			logger.debug(" 담당자 이메일: "+recMemInfo.getManagerEmail());
			
		} else if(member_id != null) {
			logger.debug(" 일반회원 접근 (member_id =" + member_id + ")");
			model.addAttribute("member_id", member_id);
			
			// 이미 지원했는지 확인
			boolean alreadyApplied = recBoardService.checkAlreadyApplied(member_id, rec_bno);
			model.addAttribute("alreadyApplied", alreadyApplied);

			// 이력서 목록 전달
			List<ResumeVO> resumeList = recBoardService.getResumeList(member_id);
			logger.debug("이력서 리스트: " + resumeList);
			model.addAttribute("resumeList", resumeList);
			
		}else {
			logger.debug(" 기업회원 로그인 세션이 없습니다.");
		}
		// 디비에서 정보 불러오기
		RecBoardVO resultReadVO = recBoardService.getRecBoard(rec_bno);
		logger.debug(" resultRead: "+resultReadVO);
		
		// 세션영역에 저장된 조회수 변경가능 상태정보를 출력
		Boolean incrementStatus = (Boolean) session.getAttribute("incrementStatus");

		if (incrementStatus == null) {
		    incrementStatus = true;  // 기본 true로 초기화
		    session.setAttribute("incrementStatus", true);
		}

		logger.debug(" incrementStatus: " + incrementStatus);

		if (Boolean.TRUE.equals(incrementStatus)) {
		    recBoardService.recIncreseViewCnt(rec_bno);
		    logger.debug(" 조회수 1 증가! ");

		    session.setAttribute("incrementStatus", false);
		}
		
		model.addAttribute("resultReadVO", resultReadVO);
		logger.debug(" bno 정보: "+resultReadVO.getRec_bno());
		logger.debug(" 썸네일 정보: "+resultReadVO.getThumbFileName());
		logger.debug(" 첨부 파일/사진 정보: "+resultReadVO.getAttachFileName());
		
		logger.debug(" recReadGET() 실행, page=" + page);
	    model.addAttribute("page", page);

		logger.debug(" recReadGET() 실행! ");
		return "/recboard/recRead";
	}
	
	// 게시글 수정 - GET
	@GetMapping("/recUpdate")
	public void recUpdateBoardGET(HttpSession session,
			                      Model model,
			                      @RequestParam("rec_bno") int rec_bno,
			                      @RequestParam(value="page", required=false, defaultValue="1") int page) throws Exception {
		logger.debug(" recUpdateBoardGET() 실행! ");
		
		String corpUserId = (String) session.getAttribute("corpUserId");
        CorpMemberVO recMemInfo = corpMemberService.getCorpMember(corpUserId);
        model.addAttribute("page", page);
		model.addAttribute("recLoginInfo", recMemInfo);
		
		// 수정 대상 게시글 정보
	    RecBoardVO resultReadVO = recBoardService.getRecBoard(rec_bno);
	    model.addAttribute("resultReadVO", resultReadVO);
	    logger.debug(" resultReadVO "+resultReadVO);
	    
	    // 대분류 / 지역 리스트 불러오기 (select box 채우기용)
	    model.addAttribute("topCategoryList", recBoardService.getRecTopCategoryList());
	    model.addAttribute("topLocationList", recBoardService.getRecTopLocationList());
		
		logger.debug(" recUpdateBoardGET() 끝! ");
	}
	
	// 게시글 수정 - POST
	@PostMapping("/recUpdate")
	public String updateRecBoard(RecBoardVO vo,
				        		 @RequestParam(value = "thumb", required = false) MultipartFile thumb,
						         @RequestParam(value = "attachFiles", required = false) List<MultipartFile> attachFiles,
						         RedirectAttributes rttr) throws Exception {

	    logger.debug("updateRecBoard() 실행!");

	    // 기존 게시글 정보 가져오기 (파일명 유지용)
	    RecBoardVO oldVO = recBoardService.getRecBoard(vo.getRec_bno());

	    if (thumb != null && !thumb.isEmpty()) {
	        // 기존 썸네일 삭제
	        if (oldVO.getThumbFileName() != null) {
	            recFileComponent.recDeleteFile(oldVO.getThumbFileName());
	        }
	        // 새 썸네일 업로드
	        String newThumb = recFileComponent.thumbUpload(thumb);
	        vo.setThumbFileName(newThumb);
	    } else {
	        // 새 파일 없으면 기존 유지
	        vo.setThumbFileName(oldVO.getThumbFileName());
	    }

	    if (attachFiles != null && !attachFiles.isEmpty() && !attachFiles.get(0).isEmpty()) {
	        // 기존 첨부파일 삭제
	        if (oldVO.getAttachFileName() != null) {
	            for (String fileName : oldVO.getAttachFileName().split(",")) {
	                recFileComponent.recDeleteFile(fileName.trim());
	            }
	        }
	        // 새 첨부파일 업로드
	        List<String> uploaded = recFileComponent.attachUpload(attachFiles);
	        vo.setAttachFileName(String.join(",", uploaded));
	    } else {
	        // 첨부파일 변경 없을 시 기존 유지
	        vo.setAttachFileName(oldVO.getAttachFileName());
	    }

	    
	    recBoardService.updateRecBoard(vo);

	    rttr.addFlashAttribute("msg", "updateOK");
	    return "redirect:/recboard/recListCri";
	}
	
	// 게시글 삭제 - POST
	@PostMapping("/recDelete")
	public String recDeletePOST(@RequestParam("rec_bno") int rec_bno,
	                            HttpSession session,
	                            RedirectAttributes rttr) throws Exception {
	    logger.debug(" /recboard/recDelete -> recDeletePOST() 실행! ");

	    // 로그인 확인
	    String corpUserId = (String) session.getAttribute("corpUserId");
	    if (corpUserId == null) {
	        rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
	        return "redirect:/corp/login";
	    }

	    // 게시글 정보 불러오기
	    RecBoardVO board = recBoardService.getRecBoard(rec_bno);
	    if (board == null) {
	        rttr.addFlashAttribute("msg", "존재하지 않는 게시글입니다.");
	        return "redirect:/recboard/recListCri";
	    }

	    // 작성자 본인 확인 (보안)
	    if (!corpUserId.equals(board.getCorpUserId())) {
	        rttr.addFlashAttribute("msg", "본인 작성글만 삭제할 수 있습니다.");
	        return "redirect:/recboard/recRead?rec_bno=" + rec_bno;
	    }

	    // 썸네일 삭제
	    if (board.getThumbFileName() != null && !board.getThumbFileName().isEmpty()) {
	        recFileComponent.recDeleteFile(board.getThumbFileName());
	        logger.debug("썸네일 삭제 완료: " + board.getThumbFileName());
	    }

	    // 첨부파일(여러 개) 삭제
	    if (board.getAttachFileName() != null && !board.getAttachFileName().isEmpty()) {
	        String[] attachFiles = board.getAttachFileName().split(",");
	        for (String file : attachFiles) {
	            recFileComponent.recDeleteFile(file.trim());
	            logger.debug("첨부파일 삭제 완료: " + file.trim());
	        }
	    }

	    recBoardService.deleteRecBoard(rec_bno);
	    rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");

	    logger.debug(" /recboard/recDelete -> recDeletePOST() 끝!");
	    return "redirect:/recboard/recListCri";
	}
	
	// (모달)비밀번호 확인 - Ajax
	@PostMapping("/checkPassword")
	@ResponseBody
	public String recCheckPasswordAJAX(@RequestParam("password") String password,
                                       HttpSession session) throws Exception {
		logger.debug(" /recboard/checkPassword -> recCheckPasswordAJAX() 실행! ");
		
		// 회원 정보 가져오기
		String corpUserId = (String) session.getAttribute("corpUserId");
	    if (corpUserId == null) {
	        return "NOT_LOGIN";
	    }
	    
	    CorpMemberVO memberInfo = corpMemberService.getCorpMember(corpUserId);
	    if(memberInfo == null ) {
	    	return "FAIL";
	    }
	    
	    // 회원 정보를 이용하여 개인정보 비교
	    if(memberInfo.getCorpUserPw().equals(password)) {
	    	return "OK";
	    } else {
	    	logger.debug(" /recboard/checkPassword -> recCheckPasswordAJAX() 끝! ");
	    	return "FAIL";
	    }
	    
	}


	
}
