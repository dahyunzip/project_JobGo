package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ApplicationVO {
    private Integer application_id;
    private Integer member_id;
    private Integer resume_id;
    private Integer rec_bno;
    private Timestamp applied_at;
    private String status;
    private String is_withdrawn;
    private String corp_memo;
    private Timestamp update_at;

    // JOIN용 추가필드
    private String rec_title;   // 채용공고 제목
    private String corp_name;   // 기업명
    private String resume_title; // 이력서 제목
}
