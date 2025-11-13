package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.persistence.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService{

	@Inject
	private AdminDAO adminDAO;

	@Override
	public List<MemberVO> getAllNormalMembers() throws Exception {
		return adminDAO.getAllNormalMembers();
	}

	@Override
	public List<MemberVO> getAllCorpMembers() throws Exception {
		return adminDAO.getAllCorpMembers();
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
	public int deleteMember(int id) throws Exception {
		return adminDAO.deleteMember(id);
	}

	@Override
	public List<ReviewVO> getAllReviews() throws Exception {
		return adminDAO.getAllReviews();
	}

	@Override
	public int deleteReview(int reviewId) throws Exception {
		return adminDAO.deleteReview(reviewId);
	}
	
	
	
}
