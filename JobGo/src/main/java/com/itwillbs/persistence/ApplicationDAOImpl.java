package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ApplicationVO;

@Repository
public class ApplicationDAOImpl implements ApplicationDAO {

	@Inject
    private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.ApplicationMapper.";
	
	private static final Logger logger = LoggerFactory.getLogger(ApplicationDAOImpl.class);
	
	@Override
	public void insertApplication(ApplicationVO vo) throws Exception {
		logger.debug("insertApplication() 실행 - member_id: " + vo.getMember_id());
		sqlSession.insert(NAMESPACE + "insertApplication", vo);
	}

	@Override
	public List<ApplicationVO> getApplicationsByMemberId(int member_id) throws Exception {
		return sqlSession.selectList(NAMESPACE + "getApplicationsByMemberId", member_id);
	}

	@Override
	public Long checkDuplicate(ApplicationVO vo) throws Exception {
		Long result = sqlSession.selectOne(NAMESPACE + "checkDuplicate", vo);
		return (result != null) ? result : 0L;
	}

	@Override
	public int withdrawApplication(int application_id) throws Exception {
		return sqlSession.update(NAMESPACE + "withdrawApplication", application_id);
	}

}
