package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
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
	public List<MemberVO> getAllCorpMembers(Criteria cri) throws Exception {
		return adminDAO.getAllCorpMembers(cri);
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
	
	
	
}
