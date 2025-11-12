package com.itwillbs.domain;

import lombok.Data;

//	CREATE TABLE bottom_category (
//	    btmctg_id INT AUTO_INCREMENT PRIMARY KEY,
//	    topctg_id INT NOT NULL,
//	    btmctg_name VARCHAR(100) NOT NULL,
//	    FOREIGN KEY(topctg_id) REFERENCES top_category(topctg_id) ON DELETE CASCADE
//	);

@Data
public class RecBottomCategoryVO {
	
	private int btmctg_id;
	private int topctg_id;
	private String btmctg_name;

}
