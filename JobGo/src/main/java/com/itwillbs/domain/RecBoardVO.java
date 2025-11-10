package com.itwillbs.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

//	CREATE TABLE rec_board (
//	    rec_bno           INT AUTO_INCREMENT PRIMARY KEY,
//	    corp_id           INT NOT NULL,
//	    rec_title         VARCHAR(100) NOT NULL,
//	    rec_maintask      TEXT,
//	    rec_preference    TEXT,
//	    rec_benefit       TEXT,
//	    topctg_id         INT NOT NULL,
//	    btmctg_id         INT NOT NULL,
//	    toplct_id         INT NOT NULL,
//	    rec_inputlct      VARCHAR(255),
//	    rec_qualification TEXT,
//	    rec_deadline      DATE NOT NULL,
//	    rec_viewcnt       INT DEFAULT 0,
//	    rec_regdate       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
//	    rec_updatedate    TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
//	    thumbFileName     varchar(255),
//	    attachFileName    varchar(255),
//	    FOREIGN KEY(corp_id) REFERENCES corpmember(corp_id),
//	    FOREIGN KEY(topctg_id) REFERENCES top_category(topctg_id) ON DELETE CASCADE,
//	    FOREIGN KEY(btmctg_id) REFERENCES bottom_category(btmctg_id) ON DELETE CASCADE,
//	    FOREIGN KEY(toplct_id) REFERENCES top_location(toplct_id) ON DELETE CASCADE
//	);

@Data
public class RecBoardVO {
	
	private int rec_bno;                   // 채용공고글 번호
	private int corp_id;                   // 작성자(기업회원 정보)
	private int topctg_id;                 // 직종 대분류
	private int btmctg_id;                 // 직종 소분류
	private int toplct_id;                 // 지역 대분류
	private int rec_viewcnt;
	
	private String rec_title;              // 채용 공고 제목 
 	private String rec_maintask;           // 주요 업무
	private String rec_preference;         // 채용 우대 사항
	private String rec_benefit;            // 복리 후생
	private String rec_inputlct;           // 상세 주소 입력
	private String rec_qualification;      // 입사 자격 요건
	private String thumbFileName;          // 썸네일 사진
	private String attachFileName;         // 첨부 파일/사진 
	
	private Date rec_deadline;             // 채용 마감일
	
	private Timestamp rec_regdate;         // 글 작성일
	private Timestamp rec_updatedate;      // 글 수정일
	

}
