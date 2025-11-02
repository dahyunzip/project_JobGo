package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Data;

//	create table com_board (
//	    com_bno      int auto_increment primary key,
//	    member_id    int,
//	    com_title    varchar(100) not null,
//	    com_content  text not null,
//	    storedFileName varchar(255),       -- 업로드 파일 이름 (저장용)
//	    com_viewcnt  int default 0,
//	    com_regdate  timestamp not null default now(),
//	    foreign key(member_id) references member(id)
//	);

@Data
public class ComBoardVO {

	private int com_bno;
	private int member_id;
	private String com_title;
	private String com_content;
	private String storedFileName;
	private int com_viewcnt;
	private Timestamp com_regdate;
	
	
	private String writer;                  // 작성자
	private String userid;                  // 유저 아이디 정보
	private String email;                   // email
	private String addr;                    // 거주지
	

	
}
