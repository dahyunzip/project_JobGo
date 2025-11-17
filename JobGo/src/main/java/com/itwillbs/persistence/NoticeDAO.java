package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.NoticeVO;

public interface NoticeDAO {
		// 일반 insert
		void insertNotice(NoticeVO vo) throws Exception;

		// userid로 member.id를 조인해서 insert
		void insert_notice_with_userid(Map<String, Object> noticeData) throws Exception;

		// 공지 목록
		List<NoticeVO> getNoticeList(Criteria cri);
		int getTotalCount(Criteria cri);
		
		// 공지 상세 조회
		NoticeVO getNotice(int noticeId) throws Exception;

		// 공지 수정
		void updateNotice(NoticeVO vo) throws Exception;

		// 공지 삭제
		void deleteNotice(int noticeId) throws Exception;

		// 조회수 증가
		void updateViewCnt(int noticeId) throws Exception;
		
		public List<NoticeVO> getRecentNotices();
}
