package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.CorpMemberVO;
import com.itwillbs.persistence.CorpMemberDAO;

@Service
public class CorpMemberServiceImpl implements CorpMemberService {
	
	@Inject
	private CorpMemberDAO cdao;
	
	@Override
	public void registerCorpMember(CorpMemberVO vo) throws Exception {
		cdao.insertCorpMember(vo);

	}

	@Override
	public CorpMemberVO login(String corpUserId, String corpUserPw) throws Exception {
		return cdao.loginCorpMember(corpUserId, corpUserPw);
	}

	@Override
	public CorpMemberVO getCorpMember(String corpUserId) throws Exception {
		return cdao.getCorpMemberByUserid(corpUserId);
	}

}
