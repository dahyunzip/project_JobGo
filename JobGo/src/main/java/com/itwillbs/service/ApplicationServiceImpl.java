package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.ApplicationVO;
import com.itwillbs.persistence.ApplicationDAO;

@Service
public class ApplicationServiceImpl implements ApplicationService {

	@Inject
	private ApplicationDAO dao;
	
	@Override
	public void apply(ApplicationVO vo) throws Exception {
		Long duplicate = dao.checkDuplicate(vo);
		if (duplicate == null || duplicate == 0) {
			dao.insertApplication(vo);
		} else {
			throw new IllegalStateException("이미 해당 공고에 지원한 이력서입니다.");
		}
	}

	@Override
	public List<ApplicationVO> getApplications(int member_id) throws Exception {
		return dao.getApplicationsByMemberId(member_id);
	}

	@Override
	public boolean withdraw(int application_id) throws Exception {
		return dao.withdrawApplication(application_id) > 0;
	}

}
