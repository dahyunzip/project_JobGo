package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.service.ReviewService;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	@Inject
	private ReviewService reviewService;
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	// 리뷰 작성
	@RequestMapping(value="/insertReview", method = RequestMethod.GET)
	public String insertReviewForm() {
		logger.debug(" 리뷰 작성 이동 ");
		
		return "review/insertReview";
	}
	
	@RequestMapping(value="/insertReview", method = RequestMethod.POST)
	public String insertReview(ReviewVO review, HttpSession session) {
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

	    // 로그인 확인
	    if (loginMember == null) {
	        logger.debug("비로그인 상태에서 리뷰 작성 시도");
	        return "redirect:/login";
	    }

	    // 세션의 회원 ID를 주입
	    review.setMember_id(loginMember.getId());
	    reviewService.insertReview(review);

	    logger.debug("리뷰 작성 완료 - 작성자 ID: {}", loginMember.getId());
	    return "redirect:/review/reviewList";
	}
	
	// 리뷰 수정
	@RequestMapping(value="/updateReview", method = RequestMethod.GET)
	public String updateReviewForm(ReviewVO review, HttpSession session) {
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

	    if (loginMember == null) {
	        return "redirect:/login";
	    }

	    ReviewVO review = reviewService.reviewDetail(review_id);
	    if (review == null) {
	        logger.debug("리뷰 없음 - ID: {}", review_id);
	        return "error/404";
	    }

	    // 본인 리뷰가 아닌 경우 접근 차단
	    if (review.getMember_id() != loginMember.getId()) {
	        logger.debug("리뷰 수정 접근 권한 없음 - 로그인 ID: {}, 리뷰 작성자: {}", 
	                    loginMember.getId(), review.getMember_id());
	        return "error/404";
	    }

	    model.addAttribute("review", review);
	    logger.debug("리뷰 수정 폼 이동 - 리뷰 ID: {}", review_id);
	    return "review/updateReview";
	}
	
	
	@RequestMapping(value="/updateReview", method = RequestMethod.POST)
	public String updateReview(ReviewVO review, HttpSession session) {
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

	    if (loginMember == null) {
	        return "redirect:/login";
	    }

	    ReviewVO original = reviewService.reviewDetail(review.getReview_id());
	    if (original == null) {
	        logger.warn("수정 대상 리뷰 없음 - ID: {}", review.getReview_id());
	        return "error/404";
	    }

	    if (original.getMember_id() != loginMember.getId()) {
	        logger.warn("리뷰 수정 권한 없음 - 로그인 ID: {}, 리뷰 작성자: {}", 
	                    loginMember.getId(), original.getMember_id());
	        return "error/403";
	    }

	    review.setMember_id(loginMember.getId()); // 본인 ID로 고정
	    reviewService.updateReview(review);

	    logger.debug("리뷰 수정 완료 - 리뷰 ID: {}", review.getReview_id());
	    return "redirect:/review/reviewDetail?review_id=" + review.getReview_id();
	}
	
	// 리뷰 삭제
	@RequestMapping(value="/deleteReview", method = RequestMethod.POST)
	public String deleteReview(int review_id) {
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

	    if (loginMember == null) {
	        return "redirect:/login";
	    }

	    ReviewVO review = reviewService.reviewDetail(review_id);
	    if (review == null) {
	        logger.warn("삭제 대상 리뷰 없음 - ID: {}", review_id);
	        return "error/404";
	    }

	    // 작성자 확인
	    if (review.getMember_id() != loginMember.getId()) {
	        logger.warn("리뷰 삭제 권한 없음 - 로그인 ID: {}, 리뷰 작성자: {}", 
	                    loginMember.getId(), review.getMember_id());
	        return "error/403";
	    }

	    reviewService.deleteReview(review_id);
	    logger.debug("리뷰 삭제 완료 - 리뷰 ID: {}", review_id);

	    return "redirect:/review/reviewList";
	}
	
	// 리뷰 목록 조회
	@RequestMapping(value="/reviewList", method = RequestMethod.GET)
	public String reviewList(Model model) {
		List<ReviewVO> list = reviewService.reviewList();
		model.addAttribute("reviewList", list);
		
		logger.debug(" 리뷰 목록 조회 완료 - 컨트롤러 ");
		
		return "review/reviewList";
	}
	
	// 리뷰 상세 조회
	@RequestMapping(value="/reviewDetail", method = RequestMethod.GET)
	public String reviewDetail(@RequestParam("review_id") Integer review_id, Model model) {
	    if (review_id == null) {
	        return "404"; // review_id가 없으면 에러 페이지
	    }

	    ReviewVO review = reviewService.reviewDetail(review_id);
	    model.addAttribute("reviewDetail", review);

	    logger.debug("리뷰 상세 조회 완료 - 컨트롤러 ");

	    return "review/reviewDetail";
	}
	
	// 회원별 리뷰 조회
	@RequestMapping(value="/memberReviewList", method = RequestMethod.GET)
	public String selectReviewsByMember(@RequestParam("member_id") int member_id, Model model) {
	    List<ReviewVO> list = reviewService.selectReviewsByMember(member_id);
	    
	    model.addAttribute("memberReviewList", list);
	    model.addAttribute("member_id", member_id);
	    
	    logger.debug("회원별 리뷰 조회 완료 - 컨트롤러");
	    return "review/reviewsByMember";
	}
	
	// 기업별 리뷰 조회
	@RequestMapping(value="/corpReviewList", method = RequestMethod.GET)
	public String selectReviewsByCorp(@RequestParam("corp_id") int corp_id, Model model) {
	    List<ReviewVO> list = reviewService.selectReviewsByCorp(corp_id);
	    
	    model.addAttribute("corpReviewList", list);
	    model.addAttribute("corp_id", corp_id);
	    
	    logger.debug("기업별 리뷰 조회 완료 - 컨트롤러");
	    return "review/reviewsByCorp";
	}
	
}
