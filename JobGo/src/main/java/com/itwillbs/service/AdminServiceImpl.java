package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
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
	public int deleteMember(int id) throws Exception {
		return adminDAO.deleteMember(id);
	}
	
}
