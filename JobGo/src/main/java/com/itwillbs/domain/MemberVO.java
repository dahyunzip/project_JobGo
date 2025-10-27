package com.itwillbs.domain;

import java.security.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	private char membertype;
	private int id;
	private String userid;
	private String userpw;
	private String email;
	private String name;
	private String phone;
	private String addr;
	private String pfimage;
	private Timestamp joined_at;
	private Timestamp updated_at;
	private boolean is_deleted;
	private char agree_location;
	private char agree_email;
	private char agree_sms;
}
