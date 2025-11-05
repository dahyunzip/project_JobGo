package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.NoticeVO;

public interface NoticeDAO {
	void insertNotice(NoticeVO vo);
	NoticeVO getNotice(int noticeId);
	List<NoticeVO> getNoticeList();
	void updateNotice(NoticeVO vo);
	void deleteNotice(int noticeId);
	void updateViewCnt(int noticeId);
}
