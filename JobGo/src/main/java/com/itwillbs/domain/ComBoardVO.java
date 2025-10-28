package com.itwillbs.domain;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//	create table com_board (
//	    com_bno      int           auto_increment primary key,   -- 게시글 번호 
//	    member_id    int,                                        -- 작성자(회원 이름)
//	    com_title    varchar(100)  not null,                     -- 게시글 제목
//	    com_content  text          not null,                     -- 게시글 내용
//	    file_id      int,                                        -- 업로드 파일
//	    com_viewcnt  int           default 0,                    -- 게시글 조회수
//	    com_regdate  timestamp     not null default now(),       -- 게시글 작성일
//	    
//	    foreign key(member_id) references member(id),
//	    foreign key(file_id) references file(file_id) on delete cascade
//	);

@Data
public class ComBoardVO {

	private int member_id;                  // fk 
	private int file_id;                    // fk

	private int com_bno;					// 게시글 번호 
	private String title;                   // 게시글 제목
	private String com_content;				// 게시글 내용
	private int com_viewcnt;				// 게시글 조회수
	private Timestamp com_regdate;          // 게시글 작성일
	
	private String username;                // 작성자
	
	private String storedFileName;          // 저장된 파일 정보
	private List<MultipartFile> com_upload; // 저장된 파일 수정
	

	
}
