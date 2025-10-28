package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Data;

//create table file (
//        file_id          INT          AUTO_INCREMENT PRIMARY KEY,
//        originalFileName VARCHAR(255) NOT NULL,
//        storedFileName   VARCHAR(255) NOT NULL,
//        contentType      VARCHAR(255) NOT NULL,
//        uploadDate       timestamp    DEFAULT CURRENT_TIMESTAMP
//);

@Data
public class FileVO {
	
	private int file_id;
	private String originalFileName;
	private String storedFileName;
	private String contentType;
	private Timestamp uploadDate;

}
