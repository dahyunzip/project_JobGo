package com.itwillbs.domain;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private int id;
    private String userid;
    private String userpw;
    private String email;
    private String name;
    private String phone;
    private String addr;
    private Timestamp joinedAt;
    private Timestamp updateAt;
    private boolean isDeleted;
    private String membertype;       // 'G' : 일반회원, 'A' : 관리자
    private char agreeLocation;    // Y/N
    private char agreeEmail;       // Y/N
    private char agreeSms;         // Y/N
    private String originalFileName;
    private String storedFileName;
    private MultipartFile upload;
}
