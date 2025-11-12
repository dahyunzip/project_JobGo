package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.ApplicationVO;

public interface ApplicationDAO {
	// 입사지원
	public void insertApplication(ApplicationVO vo) throws Exception;
	
	// 지원내역 조회
	public List<ApplicationVO> getApplicationsByMemberId(int member_id) throws Exception;
	
	// 중복 지원 확인
	public Long checkDuplicate(ApplicationVO vo) throws Exception;
	
	// 지원 취소
	public int withdrawApplication(int application_id) throws Exception;
}
