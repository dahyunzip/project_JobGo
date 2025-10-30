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

    // 리뷰 작성 폼
    @RequestMapping(value="/insertReview", method = RequestMethod.GET)
    public String insertReviewForm(HttpSession session) {
    	/*
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
		*/
    	
    	if (session.getAttribute("userid") == null) {
            session.setAttribute("userid", "user01"); // DB의 userid
            session.setAttribute("id", 1); // DB의 id값
            System.out.println("테스트용 세션 자동생성됨 : user01 / id=1");
        }
    	
		return "review/insertReview";
    }

    // 리뷰 작성 처리
    @RequestMapping(value="/insertReview", method = RequestMethod.POST)
    public String insertReview(ReviewVO review, HttpSession session) {
    	/*
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
		review.setMember_id(memberInfo.getId());
		reviewService.insertReview(review);
		logger.debug("리뷰 작성 완료 - 작성자 ID: {}", memberInfo.getId());
*/
    	if (session.getAttribute("userid") == null) {
            session.setAttribute("userid", "user01");
            session.setAttribute("id", 1);
        }
        review.setMemberId(1);

        reviewService.insertReview(review);
        logger.debug("리뷰 작성 완료 (테스트) - 작성자 ID: 1");
    	
		return "redirect:/review/reviewList";
    }

    // 리뷰 수정 폼
    @RequestMapping(value="/updateReview", method = RequestMethod.GET)
	    public String updateReviewForm(@RequestParam("reviewId") int reviewId, HttpSession session, Model model) {
	    	/*
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

		ReviewVO review = reviewService.reviewDetail(review_id);
		if (review == null || review.getMember_id() != memberInfo.getId()) {
			return "error/403";
		}
*/
    	if (session.getAttribute("userid") == null) {
            session.setAttribute("userid", "user01");
            session.setAttribute("id", 1);
        }

        ReviewVO review = reviewService.reviewDetail(reviewId);
    	
		model.addAttribute("review", review);
		return "review/updateReview";
    }

    // 리뷰 수정 처리
    @RequestMapping(value="/updateReview", method = RequestMethod.POST)
    public String updateReview(ReviewVO review, HttpSession session) {
    	/*
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

		ReviewVO original = reviewService.reviewDetail(review.getReview_id());
		if (original == null) {
			return "error/404";
		}
		if (original.getMember_id() != memberInfo.getId()) {
			return "error/403";
		}

		review.setMember_id(memberInfo.getId());
		*/
    	
    	if (session.getAttribute("userid") == null) {
            session.setAttribute("userid", "user01");
            session.setAttribute("id", 1);
        }
        review.setMemberId(1);
    	
		reviewService.updateReview(review);

		return "redirect:/review/reviewDetail?review_id=" + review.getReviewId();
    }

    // 리뷰 삭제
    @RequestMapping(value="/deleteReview", method = RequestMethod.POST)
    public String deleteReview(@RequestParam("reviewId") int reviewId, HttpSession session) {
    	/*
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

		ReviewVO review = reviewService.reviewDetail(review_id);
		if (review == null || review.getMember_id() != memberInfo.getId()) {
			return "error/403";
		}
*/
    	if (session.getAttribute("userid") == null) {
            session.setAttribute("userid", "user01");
            session.setAttribute("id", 1);
        }
    	
		reviewService.deleteReview(reviewId);
		logger.debug("리뷰 삭제 완료 - review_id: {}", reviewId);
		return "redirect:/review/reviewList";
    }

    // 리뷰 목록
    @RequestMapping(value="/reviewList", method = RequestMethod.GET)
    public String reviewList(@RequestParam("reviewId") int reviewId, Model model) {
    	ReviewVO review = reviewService.reviewDetail(reviewId);
        model.addAttribute("reviewDetail", review);
        return "review/reviewDetail";
    }

    // 리뷰 상세
    @RequestMapping(value="/reviewDetail", method = RequestMethod.GET)
    public String reviewDetail(@RequestParam("reviewId") int reviewId, Model model) {
        ReviewVO review = reviewService.reviewDetail(reviewId);
        model.addAttribute("reviewDetail", review);
        logger.debug("detail 동작");
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
