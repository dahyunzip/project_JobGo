package com.itwillbs.domain;

import java.security.Timestamp;

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
    private String pfImage;
    private Timestamp joinedAt;
    private Timestamp updateAt;
    private boolean isDeleted;
    private String membertype;       // 'G' : 일반회원, 'A' : 관리자
    private String agreeLocation;    // Y/N
    private String agreeEmail;       // Y/N
    private String agreeSms;         // Y/N
}
