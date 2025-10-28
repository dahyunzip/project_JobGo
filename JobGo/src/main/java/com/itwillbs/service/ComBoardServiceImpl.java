package com.itwillbs.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.persistence.ComBoardDAO;

@Service
public class ComBoardServiceImpl implements ComBoardService {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(ComBoardServiceImpl.class);
	
	@Inject private ComBoardDAO cbdao;
	
	
	

}
