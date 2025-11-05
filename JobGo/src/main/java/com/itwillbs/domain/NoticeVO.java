package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeVO {
	private int noticeId;
	private int adminId;
	private String noticeTitle;
	private String noticeContent;
	private String storedFileName;
	private int noticeViewCnt;
	private Timestamp noticeRegdate;
	private Timestamp noticeUpdated;
}
