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
	public void registerMember(MemberVO vo) throws Exception {
		mdao.insertMember(vo);
	}

	@Override
	public MemberVO login(String userid, String userpw) throws Exception {
		return mdao.loginCheck(userid, userpw);
	}
	
	@Override
    public MemberVO getMember(String userid) throws Exception {
        return mdao.getMemberByUserid(userid);
    }
	
}
