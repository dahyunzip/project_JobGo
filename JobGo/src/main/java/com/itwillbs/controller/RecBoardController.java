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
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.ResumeVO;
import com.itwillbs.domain.RecCriteria;       // 🔥 추가
import com.itwillbs.domain.RecPageVO;        // 🔥 추가
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
	
	// 게시글 작성(GET)
	@GetMapping("/recWrite")
	public String recWriteGET(Model model,
							  HttpSession session,
							  @RequestParam(value="recPage", required=false, defaultValue="1") int recPage) throws Exception {

		logger.debug(" recWriteGET() 실행! ");
		
		model.addAttribute("topCategoryList", recBoardService.getRecTopCategoryList());
		model.addAttribute("topLocationList", recBoardService.getRecTopLocationList());
		
		String recLoginInfo = (String) session.getAttribute("corpUserId");
		CorpMemberVO recMemInfo = corpMemberService.getCorpMember(recLoginInfo);

		model.addAttribute("recLoginInfo", recMemInfo);
		model.addAttribute("recPage", recPage);

		logger.debug(" recWriteGET() 끝! ");
		return "/recboard/recWrite";
	}
	
	// 소분류 AJAX
	@ResponseBody
    @GetMapping("/getBottomCategory")
    public List<RecBottomCategoryVO> getBottomCategory(@RequestParam("topctg_id") int topctg_id) {
        return recBoardService.getRecBottomCategoryList(topctg_id);
    }
	
	// 게시글 작성 POST
    @PostMapping("/recWrite")
    public String recWritePOST(HttpSession session,
    		                   RecBoardVO vo,
    		                   @RequestParam(value="thumb", required=false) MultipartFile thumb,
    		                   @RequestParam(value="attachFiles", required=false) List<MultipartFile> attachFiles) throws Exception {

        logger.debug("recWritePOST() 실행!");

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

        String storedThumb = recFileComponent.thumbUpload(thumb);
        List<String> storedAttachList = recFileComponent.attachUpload(attachFiles);

        vo.setThumbFileName(storedThumb);
        vo.setAttachFileName(String.join(",", storedAttachList));
        
        recBoardService.recUploadBoard(vo);

        logger.debug("recWritePOST() 끝!");
        return "redirect:/recboard/recListCri";
    }
	
	
 
	// RecCriteria / RecPageVO 적용된 목록 페이지
	@GetMapping("/recListCri")
	public String listPage(
			RecCriteria cri,
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

		// 게시글 리스트 조회
		List<RecBoardVO> recBoardList =
			recBoardService.getRecBoardList(cri, toplct_id, topctg_id, btmctg_id, search);

		int totalCount =
			recBoardService.getRecTotalCount(toplct_id, topctg_id, btmctg_id, search);

		RecPageVO recPageVO = new RecPageVO();   // 🔥 변경됨
		recPageVO.setCri(cri);
		recPageVO.setTotalCount(totalCount);

		model.addAttribute("recBoardList", recBoardList);
		model.addAttribute("recPageVO", recPageVO);

		model.addAttribute("topCategoryList", recBoardService.getRecTopCategoryList());
		model.addAttribute("topLocationList", recBoardService.getRecTopLocationList());
		model.addAttribute("search", search);

		session.setAttribute("incrementStatus", true);

		return "/recboard/recListCri";
	}

	
	// 게시글 보기
	@GetMapping("/recRead")
	public String recReadGET(HttpSession session,
			                 Model model,
			                 @RequestParam("rec_bno") int rec_bno,
			                 @RequestParam(value="recPage", defaultValue = "1") int recPage) throws Exception {

		logger.debug(" recReadGET() 실행! ");

		String recLoginInfo = (String) session.getAttribute("corpUserId");
		Integer member_id = (Integer) session.getAttribute("memberId");

		if(recLoginInfo != null) {
			CorpMemberVO recMemInfo = corpMemberService.getCorpMember(recLoginInfo);
			model.addAttribute("recLoginInfo", recMemInfo);

		} else if(member_id != null) {

			model.addAttribute("member_id", member_id);
			
			boolean alreadyApplied = recBoardService.checkAlreadyApplied(member_id, rec_bno);
			model.addAttribute("alreadyApplied", alreadyApplied);

			List<ResumeVO> resumeList = recBoardService.getResumeList(member_id);
			model.addAttribute("resumeList", resumeList);
		}

		RecBoardVO resultReadVO = recBoardService.getRecBoard(rec_bno);

		Boolean incrementStatus = (Boolean) session.getAttribute("incrementStatus");
		if (incrementStatus == null) {
		    incrementStatus = true;
		    session.setAttribute("incrementStatus", true);
		}

		if (Boolean.TRUE.equals(incrementStatus)) {
		    recBoardService.recIncreseViewCnt(rec_bno);
		    session.setAttribute("incrementStatus", false);
		}
		
		model.addAttribute("resultReadVO", resultReadVO);
		model.addAttribute("recPage", recPage);

		return "/recboard/recRead";
	}

	
	// 수정(GET)
	@GetMapping("/recUpdate")
	public void recUpdateBoardGET(HttpSession session,
			                      Model model,
			                      @RequestParam("rec_bno") int rec_bno,
			                      @RequestParam(value="recPage", required=false, defaultValue="1") int recPage) throws Exception {

		logger.debug(" recUpdateBoardGET() 실행! ");
		
		String corpUserId = (String) session.getAttribute("corpUserId");
		CorpMemberVO recMemInfo = corpMemberService.getCorpMember(corpUserId);

		model.addAttribute("recPage", recPage);
		model.addAttribute("recLoginInfo", recMemInfo);
		model.addAttribute("resultReadVO", recBoardService.getRecBoard(rec_bno));

		model.addAttribute("topCategoryList", recBoardService.getRecTopCategoryList());
		model.addAttribute("topLocationList", recBoardService.getRecTopLocationList());
		
		logger.debug(" recUpdateBoardGET() 끝! ");
	}

	
	// 수정(POST)
	@PostMapping("/recUpdate")
	public String updateRecBoard(RecBoardVO vo,
			                     @RequestParam("recPage") int recPage,
				        		 @RequestParam(value = "thumb", required = false) MultipartFile thumb,
						         @RequestParam(value = "attachFiles", required = false) List<MultipartFile> attachFiles,
						         RedirectAttributes rttr) throws Exception {

	    logger.debug("updateRecBoard() 실행!");

	    RecBoardVO oldVO = recBoardService.getRecBoard(vo.getRec_bno());

	    if (thumb != null && !thumb.isEmpty()) {
	        if (oldVO.getThumbFileName() != null) {
	            recFileComponent.recDeleteFile(oldVO.getThumbFileName());
	        }
	        String newThumb = recFileComponent.thumbUpload(thumb);
	        vo.setThumbFileName(newThumb);
	    } else {
	        vo.setThumbFileName(oldVO.getThumbFileName());
	    }

	    if (attachFiles != null && !attachFiles.isEmpty() && !attachFiles.get(0).isEmpty()) {
	        if (oldVO.getAttachFileName() != null) {
	            for (String fileName : oldVO.getAttachFileName().split(",")) {
	                recFileComponent.recDeleteFile(fileName.trim());
	            }
	        }
	        List<String> uploaded = recFileComponent.attachUpload(attachFiles);
	        vo.setAttachFileName(String.join(",", uploaded));
	    } else {
	        vo.setAttachFileName(oldVO.getAttachFileName());
	    }

	    recBoardService.updateRecBoard(vo);
	    
	    rttr.addAttribute("recPage", recPage);
	    rttr.addFlashAttribute("msg", "updateOK");
	    return "redirect:/recboard/recListCri";
	}
	
	
	@PostMapping("/recDelete")
	public String recDeletePOST(@RequestParam("rec_bno") int rec_bno,
								@RequestParam("recPage") int recPage,
								HttpSession session,
	                            RedirectAttributes rttr) throws Exception {

	    String corpUserId = (String) session.getAttribute("corpUserId");

	    if (corpUserId == null) {
	        rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
	        return "redirect:/corp/login";
	    }

	    RecBoardVO board = recBoardService.getRecBoard(rec_bno);
	    if (board == null) {
	        rttr.addFlashAttribute("msg", "존재하지 않는 게시글입니다.");
	        rttr.addAttribute("recPage", recPage);
	        return "redirect:/recboard/recListCri";
	    }

	    if (!corpUserId.equals(board.getCorpUserId())) {
	        rttr.addFlashAttribute("msg", "본인 작성글만 삭제할 수 있습니다.");
	        rttr.addAttribute("recPage", recPage);
	        return "redirect:/recboard/recRead?rec_bno=" + rec_bno;
	    }

	    if (board.getThumbFileName() != null && !board.getThumbFileName().isEmpty()) {
	        recFileComponent.recDeleteFile(board.getThumbFileName());
	    }

	    if (board.getAttachFileName() != null && !board.getAttachFileName().isEmpty()) {
	        String[] attachFiles = board.getAttachFileName().split(",");
	        for (String file : attachFiles) {
	            recFileComponent.recDeleteFile(file.trim());
	        }
	    }

	    recBoardService.deleteRecBoard(rec_bno);
	    rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
	    rttr.addAttribute("recPage", recPage);
	    
	    return "redirect:/recboard/recListCri";
	}
	
	
	@PostMapping("/checkPassword")
	@ResponseBody
	public String recCheckPasswordAJAX(@RequestParam("password") String password,
                                       HttpSession session) throws Exception {
	    
		String corpUserId = (String) session.getAttribute("corpUserId");
	    if (corpUserId == null) return "NOT_LOGIN";
	    
	    CorpMemberVO memberInfo = corpMemberService.getCorpMember(corpUserId);
	    if(memberInfo == null ) return "FAIL";
	    
	    return memberInfo.getCorpUserPw().equals(password) ? "OK" : "FAIL";
	}
}