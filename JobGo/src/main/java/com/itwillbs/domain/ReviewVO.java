package com.itwillbs.domain;

import java.util.Date;

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
	private Date revRegdate;
	private Date revUpdatedate;
	private int revViewcnt;
	
	private String jobCode;
	
	private String topCategoryName;
	private String topCategoryId;
	private String bottomCategoryName;
	private String bottomCategoryId;
	
	private String originalFileName;
	private String storedFileName;
}
