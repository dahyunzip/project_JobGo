package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE = "com.itwillbs.mapper.NoticeMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewDAOImpl.class);
	
	@Override
	public void insertNotice(NoticeVO vo) {
		logger.debug(" insertNotice - DAO ");
		
		sqlSession.insert(NAMESPACE+".insertNotice",vo);
		
	}

	@Override
	public NoticeVO getNotice(int noticeId) {
		logger.debug(" getNotice - DAO ");
		return sqlSession.selectOne(NAMESPACE+ ".getNotice", noticeId);
	}

	@Override
	public List<NoticeVO> getNoticeList() {
		logger.debug(" getNoticeList - DAO ");
		return sqlSession.selectList(NAMESPACE+ ".getNoticeList");
	}

	@Override
	public void updateNotice(NoticeVO vo) {
		logger.debug(" updateNotice - DAO ");
		sqlSession.update(NAMESPACE+".updateNotice", vo);
		
	}

	@Override
	public void deleteNotice(int noticeId) {
		logger.debug(" deleteNotice - DAO ");
		sqlSession.delete(NAMESPACE+".deleteNotice", noticeId);
	}

	@Override
	public void updateViewCnt(int noticeId) {
		logger.debug(" updateViewCnt - DAO ");
		sqlSession.update(NAMESPACE+".updateViewCnt", noticeId);
		
	}
	
}
