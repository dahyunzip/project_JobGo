package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Inject
	private MemberDAO mdao;

	@Override
	public void memberJoin(MemberVO vo) {
		mdao.insertMember(vo);
	}
	
	
}
