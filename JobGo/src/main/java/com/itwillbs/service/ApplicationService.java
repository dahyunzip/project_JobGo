package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.ApplicationVO;
import com.itwillbs.domain.Criteria;

public interface ApplicationService {
	// 입사 지원
	public void apply(ApplicationVO vo) throws Exception;
	// 지원내역 개수 확인
	public int getTotalCount(int member_id) throws Exception;
	// 지원내역 리스트 확인
	public List<ApplicationVO> getApplications(int member_id, Criteria cri) throws Exception;
	// 지원 취소
	public boolean withdraw(int application_id) throws Exception;
}