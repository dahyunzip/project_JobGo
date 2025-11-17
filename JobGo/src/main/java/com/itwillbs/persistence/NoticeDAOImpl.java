package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE = "com.itwillbs.mapper.NoticeMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewDAOImpl.class);
	
	@Override
	public void insertNotice(NoticeVO vo) throws Exception{
		logger.debug(" insertNotice - DAO ");
		
		sqlSession.insert(NAMESPACE+".insertNotice",vo);
		
	}
	
	@Override
	public void insert_notice_with_userid(Map<String, Object> noticeData) throws Exception {
		sqlSession.insert(NAMESPACE + ".insert_notice_with_userid", noticeData);
	}
	
	@Override
	public List<NoticeVO> getNoticeList(Criteria cri) {
		return sqlSession.selectList(NAMESPACE + ".getNoticeList", cri);
	}
	
	@Override
	public int getTotalCount(Criteria cri) {
		return sqlSession.selectOne(NAMESPACE + ".getTotalCount", cri);
	}

	@Override
	public NoticeVO getNotice(int noticeId) throws Exception{
		logger.debug(" getNotice - DAO ");
		return sqlSession.selectOne(NAMESPACE+ ".getNotice", noticeId);
	}

	@Override
	public void updateNotice(NoticeVO vo) throws Exception{
		logger.debug(" updateNotice - DAO ");
		sqlSession.update(NAMESPACE+".updateNotice", vo);
		
	}

	@Override
	public void deleteNotice(int noticeId) throws Exception{
		logger.debug(" deleteNotice - DAO ");
		sqlSession.delete(NAMESPACE+".deleteNotice", noticeId);
	}

	@Override
	public void updateViewCnt(int noticeId) throws Exception{
		logger.debug(" updateViewCnt - DAO ");
		sqlSession.update(NAMESPACE+".updateViewCnt", noticeId);
		
	}
	
	@Override
    public List<NoticeVO> getRecentNotices() {
        return sqlSession.selectList(NAMESPACE + ".getRecentNotices");
    }
	
}
