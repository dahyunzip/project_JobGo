package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.NoticeVO;

public interface NoticeService {
	void insertNotice(NoticeVO vo) throws Exception;
	void insert_notice_with_userid(Map<String, Object> noticeData) throws Exception;
	NoticeVO getNotice(int noticeId) throws Exception;
	void updateNotice(NoticeVO vo) throws Exception;
	void deleteNotice(int noticeId) throws Exception;
	void updateViewCnt(int noticeId) throws Exception;
	List<NoticeVO> getNoticeListPaging(Map<String, Object> map) throws Exception;
	int getNoticeCount(Map<String, Object> map) throws Exception;
}
