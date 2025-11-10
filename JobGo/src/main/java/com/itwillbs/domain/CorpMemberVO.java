package com.itwillbs.domain;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CorpMemberVO {
	private int corpId;                       // PK
    private String corpUserId;                // 기업회원 아이디
    private String corpUserPw;                // 기업회원 비밀번호
    private String managerName;               // 담당자명
    private String managerEmail;              // 담당자 이메일
    private String managerTel;                // 담당자 전화번호
    private String companyName;               // 회사명
    private String businessRno;               // 사업자등록번호
    private String businessLicenseUrl;        // 사업자등록증 첨부 URL
    private String ceoName;                   // 대표자명
    private String companyAddress;            // 회사 주소
    private String industryType;              // 업종
    private String businessType;              // 업태
    private Timestamp corpJoined;             // 가입일
    private Timestamp corpUpdated;            // 수정일
    private String status;                    // 상태 (A:활성, W:대기, D:삭제)
    private boolean corpCheckDeleted;         // 삭제 여부 (0,1)
    private String corpAgreeLocation;         // 위치정보동의 (Y/N)
    private String corpAgreeEmail;            // 이메일 수신동의 (Y/N)
    private String corpAgreeSms;              // 문자 수신동의 (Y/N)
    private String originalFileName;
    private String storedFileName;
    private MultipartFile upload;
}
