package com.itwillbs.domain;

import lombok.Data;

//	CREATE TABLE rec_file (
//	    file_id INT AUTO_INCREMENT PRIMARY KEY,
//	    rec_bno INT NOT NULL,
//	    file_type VARCHAR(20) NOT NULL,     -- 'THUMB' or 'ATTACH'
//	    originalFileName VARCHAR(255),
//	    storedFileName VARCHAR(255),
//	    FOREIGN KEY (rec_bno) REFERENCES rec_board(rec_bno) ON DELETE CASCADE
//	); 

@Data
public class RecFileVO {
	
	private int file_id;
	private int rec_bno;
	private String file_type;
	private String originalFileName;
	private String storedFileName;

}
