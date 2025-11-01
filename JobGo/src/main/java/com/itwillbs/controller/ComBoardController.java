package com.itwillbs.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.itwillbs.service.MemberService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.ComBoardVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.ComBoardService;

@Controller
@RequestMapping("/comboard/*")
public class ComBoardController {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(ComBoardController.class);
	
	@Inject private ComBoardService comBoardService;
	@Inject private MemberService memberService;
	
	// 파일 업로드 경로
	private static final String UPLOAD_PATH = "c:\\spring\\upload";
	
	@GetMapping("/test")
	public void test() {
		logger.debug(" test() 실행! ");
	}
	
	// 게시판 글쓰기 - GET
	@GetMapping("/comRegist")
	public void comRegistGET(HttpSession session,
			                 Model model) throws Exception {
		logger.debug(" /comboard/comRegist -> comRegistGET() 실행! ");
		
		String memberLoginInfo = (String) session.getAttribute("userid");
		
		MemberVO memberInfo = memberService.getMember(memberLoginInfo);
		
		model.addAttribute("memberLoginInfo", memberInfo);
		
		logger.debug(" /views/comboard/comRegist.jsp 페이지 이동 ");
	}
	
	// 게시판 글쓰기 - POST
	@PostMapping("/comRegist")
	public String comRegistPOST(MultipartHttpServletRequest multiRequest,
			                    HttpSession session,
			                    RedirectAttributes rttr,
			                    Model model) throws Exception {
		logger.debug(" /comboard/comRegist -> comRegistPOST() 실행! ");
		
		// 한글처리 인코딩
		// => 파일업로드 처리는 필터 인코딩처리를 수행하지않는 대표적인 예외케이스
		// => 별도 한글처리 인코딩 필요함
		multiRequest.setCharacterEncoding("UTF-8");
		
		// 전달된 파라메터 정보 저장
		String memberLoginInfo = (String) session.getAttribute("userid");
		MemberVO memberInfo = memberService.getMember(memberLoginInfo);
		int member_id = memberInfo.getId();
		
		// 파라메터 정보를 저장
		Map<String, Object> paramMap = new HashMap<>();
		
		// getParametorNames: 전달된 파라메터의 이름들 모두를 가져옴(파일정보 제외)
		Enumeration<String> enu = multiRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = multiRequest.getParameter(name);
			
			paramMap.put(name, value);
		}
		// 로그인 회원 추가정보 수동으로 넣기
		paramMap.put("member_id", member_id);
		paramMap.put("member_name", memberInfo.getName());
		paramMap.put("member_email", memberInfo.getEmail());

		// 확인용 로그
		logger.debug(" 작성자 ID: " + member_id);
		logger.debug(" 작성자 이름: " + memberInfo.getName());
		logger.debug(" 작성자 이메일: " + memberInfo.getEmail());
		logger.debug(" 제목: " + paramMap.get("com_title"));
		logger.debug(" 내용: " + paramMap.get("com_content"));
		
		// 파일 업로드
		List<String> fileList = fileUploadProcess(multiRequest);
		String storedFileNames = String.join(",", fileList);

		// ComBoardVO 객체 생성
		ComBoardVO comboardVO = new ComBoardVO();
		comboardVO.setCom_title((String) paramMap.get("com_title"));
		comboardVO.setCom_content((String) paramMap.get("com_content"));
		comboardVO.setStoredFileName(storedFileNames); 
		comboardVO.setMember_id(member_id);
		comboardVO.setWriter(memberInfo.getName());
		comboardVO.setEmail(memberInfo.getEmail());
		
		// DB에 저장하는 기능
		comBoardService.comReistBoard(comboardVO);
		
		model.addAttribute("paramMap", paramMap);
		logger.debug(" paramMap: "+paramMap);
		logger.debug(" /comboard/comRegist -> comRegistPOST() 끝! ");
		return "redirect:/comboard/comListCri";
	}
	
	private List<String> fileUploadProcess(MultipartHttpServletRequest multiRequest) throws Exception {
		
		// 업로드할 파일의 이름을 저장
		List<String> fileList = new ArrayList<>();
		
		// 업로드된 파일 파라메터 정보를 저장
		Iterator<String> fileNames = multiRequest.getFileNames();
		while(fileNames.hasNext()) {
			String fileParamName = fileNames.next();
			logger.debug(" fileParamName: "+fileParamName);
		
			// 파일을 임시 저장
			MultipartFile mFile = multiRequest.getFile(fileParamName);
			if(mFile == null || mFile.isEmpty()) {
				continue;
			}
			
			// 업로드한 파일의 원본이름을 저장 
			String originFileName = mFile.getOriginalFilename();
			String uuid = UUID.randomUUID().toString();
			String storedFileName = uuid + "_" + originFileName;
			
			// 파일 리스트 저장
			fileList.add(storedFileName);
			
			// 해당이름의 빈파일 생성
			File file = new File(UPLOAD_PATH + "\\" + storedFileName);
			if(!file.exists()) {
				if(file.getParentFile().mkdirs()) {
					file.createNewFile();
				}
			}
			// 임시 파일을 실제 업로드 경로로 전달
			mFile.transferTo(file);
			logger.debug(" 파일 업로드 성공! ");
		}
		logger.debug(" fileList: "+fileList);
		
		// 업로드된 파일 정보(이름)을 리턴
		return fileList;
	}
	
	
	// http://localhost:8088/comboard/comListCri
	// 게시판 리스트(페이징)
	@GetMapping("/comListCri")
	public void comListCriGET(Criteria cri,
			                  Model model,
			                  HttpSession session) throws Exception {
		logger.debug(" /comboard/comListCri -> comListCri() 실행! ");
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(comBoardService.getTotalCount());
		
		List<ComBoardVO> cboardList
			= comBoardService.getComBoardListPage(cri);		
		// logger.debug("list:"+cboardList);
		logger.debug("list:"+cboardList.size());
		logger.debug("list:"+cboardList);
		
		model.addAttribute(pageVO);
		model.addAttribute("cboardList",cboardList);
		
		// 세션영역에 조회수증가 여부를 판단하는 상태값을 생성
		session.setAttribute("incrementStatus", true);
		
		logger.debug(" /comboard/comListCri -> comListCri() 끝! ");		
	}
	
	// 게시글 보기
	@GetMapping("/comRead")
	public String comReadGET(@RequestParam("com_bno") int com_bno,
			                 @ModelAttribute("page") int page,
			                 Model model,
			                 HttpSession session) throws Exception {
		logger.debug(" /comboard/comRead -> comReadGET 실행! ");
		
		// 회원 아이디 조회
		String memberLoginInfo = (String) session.getAttribute("userid");
		
		MemberVO memberInfo = memberService.getMember(memberLoginInfo);
		
		model.addAttribute("memberLoginInfo", memberInfo);
		logger.debug(" 로그인 회원 아이디: "+memberInfo.getId());
		logger.debug(" 로그인 회원 이름: "+memberInfo.getName());
		logger.debug(" 로그인 회원 메일 주소: "+memberInfo.getEmail());
		
		// 서비스 불러오기
		ComBoardVO resultReadVO = comBoardService.getComBoard(com_bno);
		logger.debug(" resultRead: "+resultReadVO);
		
		// 디비 정보 뷰페이지로 부르기
		model.addAttribute("resultReadVO",resultReadVO);
		
		return "/comboard/comRead";
	}
	

}
