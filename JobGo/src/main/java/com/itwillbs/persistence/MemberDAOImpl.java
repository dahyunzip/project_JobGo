package com.itwillbs.persistence;


import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.MemberMapper.";
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Override
	public void insertMember(MemberVO vo) {
		sqlSession.insert(NAMESPACE+"insertMember", vo);
	}
	
	@Override
	public MemberVO loginCheck(String userid, String userpw) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userid", userid);
		param.put("userpw", userpw);
		return sqlSession.selectOne(NAMESPACE+"loginMember", param);
	}

	@Override
    public MemberVO getMemberByUserid(String userid) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "getMemberByUserid", userid);
    }

	@Override
	public void updateMember(MemberVO vo) throws Exception {
		sqlSession.update(NAMESPACE + "updateMember", vo);
	}

	// 회원 프로필 사진 수정
	// 특정 회원의 파일 업로드 여부 조회
	@Override
	public MemberVO getMemberByFiles(int id) {
		return null;
	}

	// 디비에서 기존 파일 삭제
	@Override
	public void deleteOldPtFiles(int id) {
		logger.debug(" deleteOldPtFiles() 실행 ! ");
		sqlSession.delete(NAMESPACE+"deleteOldPtFiles", id);
		logger.debug("deleteOldPtFiles() 끝 ! ");
		
	}

	// 사진 업로드
	@Override
	public int insertPhotoFiles(MemberVO vo) {
		logger.debug(" insertPhotoFiles() 실행 ! ");
		int resultPtFiles = sqlSession.insert(NAMESPACE+"insertPhotoFiles", vo);
		logger.debug(" insertPhotoFiles() 끝");
		return resultPtFiles;
	}

	@Override
	public int selectMaxPhotoFiles() {
		return 0;
	}

	// 회원 정보 업데이트
	@Override
	public int updateMemberPhotoFiles(MemberVO vo) {
		logger.debug(" updateMemberPhotoFiles() 실행! ");
		int resultMemberPtFiles = sqlSession.update(NAMESPACE+"updateMemberPhotoFilex", vo);
		logger.debug(" updateMemberPhotoFiles() 끝! ");
		return resultMemberPtFiles;
	}
	
	
	
}
