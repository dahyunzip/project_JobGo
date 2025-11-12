package com.itwillbs.controller;

import java.util.List;
import java.util.Map;
import java.util.Objects;

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

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.ReviewService;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	

    @Inject
    private ReviewService reviewService;
    
    @Inject
    private MemberService memberService;
    
    private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
    
    // 대분류 가져오기
    @RequestMapping(value="/topCategory", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> topCategory() throws Exception{
        return reviewService.getTopCategoryList();
    }
    
    // 소분류 가져오기
    @RequestMapping(value="/bottomCategory", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> bottomCategory(@RequestParam("topId") String topId) throws Exception{
        return reviewService.getBottomCategoryList(topId);
    }

    // 리뷰 작성 폼
    @RequestMapping(value="/insertReview", method = RequestMethod.GET)
    public String insertReviewForm(HttpSession session, Model model) throws Exception{
    	
    	
    	String loginUserid = (String) session.getAttribute("userid");
		if (loginUserid == null) {
			return "redirect:/member/login";
		}

		MemberVO memberInfo = null;
		try {
			memberInfo = memberService.getMember(loginUserid);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/member/login";
		}

		if (memberInfo == null) {
			return "redirect:/member/login";
		}
		
    	
		return "review/insertReview";
    }

    // 리뷰 작성 처리
    @RequestMapping(value="/insertReview", method = RequestMethod.POST)
    public String insertReview(ReviewVO review, HttpSession session) throws Exception{
    	
    	/* ========================= 테스트용 세션 시작 =========================
    	if(session.getAttribute("userid") == null) {
    		session.setAttribute("userid", "test01");  // 로그인 아이디 (문자열)
    		session.setAttribute("id", 4);             // DB member PK (정수)
    		System.out.println("[TEST MODE] 세션 자동 생성됨 > user01 / id=1");
    	}
    	// ========================= 테스트용 세션 끝 =========================*/
    	
    	String loginUserid = (String) session.getAttribute("userid");
		if (loginUserid == null) {
			return "redirect:/member/login";
		}

		MemberVO memberInfo = null;
		try {
			memberInfo = memberService.getMember(loginUserid);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/member/login";
		}

		if (memberInfo == null) {
			return "redirect:/member/login";
		}
		review.setMemberId(memberInfo.getId());
		reviewService.insertReview(review);
		logger.debug("리뷰 작성 완료 - 작성자 ID: {}", memberInfo.getId());

    	
		return "redirect:/review/reviewList";
    }

    // 리뷰 수정 폼
 	@RequestMapping(value = "/updateReview", method = RequestMethod.GET)
 	public String updateReviewForm(@RequestParam("reviewId") int reviewId, HttpSession session, Model model) throws Exception{

 		// 로그인 확인 (userid 기준으로 변경)
 		String loginUserid = (String) session.getAttribute("userid");
 		if (loginUserid == null) {
 			return "redirect:/member/login";
 		}
 		

 		// userid로 member_id(PK) 조회
 		int loginUserId = reviewService.getMemberIdByUserid(loginUserid);

 		// 리뷰 상세
 		ReviewVO review = reviewService.reviewDetail(reviewId);
 		if (review == null) {
 			return "error/404";
 		}

 		logger.debug("로그인 유저 ID: {}", loginUserId);
 		logger.debug("리뷰 작성자 ID: {}", review.getMemberId());
 		
 		// 비교 수정
 		if (!Objects.equals(review.getMemberId(), loginUserId)) {
 			return "error/403";
 		}

 		model.addAttribute("review", review);
 		model.addAttribute("isOwner", true);
 		return "review/updateReview";
 	}

 	// 리뷰 수정 처리
 	@RequestMapping(value = "/updateReview", method = RequestMethod.POST)
 	public String updateReview(ReviewVO review, HttpSession session) throws Exception{
 		if (session.getAttribute("id") == null) {
 			return "redirect:/member/login";
 		}

 		Integer loginUserId = (Integer) session.getAttribute("id");
 		ReviewVO original = reviewService.reviewDetail(review.getReviewId());

 		if (original == null) {
 			return "error/404";
 		}

 		if (original.getMemberId() != loginUserId) {
 			return "error/403";
 		}

 		review.setMemberId(loginUserId);
 		reviewService.updateReview(review);

 		return "redirect:/review/reviewDetail?reviewId=" + review.getReviewId();
 	}

 	// 리뷰 삭제
 	@RequestMapping(value = "/deleteReview", method = RequestMethod.POST)
 	public String deleteReview(@RequestParam("reviewId") int reviewId,
 							   @RequestParam("password") String password,
 							   HttpSession session, Model model) throws Exception{
 		String userid = (String) session.getAttribute("userid");
 		logger.debug("세션 userid = {}", userid);

 		// 로그인 여부 확인
 		if (userid == null || userid.trim().isEmpty()) {
 			logger.warn("로그인되지 않은 상태에서 삭제 시도");
 			return "redirect:/member/login";
 		}

 		// DB에서 member_id 조회
 		Integer loginUserId = reviewService.getMemberIdByUserid(userid);
 		if (loginUserId == null) {
 			logger.warn("DB에서 member_id 조회 실패 (userid={})", userid);
 			model.addAttribute("errorMsg", "회원 정보 조회 실패");
 			return "redirect:/member/login";
 		}

 		// 리뷰 상세 조회
 		ReviewVO review = reviewService.reviewDetail(reviewId);
 		if (review == null) {
 			return "error/404";
 		}

 		// 작성자 본인 여부 확인
 		if (!java.util.Objects.equals(review.getMemberId(), loginUserId)) {
 			logger.warn("작성자 불일치 (review.memberId={}, loginUserId={})",
 				review.getMemberId(), loginUserId);
 			return "error/403";
 		}

 		// 비밀번호 일치 여부 확인
 		String dbPw = reviewService.getMemberPasswordByReviewId(reviewId);
 		if (dbPw == null || !dbPw.equals(password)) {
 			model.addAttribute("reviewDetail", review);
 			model.addAttribute("isOwner", true);
 			model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
 			return "review/reviewDetail";
 		}

 		// 리뷰 삭제 실행
 		reviewService.deleteReview(reviewId);
 		logger.debug("리뷰 삭제 완료 - reviewId: {}", reviewId);

 		return "redirect:/review/reviewList";
 	}

    // 리뷰 목록
    @RequestMapping(value="/reviewList", method = RequestMethod.GET)
    public String reviewList(Criteria cri, Model model) throws Exception {
		
		List<ReviewVO> reviewList = reviewService.getListPaging(cri);
		model.addAttribute("reviewList", reviewList);

		int total = reviewService.getTotalCount(cri);
		model.addAttribute("pageVO", new PageVO(cri, total));

		logger.debug(" 리뷰 전체 목록 조회 완료");

    	return "/review/list";
    }

    // 리뷰 상세
 	@RequestMapping(value = "/reviewDetail", method = RequestMethod.GET)
 	public String reviewDetail(@RequestParam("reviewId") int reviewId, HttpSession session, Model model) throws Exception{
 		ReviewVO review = reviewService.reviewDetail(reviewId);
 		if (review == null) {
 			return "error/404";
 		}

 		// 세션에서 userid 가져오기
 		String loginUserid = (String) session.getAttribute("userid");

 		boolean isOwner = false;
 		if (loginUserid != null) {  // 로그인한 경우만 비교
 			Integer loginUserId = reviewService.getMemberIdByUserid(loginUserid);
 			if (loginUserId != null) {
 				isOwner = (review.getMemberId() == loginUserId);
 			}
 		}
 		
 		String companyName = reviewService.getCompanyNameByCorpId(review.getCorpId());

 		model.addAttribute("reviewDetail", review);
 		model.addAttribute("isOwner", isOwner);
 		model.addAttribute("companyName", companyName);

 		logger.debug("리뷰 상세 진입 - reviewId: {}, companyName: {}", reviewId, companyName);
 		return "review/reviewDetail";
 	}

    // 회원별 리뷰
    @RequestMapping(value="/memberReviewList", method = RequestMethod.GET)
    public String selectReviewsByMember(@RequestParam("memberId") int memberId, Criteria cri, Model model) throws Exception{
    	List<ReviewVO> reviewList = reviewService.getListByMemberPaging(memberId, cri);
		model.addAttribute("reviewList", reviewList);

		int total = reviewService.getTotalByMember(memberId);
		model.addAttribute("pageVO", new PageVO(cri, total));
		model.addAttribute("memberId", memberId);

		logger.debug(" 회원별 리뷰 목록 조회 완료 - 총 {}개", total);        return "review/reviewsByMember";
    }

    // 기업별 리뷰
    @RequestMapping(value="/corpReviewList", method = RequestMethod.GET)
    public String reviewListByCorp(@RequestParam("corpId") int corpId, Criteria cri, Model model) throws Exception {
		
		List<ReviewVO> reviewList = reviewService.getListByCorpPaging(corpId, cri);
		model.addAttribute("reviewList", reviewList);

		int total = reviewService.getTotalByCorp(corpId);
		model.addAttribute("pageVO", new PageVO(cri, total));
		model.addAttribute("corpId", corpId);

		logger.debug(" 기업별 리뷰 목록 조회 완료 - 총 {}개", total);
        return "review/reviewsByCorp";
    }
}
