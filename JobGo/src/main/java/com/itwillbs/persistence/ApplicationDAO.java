package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.ApplicationVO;
import com.itwillbs.domain.Criteria;

public interface ApplicationDAO {
	// 입사지원
	public void insertApplication(ApplicationVO vo) throws Exception;
	
	// 지원내역 조회
	public List<ApplicationVO> getApplicationsByMemberId(int member_id, Criteria cri) throws Exception;
	
	// 모든 지원내역 확인
	public int selectTotalCount(int member_id) throws Exception;
	
	// 중복 지원 확인
	public int checkDuplicate(ApplicationVO vo) throws Exception;
	
	// 이미 지원했는지 확인 (조회 시점)
	public int checkAlreadyApplied(@Param("member_id") int member_id, 
	                               @Param("rec_bno") int rec_bno) throws Exception;
	
	// 지원 취소
	public int withdrawApplication(int application_id) throws Exception;
}