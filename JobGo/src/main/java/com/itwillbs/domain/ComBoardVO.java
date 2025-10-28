package com.itwillbs.domain;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//	create table com_board (
//	    com_bno      int           auto_increment primary key,   -- 게시글 번호 
//	    member_id    int,                                        -- 작성자(회원 id)
//	    com_title    varchar(100)  not null,                     -- 게시글 제목
//	    com_content  text          not null,                     -- 게시글 내용
//	    com_viewcnt  int           default 0,                    -- 게시글 조회수
//	    com_regdate  timestamp     not null default now(),       -- 게시글 작성일
//
//	    -- ▼ 파일(저장명만)
//	    storedFileName varchar(255),
//
//	    foreign key(member_id) references member(id)
//	);

@Data
public class ComBoardVO {

	private int com_bno;					// 게시글 번호 
	private int member_id;                  // fk 
	private String com_title;               // 게시글 제목
	private String com_content;				// 게시글 내용
	private int com_viewcnt;				// 게시글 조회수
	private Timestamp com_regdate;          // 게시글 작성일
	private String storedFileName;          // 게시글 업로드 파일명
	
	private String writer;                    // 작성자
	

	
}
