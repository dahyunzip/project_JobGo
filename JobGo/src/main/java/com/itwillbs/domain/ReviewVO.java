package com.itwillbs.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReviewVO {
	private int review_id;
	private int member_id;
	private int corp_id;
	private String job_code;
	private String work_months;
	private String rev_title;
	private String rev_content;
	private int rev_rate;
	private String rev_pros;
	private String rev_cons;
	private String rev_public = "y";
	private LocalDateTime rev_regdate;
	private LocalDateTime rev_updatedate;
	
	public int getRev_rate() {
		return rev_rate;
	}
	public void setRev_rate(int rev_rate) {
		this.rev_rate = rev_rate;
	}
	
}
