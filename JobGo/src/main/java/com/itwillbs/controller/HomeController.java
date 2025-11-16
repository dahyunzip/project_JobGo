package com.itwillbs.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.service.ComBoardService;
import com.itwillbs.service.NoticeService;
import com.itwillbs.service.RecBoardService;
import com.itwillbs.service.ReviewService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
    private NoticeService noticeService;

    @Inject
    private ComBoardService communityService;

    @Inject
    private ReviewService reviewService;
    
    @Inject
    private RecBoardService recBoardService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main(Model model) throws Exception {
    	model.addAttribute("recMainList", recBoardService.getRecMainList());
    	model.addAttribute("recMainListVW", recBoardService.getRecMainListVIEW());
        model.addAttribute("noticeList", noticeService.getRecentNotices());
        model.addAttribute("communityList", communityService.getRecentCommunityPosts());
        model.addAttribute("reviewList", reviewService.getRecentReviews());

        return "home/main";
    }
	
}
