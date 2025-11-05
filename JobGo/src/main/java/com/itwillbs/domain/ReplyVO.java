package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Data;

//	CREATE TABLE reply (
//	    reply_no      INT AUTO_INCREMENT PRIMARY KEY,               -- 댓글번호
//	    reply_content VARCHAR(1000) NOT NULL,                       -- 댓글내용
//	    ref_bno       INT NOT NULL,                                 -- 참조 게시글 번호 (com_board)
//	    reply_writer  INT NOT NULL,                                 -- 작성자 (member)
//	    create_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- 작성일
//	    status        CHAR(1) DEFAULT 'Y' CHECK (status IN ('Y','N')), -- 상태값(Y/N)
//	    
//	    FOREIGN KEY(ref_bno) REFERENCES com_board(com_bno) ON DELETE CASCADE,
//	    FOREIGN KEY(reply_writer) REFERENCES member(id) ON DELETE CASCADE
//	);

@Data
public class ReplyVO {
	
	private int reply_no;			// 댓글번호
	private String reply_content;   // 댓글내용
	private int ref_bno;            // 참조 게시글 번호
	private int reply_writer;       // 작성자
	private Timestamp create_date;  // 작성일
	private String status;          // 상태값
	                                
	// 화면 표시용                  
	private String writerName;      // 작성자 이름
	private String writerUserid;    // 작성자 ID
	
	

}
