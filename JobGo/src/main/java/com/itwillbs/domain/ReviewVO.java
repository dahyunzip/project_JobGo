package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReviewVO {
	private int reviewId;
	private int memberId;
	private int corpId;
	private String workMonths;
	private String revTitle;
	private String revContent;
	private int revRate;
	private String revPros;
	private String revCons;
	private String revPublic = "y";
	private LocalDateTime revRegdate;
	private LocalDateTime revUpdatedate;
	private int revViewcnt;
	
	private String jobCode;
	
	private String topCategoryName;
	private String topCategoryId;
	private String bottomCategoryName;
	private String bottomCategoryId;
	
}
