package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.NoticeVO;
import com.itwillbs.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Inject
	private NoticeDAO nDAO;
	
	@Override
	public void insertNotice(NoticeVO vo) throws Exception{
		nDAO.insertNotice(vo);
		
	}
	
	@Override
	public void insert_notice_with_userid(Map<String, Object> noticeData) throws Exception {
		nDAO.insert_notice_with_userid(noticeData);
	}
	
	@Override
	public List<NoticeVO> getNoticeList(Criteria cri) throws Exception {
		return nDAO.getNoticeList(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		return nDAO.getTotalCount(cri);
	}
	
	@Override
	public List<NoticeVO> getNoticeListAll(Criteria cri) throws Exception {
		return nDAO.getNoticeListAll(cri);
	}

	@Override
	public int getTotalCountAll(Criteria cri) throws Exception {
		return nDAO.getTotalCountAll(cri);
	}

	@Override
	public NoticeVO getNotice(int noticeId) throws Exception{
		return nDAO.getNotice(noticeId);
	}
	
	@Override
	public void updateNotice(NoticeVO vo) throws Exception{
		nDAO.updateNotice(vo);
		
	}

	@Override
	public void deleteNotice(int noticeId) throws Exception{
		nDAO.deleteNotice(noticeId);
		
	}

	@Override
	public void updateViewCnt(int noticeId) throws Exception{
		nDAO.updateViewCnt(noticeId);
		
	}
	
	@Override
    public List<NoticeVO> getRecentNotices() {
        return nDAO.getRecentNotices();
    }
	
}
