package com.itwillbs.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
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

	@Override
	public void modifyMember(MemberVO vo) throws Exception {
		logger.debug("modifyMember(MemberVO vo) 시작");
		mdao.updateMember(vo);
		logger.debug("modifyMember(MemberVO vo) 종료");
	}
}
