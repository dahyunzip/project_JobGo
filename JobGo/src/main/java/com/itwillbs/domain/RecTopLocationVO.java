package com.itwillbs.domain;

import lombok.Data;

//	CREATE TABLE top_location (
//	    toplct_id INT AUTO_INCREMENT PRIMARY KEY,
//	    toplct_name VARCHAR(100) NOT NULL
//	);

@Data
public class RecTopLocationVO {
	
	private int toplct_id;
	private String toplct_name;

}
