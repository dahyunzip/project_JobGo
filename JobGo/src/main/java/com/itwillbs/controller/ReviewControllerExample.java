package com.itwillbs.controller;

import java.util.List;
import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.service.ReviewService;

@Controller
@RequestMapping("/review/*")
public class ReviewControllerExample {

    @Inject
    private ReviewService reviewService;
    private static final Logger logger = LoggerFactory.getLogger(ReviewControllerExample.class);

    // 리뷰 작성 폼
    @RequestMapping(value="/insertReview", method = RequestMethod.GET)
    public String insertReviewForm() {
        logger.debug("리뷰 작성 폼 이동");
        return "review/insertReview";
    }

    // 리뷰 작성 처리
    @RequestMapping(value="/insertReview", method = RequestMethod.POST)
    public String insertReview(ReviewVO review) {
        reviewService.insertReview(review);
        System.out.println("⭐ 별점 값: " + review.getRev_rate());
        logger.debug("리뷰 작성 완료 (테스트용)");
        return "redirect:/review/reviewList";
    }

    // 리뷰 수정 폼
    @RequestMapping(value="/updateReview", method = RequestMethod.GET)
    public String updateReviewForm(@RequestParam("review_id") int review_id, Model model) {
        ReviewVO review = reviewService.reviewDetail(review_id);
        model.addAttribute("review", review);
        logger.debug("리뷰 수정 폼 이동 (테스트용)");
        return "review/updateReview";
    }

    // 리뷰 수정 처리
    @RequestMapping(value="/updateReview", method = RequestMethod.POST)
    public String updateReview(ReviewVO review) {
        reviewService.updateReview(review);
        logger.debug("리뷰 수정 완료 (테스트용)");
        return "redirect:/review/reviewDetail?review_id=" + review.getReview_id();
    }

    // 리뷰 삭제
    @RequestMapping(value="/deleteReview", method = RequestMethod.POST)
    public String deleteReview(@RequestParam("review_id") int review_id) {
        reviewService.deleteReview(review_id);
        logger.debug("리뷰 삭제 완료 (테스트용)");
        return "redirect:/review/reviewList";
    }

    // 리뷰 목록
    @RequestMapping(value="/reviewList", method = RequestMethod.GET)
    public String reviewList(Model model) {
        List<ReviewVO> list = reviewService.reviewList();
        model.addAttribute("reviewList", list);
        logger.debug("리뷰 목록 조회 완료 (테스트용)");
        return "review/reviewList";
    }

    // 리뷰 상세
    @RequestMapping(value="/reviewDetail", method = RequestMethod.GET)
    public String reviewDetail(@RequestParam("review_id") int review_id, Model model) {
        ReviewVO review = reviewService.reviewDetail(review_id);
        model.addAttribute("reviewDetail", review);
        logger.debug("리뷰 상세 조회 완료 (테스트용)");
        return "review/reviewDetail";
    }

    // 회원별 리뷰
    @RequestMapping(value="/memberReviewList", method = RequestMethod.GET)
    public String selectReviewsByMember(@RequestParam("member_id") int member_id, Model model) {
        List<ReviewVO> list = reviewService.selectReviewsByMember(member_id);
        model.addAttribute("memberReviewList", list);
        model.addAttribute("member_id", member_id);
        logger.debug("회원별 리뷰 조회 완료 (테스트용)");
        return "review/reviewsByMember";
    }

    // 기업별 리뷰
    @RequestMapping(value="/corpReviewList", method = RequestMethod.GET)
    public String selectReviewsByCorp(@RequestParam("corp_id") int corp_id, Model model) {
        List<ReviewVO> list = reviewService.selectReviewsByCorp(corp_id);
        model.addAttribute("corpReviewList", list);
        model.addAttribute("corp_id", corp_id);
        logger.debug("기업별 리뷰 조회 완료 (테스트용)");
        return "review/reviewsByCorp";
    }
}
