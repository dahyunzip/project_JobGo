package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ApplicationVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.persistence.ApplicationDAO;

@Service
public class ApplicationServiceImpl implements ApplicationService {

	
	private static final Logger logger = LoggerFactory.getLogger(ApplicationServiceImpl.class);
	
	@Inject
	private ApplicationDAO dao;
	
	@Override
	public void apply(ApplicationVO vo) throws Exception {
		int duplicate = dao.checkDuplicate(vo);
		if (duplicate == 0) {
			dao.insertApplication(vo);
		} else {
			throw new IllegalStateException("이미 해당 공고에 지원한 이력서입니다.");
		}
		//dao.insertApplication(vo);
	}
	
	@Override
	public int getTotalCount(int member_id) throws Exception {
	    return dao.selectTotalCount(member_id);
	}

	@Override
	public List<ApplicationVO> getApplications(int member_id, Criteria cri) throws Exception {
		return dao.getApplicationsByMemberId(member_id, cri);
	}

	@Override
	public boolean withdraw(int application_id) throws Exception {
		logger.debug("지원 취소 시작");
		return dao.withdrawApplication(application_id) > 0;
	}

}
