package com.itwillbs.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.CorpMemberService;
import com.itwillbs.service.CorpMemberServiceImpl;

@Controller
@RequestMapping(value="/corp/*")
public class CorpMemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(CorpMemberController.class);
	
	@Inject
	private CorpMemberService cService;
	
	// 기업회원 회원가입
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String corpJoinGET() {
		return "/corp/join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String corpJoinPOST(CorpMemberVO vo, RedirectAttributes rttr) throws Exception{
		logger.debug("기업회원 회원가입 요청: {}", vo);
		
		// 약관 동의값 보정
	    if (vo.getCorpAgreeLocation() == null) vo.setCorpAgreeLocation("N");
	    if (vo.getCorpAgreeEmail() == null) vo.setCorpAgreeEmail("N");
	    if (vo.getCorpAgreeSms() == null) vo.setCorpAgreeSms("N");
		
		try {
			cService.registerCorpMember(vo);
			rttr.addFlashAttribute("msg", "joinSuccess");
			logger.debug(" 회원가입 성공 !");
		}catch(Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg","joinFail");
			logger.debug(" 회원가입 실패 !");
		}
		return "redirect:/corp/login";
	}
	
	//아이디 중복 검사
	@RequestMapping(value="/idCheck", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam("corpUserId") String corpUserId) throws Exception{
		logger.debug("idCheck 호출 — userid 값: {}", corpUserId);
		boolean available = cService.isUseridAvailable(corpUserId);
		Map<String, Object> result = new HashMap<>();
		result.put("available", available);
		result.put("message", available ? "사용 가능한 아이디입니다." : "이미 사용중인 아이디 입니다.");
		return result;
	}
	
	// 기업회원 로그인
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginGET() {
		return "/corp/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginPOST(@RequestParam("corpUserId") String corpUserId,
							@RequestParam("corpUserPw") String corpUserPW,
							HttpSession session,
							Model model,
							RedirectAttributes rttr) throws Exception{
		logger.debug("기업회원 로그인 시작 - loginPOST ");
		CorpMemberVO loginVO = cService.login(corpUserId, corpUserPW);
		
		if(loginVO != null && !"D".equals(loginVO.getStatus())) {
			logger.debug("loginVO.getCorpUserId() : " + loginVO.getCorpUserId());
			session.setAttribute("corpUserId", loginVO.getCorpUserId());
			session.setAttribute("companyName", loginVO.getCompanyName());
			session.setAttribute("userType", "corp");
			rttr.addFlashAttribute("msg", "loginSuccess");
			logger.debug(" 로그인 성공 ");
			return "redirect:/";
		}else if(loginVO != null && "D".equals(loginVO.getStatus())){
			model.addAttribute("msg", "notAllowed");
			return "/corp/login";
		}else {
			logger.debug(" 로그인 실패 ");
			model.addAttribute("msg", "loginFail");
			return "/corp/login";
		}
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String main() {
		return "redirect:/";
	}
	
	// 마이페이지 (내 정보 조회)
	@RequestMapping(value="/mypage", method=RequestMethod.GET)
	public String corpInfoGET(HttpSession session, Model model) throws Exception{
		String corpUserId = (String) session.getAttribute("corpUserId");
		CorpMemberVO userVO = cService.getCorpMember(corpUserId);
		model.addAttribute("corpuser", userVO);
		return "/corp/mypage";
	}
	
	// 내 정보 수정하기 GET
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String corpModifyGET(HttpSession session, Model model) throws Exception{
		String corpUserId = (String) session.getAttribute("corpUserId");
		CorpMemberVO userVO = cService.getCorpMember(corpUserId);
		model.addAttribute("corpuser", userVO);
		return "/corp/modify";
	}
	
	// 내 정보 수정하기 POST
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String corpModifyPOST(CorpMemberVO vo,
								RedirectAttributes rttr,
								HttpSession session) throws Exception{
		logger.debug("corpModifyPOST() 실행!");
	    logger.debug("입력된 VO : {}", vo);
		
	    String corpUserId = (String) session.getAttribute("corpUserId");
	    
	    if (corpUserId == null) {
	        rttr.addFlashAttribute("msg", "sessionExpired");
	        return "redirect:/corp/login";
	    }
	    
		// 체크박스 미선택 시 N으로 설정
	    if (vo.getCorpAgreeLocation() == null || !"Y".equals(vo.getCorpAgreeLocation()))
	        vo.setCorpAgreeLocation("N");
	    if (vo.getCorpAgreeEmail() == null || !"Y".equals(vo.getCorpAgreeEmail()))
	        vo.setCorpAgreeEmail("N");
	    if (vo.getCorpAgreeSms() == null || !"Y".equals(vo.getCorpAgreeSms()))
	        vo.setCorpAgreeSms("N");
	    
	    // 회원 기본 정보 수정
	    try {
	        cService.modifyCorp(vo);
	        logger.debug("기본 회원 정보 수정 완료");
	    } catch (Exception e) {
	        logger.error("회원 정보 수정 중 오류 발생", e);
	        rttr.addFlashAttribute("msg", "modifyFail");
	        return "redirect:/corp/mypage";
	    }
		
	    // 프로필 이미지 업로드
	    MultipartFile profileFile = vo.getCorpProfileUpload();
	    if (profileFile != null && !profileFile.isEmpty()) {
	        logger.debug("새 프로필 이미지 업로드 감지 !");
	        try {
	            cService.updateCorpProfileImage(vo);
	            logger.debug("기업 프로필 이미지 업로드 성공!");
	        } catch (Exception e) {
	            logger.error("프로필 이미지 업로드 실패", e);
	            rttr.addFlashAttribute("msg", "profileUploadFail");
	        }
	    } else {
	        logger.debug("프로필 이미지 변경 없음");
	    }
		
		rttr.addFlashAttribute("msg", "modifySuccess");
	    logger.debug("corpModifyPOST() 종료");
		return "redirect:/corp/mypage";
	}
	
	// 회원 탈퇴
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String corpDeleteGET(HttpSession session, Model model) throws Exception {
	    String corpUserId = (String) session.getAttribute("corpUserId");
	    if (corpUserId == null) {
	        return "redirect:/corp/login";
	    }

	    CorpMemberVO corpuser = cService.getCorpMember(corpUserId);
	    model.addAttribute("corpuser", corpuser);
	    return "/corp/delete";
	}
	
	// 기업회원 탈퇴 POST - 실제 처리
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String corpDeletePOST(@RequestParam("corpUserId") String corpUserId,
	                             @RequestParam(value="agreeCheck", required=false) String agreeCheck,
	                             @RequestParam(value="confirmText", required=false) String confirmText,
	                             RedirectAttributes rttr,
	                             HttpSession session) throws Exception {

	    logger.debug("기업회원 탈퇴 요청: corpUserId = {}", corpUserId);

	    // 유효성 검사
	    if(agreeCheck == null || !"탈퇴하겠습니다.".equals(confirmText)) {
	        rttr.addFlashAttribute("msg", "dropFail");
	        return "redirect:/corp/delete";
	    }

	    // 실제 탈퇴 처리
	    cService.deleteCorpMember(corpUserId);
	    session.invalidate();

	    rttr.addFlashAttribute("msg", "deleteSuccess");
	    logger.debug("기업회원 탈퇴 완료: corpUserId = {}", corpUserId);

	    return "redirect:/corp/login";
	}
	
	/* =============================
     * 기업회원 아이디 / 비밀번호 찾기
     * ============================= */

    // 아이디 찾기 페이지
	@RequestMapping(value="/findId", method=RequestMethod.GET)
    public String findIdPage(HttpSession session) {
		session.setAttribute("userType", "corp");
        return "/common/findId";
    }

    // 아이디 찾기 처리
	@RequestMapping(value="/findId", method=RequestMethod.POST)
    public String findId(@RequestParam("managerEmail") String email, Model model) throws Exception {
        logger.debug("기업회원 아이디 찾기 요청 - email: {}", email);
        String corpUserId = cService.findCorpUserIdByEmail(email);
        if (corpUserId != null) {
            model.addAttribute("corpUserId", corpUserId);
            return "/common/findIdResult";
        } else {
            model.addAttribute("msg", "등록된 이메일이 없습니다.");
            return "/common/findId";
        }
    }

    // 비밀번호 찾기 페이지
	@RequestMapping(value="/findPw", method=RequestMethod.GET)
    public String findPwPage(HttpSession session) {
		session.setAttribute("userType", "corp");
        return "/common/findPw";
    }

    // 비밀번호 찾기 처리 (메일 전송)
	@RequestMapping(value="/findPw", method=RequestMethod.POST)
    public String findPw(@RequestParam("managerEmail") String email, Model model) throws Exception {
        logger.debug("기업회원 비밀번호 찾기 요청 - email: {}", email);
        CorpMemberVO vo = cService.findCorpMemberByEmail(email);

        if (vo == null) {
            model.addAttribute("msg", "등록된 이메일이 없습니다.");
            return "/common/findPw";
        }

        String token = UUID.randomUUID().toString();
        cService.sendResetMail(email, token);

        model.addAttribute("msg", "비밀번호 재설정 메일이 발송되었습니다. 이메일을 확인해주세요.");
        return "/common/findPw";
    }

    // 비밀번호 재설정 폼
	@RequestMapping(value="/resetPw", method=RequestMethod.GET)
    public String resetPwPage(@RequestParam("token") String token, Model model) {
        String email = cService.getEmailByToken(token);
        if (email == null) {
            model.addAttribute("msg", "유효하지 않거나 만료된 링크입니다.");
            return "/common/resetFail";
        }
        model.addAttribute("managerEmail", email);
        model.addAttribute("token", token);
        return "/common/resetPwForm";
    }

    // 비밀번호 재설정 처리
	@RequestMapping(value="/resetPw", method=RequestMethod.POST)
    public String resetPw(@RequestParam("managerEmail") String email,
                          @RequestParam("newPw") String newPw,
                          @RequestParam("token") String token,
                          RedirectAttributes rttr) throws Exception {
        cService.updatePasswordByEmail(email, newPw);
        cService.invalidateToken(token);
        rttr.addFlashAttribute("msg", "resetPwSuccess");
        return "redirect:/corp/login";
    }
}
