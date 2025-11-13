package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		sqlSession.insert(NAMESPACE + "insertApplication", vo);
	}

	@Override
	public List<ApplicationVO> getApplicationsByMemberId(int member_id) throws Exception {
		return sqlSession.selectList(NAMESPACE + "getApplicationsByMemberId", member_id);
	}

	@Override
	public int checkDuplicate(ApplicationVO vo) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "checkDuplicate", vo);
	}
	
	@Override
	public int checkAlreadyApplied(int member_id, int rec_bno) throws Exception {
	    Map<String, Object> params = new HashMap<>();
	    params.put("member_id", member_id);
	    params.put("rec_bno", rec_bno);
	    return sqlSession.selectOne(NAMESPACE + "checkAlreadyApplied", params);
	}

	@Override
	public int withdrawApplication(int application_id) throws Exception {
		return sqlSession.update(NAMESPACE + "withdrawApplication", application_id);
	}

}
