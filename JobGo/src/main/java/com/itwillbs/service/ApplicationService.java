package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.ApplicationVO;

public interface ApplicationService {
	
	public void apply(ApplicationVO vo) throws Exception;
	
	public List<ApplicationVO> getApplications(int member_id) throws Exception;
	
	
	public boolean withdraw(int application_id) throws Exception;
}
