package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.NoticeVO;
import com.itwillbs.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Inject
	private NoticeDAO nDAO;
	
	@Override
	public void insertNotice(NoticeVO vo) {
		nDAO.insertNotice(vo);
		
	}

	@Override
	public NoticeVO getNotice(int noticeId) {
		return nDAO.getNotice(noticeId);
	}

	@Override
	public List<NoticeVO> getNoticeList() {
		return nDAO.getNoticeList();
	}
	
	@Override
	public void updateNotice(NoticeVO vo) {
		nDAO.updateNotice(vo);
		
	}

	@Override
	public void deleteNotice(int noticeId) {
		nDAO.deleteNotice(noticeId);
		
	}

	@Override
	public void updateViewCnt(int noticeId) {
		nDAO.updateViewCnt(noticeId);
		
	}
	
}
