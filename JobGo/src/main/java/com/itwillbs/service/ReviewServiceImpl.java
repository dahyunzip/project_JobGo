package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.persistence.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Inject
	private ReviewDAO reviewDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewServiceImpl.class);

	@Override
	public void insertReview(ReviewVO review) throws Exception{
		reviewDAO.insertReview(review);
		logger.debug(" 리뷰 작성 완료 - 서비스");
		
	}
	
	@Override
	public List<Map<String, Object>> getTopCategoryList() throws Exception{
		logger.debug(" 직무 코드 대분류 - 서비스 ");
		return reviewDAO.getTopCategoryList();
	}
	
	@Override
	public List<Map<String, Object>> getBottomCategoryList(String topId) throws Exception{
		logger.debug(" 직무 코드 소분류 - 서비스 ");
	    return reviewDAO.getBottomCategoryList(topId);
	}
	
	@Override
	public void updateReview(ReviewVO review) throws Exception{
		reviewDAO.updateReview(review);
		logger.debug(" 리뷰 수정 완료 - 서비스");
		
	}

	@Override
	public void deleteReview(int reviewId) throws Exception{
		reviewDAO.deleteReview(reviewId);
		logger.debug(" 리뷰 삭제 완료 - 서비스");
		
	}

	@Override
	public List<ReviewVO> getListPaging(Criteria cri) throws Exception {
		List<ReviewVO> list = reviewDAO.getListPaging(cri);
		logger.debug("전체 리뷰 목록 조회 완료 - {} - 서비스", list.size());
		return list;
	}

	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		int total = reviewDAO.getTotalCount(cri);
		logger.debug("전체 리뷰 총 개수: ({}개) - 서비스", total);
		return total;
	}

	@Override
	public ReviewVO reviewDetail(int reviewId) throws Exception{
		ReviewVO review = reviewDAO.reviewDetail(reviewId);
		logger.debug(" 리뷰 상세 조회 완료 - 서비스");
		
		return review;
	}

	@Override
	public List<ReviewVO> getListByMemberPaging(int memberId, Criteria cri) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("cri", cri);
		List<ReviewVO> list = reviewDAO.getListByMemberPaging(param);
		logger.debug("회원별 리뷰 목록 조회 완료 - {} - 서비스", list.size());
		return list;
	}

	@Override
	public int getTotalByMember(int memberId) throws Exception {
		int total = reviewDAO.getTotalByMember(memberId);
		logger.debug("회원별 리뷰 총 개수: ({}개) - 서비스", total);
		return total;
	}

	@Override
	public List<ReviewVO> getListByCorpPaging(int corpId, Criteria cri) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("corpId", corpId);
		param.put("cri", cri);
		List<ReviewVO> list = reviewDAO.getListByCorpPaging(param);
		logger.debug("기업별 리뷰 조회 완료 - {} - 서비스", list.size());
		return list;
	}

	@Override
	public int getTotalByCorp(int corpId) throws Exception {
		int total = reviewDAO.getTotalByCorp(corpId);
		logger.debug("기업별 리뷰 총 개수: ({}개) - 서비스", total);
		return total;
	}

	@Override
	public String getMemberPasswordByReviewId(int reviewId) throws Exception{
		return reviewDAO.getMemberPasswordByReviewId(reviewId);
	}
	
	@Override
	public Integer getMemberIdByUserid(String userid) throws Exception{
		return reviewDAO.getMemberIdByUserid(userid);
	}
	
	@Override
	public String getCompanyNameByCorpId(int corpId) throws Exception {
		return reviewDAO.getCompanyNameByCorpId(corpId);
	}
	
}
