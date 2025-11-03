package com.itwillbs.controller;

import java.util.List;
import java.util.Map;

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

import com.itwillbs.domain.MemberVO;
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
    public List<Map<String, Object>> topCategory() {
        return reviewService.getTopCategoryList();
    }
    
    // 소분류 가져오기
    @RequestMapping(value="/bottomCategory", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> bottomCategory(@RequestParam("topId") int topId) {
        return reviewService.getBottomCategoryList(topId);
    }

    // 리뷰 작성 폼
    @RequestMapping(value="/insertReview", method = RequestMethod.GET)
    public String insertReviewForm(HttpSession session) {
    	
    	// ========================= 테스트용 세션 시작 =========================
    	if(session.getAttribute("userid") == null) {
    		session.setAttribute("userid", "test01");  // 로그인 아이디 (문자열)
    		session.setAttribute("id", 4);             // DB member PK (정수)
    		System.out.println("[TEST MODE] 세션 자동 생성됨 > user01 / id=1");
    	}
    	// ========================= 테스트용 세션 끝 =========================
    	
    	
    	
    	
    	
    	
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
    public String insertReview(ReviewVO review, HttpSession session) {
    	
    	// ========================= 테스트용 세션 시작 =========================
    	if(session.getAttribute("userid") == null) {
    		session.setAttribute("userid", "test01");  // 로그인 아이디 (문자열)
    		session.setAttribute("id", 4);             // DB member PK (정수)
    		System.out.println("[TEST MODE] 세션 자동 생성됨 > user01 / id=1");
    	}
    	// ========================= 테스트용 세션 끝 =========================
    	
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
    @RequestMapping(value="/updateReview", method = RequestMethod.GET)
	    public String updateReviewForm(@RequestParam("reviewId") int reviewId, HttpSession session, Model model) {
	    
    	// ========================= 테스트용 세션 시작 =========================
    	if(session.getAttribute("userid") == null) {
    		session.setAttribute("userid", "test01");  // 로그인 아이디 (문자열)
    		session.setAttribute("id", 4);             // DB member PK (정수)
    		System.out.println("[TEST MODE] 세션 자동 생성됨 > user01 / id=1");
    	}
    	// ========================= 테스트용 세션 끝 =========================
    	
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

		ReviewVO review = reviewService.reviewDetail(reviewId);
		if (review == null || review.getMemberId() != memberInfo.getId()) {
			return "error/403";
		}
    	
		model.addAttribute("review", review);
		return "review/updateReview";
    }

    // 리뷰 수정 처리
    @RequestMapping(value="/updateReview", method = RequestMethod.POST)
    public String updateReview(ReviewVO review, HttpSession session) {
    	
    	// ========================= 테스트용 세션 시작 =========================
    	if(session.getAttribute("userid") == null) {
    		session.setAttribute("userid", "test01");  // 로그인 아이디 (문자열)
    		session.setAttribute("id", 4);             // DB member PK (정수)
    		System.out.println("[TEST MODE] 세션 자동 생성됨 > user01 / id=1");
    	}
    	// ========================= 테스트용 세션 끝 =========================
    	
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

		ReviewVO original = reviewService.reviewDetail(review.getReviewId());
		if (original == null) {
			return "error/404";
		}
		if (original.getMemberId() != memberInfo.getId()) {
			return "error/403";
		}

		review.setMemberId(memberInfo.getId());
		
    	
    	
		reviewService.updateReview(review);

		return "redirect:/review/reviewDetail?reviewId=" + review.getReviewId();
    }

    // 리뷰 삭제
    @RequestMapping(value="/deleteReview", method = RequestMethod.POST)
    public String deleteReview(@RequestParam("reviewId") int reviewId, HttpSession session) {
    	
    	// ========================= 테스트용 세션 시작 =========================
    	if(session.getAttribute("userid") == null) {
    		session.setAttribute("userid", "test01");  // 로그인 아이디 (문자열)
    		session.setAttribute("id", 4);             // DB member PK (정수)
    		System.out.println("[TEST MODE] 세션 자동 생성됨 > user01 / id=1");
    	}
    	// ========================= 테스트용 세션 끝 =========================
    	
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

		ReviewVO review = reviewService.reviewDetail(reviewId);
		if (review == null || review.getMemberId() != memberInfo.getId()) {
			return "error/403";
		}

    	
		reviewService.deleteReview(reviewId);
		logger.debug("리뷰 삭제 완료 - reviewId: {}", reviewId);
		return "redirect:/review/reviewList";
    }

    // 리뷰 목록
    @RequestMapping(value="/reviewList", method = RequestMethod.GET)
    public String reviewList(Model model) {
    	List<ReviewVO> list = reviewService.reviewList();
    	model.addAttribute("reviewList", list);
    	return "review/reviewList";
    }

    // 리뷰 상세
    @RequestMapping(value="/reviewDetail", method = RequestMethod.GET)
    public String reviewDetail(@RequestParam("reviewId") int reviewId, HttpSession session,Model model) {
    	ReviewVO review = reviewService.reviewDetail(reviewId);
        if (review == null) {
            return "error/404";
        }

        // 세션에서 로그인 사용자 ID 가져오기
        Integer loginUserId = (Integer) session.getAttribute("id");

        // 본인 리뷰인지 체크
        boolean isOwner = loginUserId != null && review.getMemberId() == loginUserId;

        model.addAttribute("reviewDetail", review);
        model.addAttribute("isOwner", isOwner);
        
        logger.debug(" detail 동작 - controller ");
        
        return "review/reviewDetail";
    }

    // 회원별 리뷰
    @RequestMapping(value="/memberReviewList", method = RequestMethod.GET)
    public String selectReviewsByMember(@RequestParam("memberId") int memberId, Model model) {
        List<ReviewVO> list = reviewService.selectReviewsByMember(memberId);
        model.addAttribute("memberReviewList", list);
        model.addAttribute("member_id", memberId);
        return "review/reviewsByMember";
    }

    // 기업별 리뷰
    @RequestMapping(value="/corpReviewList", method = RequestMethod.GET)
    public String selectReviewsByCorp(@RequestParam("corpId") int corpId, Model model) {
        List<ReviewVO> list = reviewService.selectReviewsByCorp(corpId);
        model.addAttribute("corpReviewList", list);
        model.addAttribute("corp_id", corpId);
        return "review/reviewsByCorp";
    }
}
