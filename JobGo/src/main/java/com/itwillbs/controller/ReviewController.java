package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.ReviewVO;
import com.itwillbs.service.ReviewService;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	@Inject
	private ReviewService reviewService;
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	// 리뷰 작성
	@RequestMapping(value="/insertReview", method = RequestMethod.POST)
	public String insertReview(ReviewVO review) {
		reviewService.insertReview(review);
		
		logger.debug(" 리뷰 작성 완료 - 컨트롤러 ");
		
		return "redirect:/review/reviewList";
	}
	
	// 리뷰 수정
	@RequestMapping(value="/updateReview", method = RequestMethod.POST)
	public String updateReview(ReviewVO review) {
		reviewService.updateReview(review);
		
		logger.debug(" 리뷰 수정 완료 - 컨트롤러 ");
		
		return "redirect:/reviewDetail?review_id="+review.getReview_id();
	}
	
	// 리뷰 삭제
	@RequestMapping(value="/deleteReview", method = RequestMethod.POST)
	public String deleteReview(int review_id) {
		reviewService.deleteReview(review_id);
		
		logger.debug(" 리뷰 삭제 완료 - 컨트롤러 ");
		
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
	public String reviewDetail(int review_id, Model model) {
		ReviewVO review = reviewService.reviewDetail(review_id);
		model.addAttribute("reviewDetail", review);
		
		logger.debug("리뷰 상세 조회 완료 - 컨트롤러 ");
		
		return "review/reviewDetail";
	}
	
	// 회원별 리뷰 조회
	@RequestMapping(value="/memberReviewList", method = RequestMethod.GET)
	public String selectReviewsByMember(int member_id, Model model) {
		List<ReviewVO> list = reviewService.selectReviewsByMember(member_id);
		model.addAttribute("memberReviewList", list);
		logger.debug(" 회원별 리뷰 조회 완료 - 컨트롤러 ");
		return "review/memberReviewList";
	}
	
	// 기업별 리뷰 조회
	@RequestMapping(value="/corpReviewList", method = RequestMethod.GET)
	public String selectReviewsByCorp(int corp_id, Model model) {
		List<ReviewVO> list = reviewService.selectReviewsByCorp(corp_id);
		model.addAttribute("corpReviewList", list);
		logger.debug(" 기업별 리뷰 조회 완료 - 컨트롤러 ");
		return "review/corpReviewList";
	}
	
}
