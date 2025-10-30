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

    // 리뷰 작성 폼
    @RequestMapping(value="/insertReview", method = RequestMethod.GET)
    public String insertReviewForm(HttpSession session) {
    	Object loginId = session.getAttribute("id");
    	if (loginId == null) {
    	    return "redirect:/member/login";
    	}
        return "review/insertReview";
    }

    // 리뷰 작성 처리
    @RequestMapping(value="/insertReview", method = RequestMethod.POST)
    public String insertReview(ReviewVO review, HttpSession session) {
    	Object loginId = session.getAttribute("id");
    	if (loginId == null) {
    	    return "redirect:/member/login";
    	}

    	try {
    		review.setMember_id(Integer.parseInt(loginId.toString()));
    	} catch (NumberFormatException e) {
    		logger.debug("세션 ID 변환 실패");
    		return "redirect:/member/login";
    	}

    	reviewService.insertReview(review);
    	logger.debug("리뷰 작성 완료 - 작성자 ID: {}", loginId);
    	return "redirect:/review/reviewList";
    }

    // 리뷰 수정 폼
    @RequestMapping(value="/updateReview", method = RequestMethod.GET)
    public String updateReviewForm(@RequestParam("review_id") int review_id, HttpSession session, Model model) {
    	Object loginId = session.getAttribute("id");
    	if (loginId == null) {
    	    return "redirect:/member/login";
    	}

    	ReviewVO review = reviewService.reviewDetail(review_id);
    	if (review == null || !loginId.toString().equals(String.valueOf(review.getMember_id()))) {
    	    return "error/403";
    	}

    	model.addAttribute("review", review);
    	return "review/updateReview";
    }

    // 리뷰 수정 처리
    @RequestMapping(value="/updateReview", method = RequestMethod.POST)
    public String updateReview(ReviewVO review, HttpSession session) {
    	Object loginId = session.getAttribute("id");
    	if (loginId == null) {
    	    return "redirect:/member/login";
    	}

    	ReviewVO original = reviewService.reviewDetail(review.getReview_id());
    	if (original == null) {
    	    return "error/404";
    	}

    	if (!loginId.toString().equals(String.valueOf(original.getMember_id()))) {
    	    return "error/403";
    	}

    	try {
    		review.setMember_id(Integer.parseInt(loginId.toString()));
    	} catch (NumberFormatException e) {
    		return "redirect:/member/login";
    	}

    	reviewService.updateReview(review);
    	return "redirect:/review/reviewDetail?review_id=" + review.getReview_id();
    }

    // 리뷰 삭제
    @RequestMapping(value="/deleteReview", method = RequestMethod.POST)
    public String deleteReview(@RequestParam("review_id") int review_id, HttpSession session) {
    	Object loginId = session.getAttribute("id");
    	if (loginId == null) {
    	    return "redirect:/member/login";
    	}

    	ReviewVO review = reviewService.reviewDetail(review_id);
    	if (review == null || !loginId.toString().equals(String.valueOf(review.getMember_id()))) {
    	    return "error/403";
    	}

    	reviewService.deleteReview(review_id);
    	logger.debug("리뷰 삭제 완료 - review_id: {}", review_id);
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
    public String reviewDetail(@RequestParam("review_id") int review_id, Model model) {
        ReviewVO review = reviewService.reviewDetail(review_id);
        model.addAttribute("reviewDetail", review);
        return "review/reviewDetail";
    }

    // 회원별 리뷰
    @RequestMapping(value="/memberReviewList", method = RequestMethod.GET)
    public String selectReviewsByMember(@RequestParam("member_id") int member_id, Model model) {
        List<ReviewVO> list = reviewService.selectReviewsByMember(member_id);
        model.addAttribute("memberReviewList", list);
        model.addAttribute("member_id", member_id);
        return "review/reviewsByMember";
    }

    // 기업별 리뷰
    @RequestMapping(value="/corpReviewList", method = RequestMethod.GET)
    public String selectReviewsByCorp(@RequestParam("corp_id") int corp_id, Model model) {
        List<ReviewVO> list = reviewService.selectReviewsByCorp(corp_id);
        model.addAttribute("corpReviewList", list);
        model.addAttribute("corp_id", corp_id);
        return "review/reviewsByCorp";
    }
}
