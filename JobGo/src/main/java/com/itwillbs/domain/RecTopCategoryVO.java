package com.itwillbs.domain;

import lombok.Data;

//	CREATE TABLE top_category (
//	    topctg_id INT AUTO_INCREMENT PRIMARY KEY,
//	    topctg_name VARCHAR(100) NOT NULL
//	);

@Data
public class RecTopCategoryVO {
	
	private int topctg_id;
	private String topctg_name;

}
