package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NoticeVO;
import com.itwillbs.domain.RecBoardVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.persistence.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService{

	@Inject
	private AdminDAO adminDAO;

	@Override
    public List<RecBoardVO> getRecBoardList(Criteria cri) throws Exception {
        return adminDAO.getRecBoardList(cri);
    }

    @Override
    public int getRecTotalCount(String search) throws Exception {
        return adminDAO.getRecTotalCount(search);
    }

    @Override
    public int deleteRecBoard(int com_bno) throws Exception {
        return adminDAO.deleteRecBoard(com_bno);
    }
	
	@Override
	public List<MemberVO> getAllNormalMembers(Criteria cri) throws Exception {
		return adminDAO.getAllNormalMembers(cri);
	}
	
	@Override
	public int getNormalMemberTotalCount() throws Exception {
		return adminDAO.getNormalMemberTotalCount();
	}

	@Override
	public List<CorpMemberVO> getAllCorpMembers(Criteria cri) throws Exception {
		return adminDAO.getAllCorpMembers(cri);
	}
	
	@Override
	public CorpMemberVO getCorpMemberById(int corpId) throws Exception {
	    return adminDAO.getCorpMemberById(corpId);
	}
	
	@Override
	public int getCorpMemberTotalCount() throws Exception {
		return adminDAO.getCorpMemberTotalCount();
	}
	
	@Override
	public int approveCorp(int corpId) throws Exception {
	    return adminDAO.approveCorp(corpId);
	}

	@Override
	public int denyCorp(int corpId) throws Exception {
	    return adminDAO.denyCorp(corpId);
	}
	
	@Override
	public int deleteCorpMember(int corpId) throws Exception {
	    return adminDAO.deleteCorpMember(corpId);
	}

	@Override
	public int deleteMember(int id) throws Exception {
		return adminDAO.deleteMember(id);
	}

	@Override
	public List<ReviewVO> getAllReviews(Criteria cri) throws Exception {
		return adminDAO.getAllReviews(cri);
	}
	
	@Override
	public int getReviewTotalCount() throws Exception {
		return adminDAO.getReviewTotalCount();
	}

	@Override
	public int deleteReview(int reviewId) throws Exception {
		return adminDAO.deleteReview(reviewId);
	}
	
	@Override
	public List<NoticeVO> getNoticeListAll(Criteria cri) throws Exception {
		return adminDAO.getNoticeListAll(cri);
	}

	@Override
	public int getTotalCountAll(Criteria cri) throws Exception {
		return adminDAO.getTotalCountAll(cri);
	}

	@Override
	public NoticeVO getNotice(int noticeId) throws Exception {
		return adminDAO.getNotice(noticeId);
	}
	
	@Override
	public void insertNotice(Map<String, Object> map) throws Exception {
		adminDAO.insertNotice(map);
	}

	@Override
	public void updateNotice(NoticeVO vo) throws Exception {
		adminDAO.updateNotice(vo);
	}

	@Override
	public void deleteNotice(int noticeId) throws Exception {
		adminDAO.deleteNotice(noticeId);
	}
	
	// (S) 관리자 메인 대시보드
	@Override
    public int getTotalMembers() throws Exception { return adminDAO.getTotalMembers(); }

    @Override
    public int getGeneralMembers() throws Exception { return adminDAO.getGeneralMembers(); }

    @Override
    public int getCorpMembers() throws Exception { return adminDAO.getCorpMembers(); }

    @Override
    public int getTotalRecruits() throws Exception { return adminDAO.getTotalRecruits(); }

    @Override
    public int getWeeklyRecruits() throws Exception { return adminDAO.getWeeklyRecruits(); }

    @Override
    public int getTotalNoticeCount() throws Exception { return adminDAO.getTotalNoticeCount(); }

    @Override
    public String getLatestNoticeTitle() throws Exception { return adminDAO.getLatestNoticeTitle(); }

    @Override
    public int getTotalReviewCount() throws Exception { return adminDAO.getTotalReviewCount(); }

    @Override
    public int getTodayReviewCount() throws Exception { return adminDAO.getTodayReviewCount(); }
    // (E) 관리자 메인 대시보드
	
}
