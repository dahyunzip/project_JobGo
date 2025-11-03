package com.itwillbs.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.itwillbs.service.ComBoardServiceImpl;
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
import org.springframework.web.bind.annotation.ResponseBody;
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
			                  HttpSession session,
			                  @RequestParam(value="search", required=false) String search) throws Exception {
						   // @RequestParam(value="search", required=false) String search)
		                   // => @RequestParam("search") 이렇게 작성하면 항상 true 상태이기에 
		                   //    오류가 발생 required=false 추가
		logger.debug(" /comboard/comListCri -> comListCri() 실행! ");
		logger.debug(" 검색어: "+search);
		
		// 회원정보 가져오기
		String loginInfo = (String) session.getAttribute("userid");
		
		// Criteria 객체에서 search 필드 불러오기
		cri.setSearch(search);
		
		// 전체 글 개수(검색어 포함)
	    int totalCount = comBoardService.getTotalCount(search);
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(totalCount);
		
		// 리스트 조회(검색 포함)
		List<ComBoardVO> cboardList
			= comBoardService.getComBoardListPage(cri);		
		// logger.debug("list:"+cboardList);
		logger.debug("list:"+cboardList.size());
		logger.debug("list:"+cboardList);
		
		model.addAttribute(pageVO);
		model.addAttribute("cboardList",cboardList);
		
		// 검색정보 뷰페이지 전달
		model.addAttribute("search", search);
		
		// 회원정보 뷰페이지에 전달
		model.addAttribute("loginInfo",loginInfo);
		
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
		
		String loginUserId = (String) session.getAttribute("userid");
	    model.addAttribute("loginUserId", loginUserId);
		
		// 회원 아이디 조회
		ComBoardVO resultReadVO = comBoardService.getComBoard(com_bno);
		logger.debug(" resultRead: "+resultReadVO);
		
		// 디비 정보 뷰페이지로 부르기
		model.addAttribute("resultReadVO",resultReadVO);
		logger.debug(" 로그인 회원 아이디: "+resultReadVO.getUserid());
		logger.debug(" 로그인 회원 이름: "+resultReadVO.getWriter());
		logger.debug(" 로그인 회원 메일 주소: "+resultReadVO.getEmail());
		
		return "/comboard/comRead";
	}
	
	// 파일 다운로드 처리
	@GetMapping("/download")
	public void fileDownloadGET(@RequestParam("fileName") String fileName,
			                    HttpServletResponse response) throws Exception {
		logger.debug(" /download -> fileDownloadGET() 실행! ");
		
		// 다운로드할 파일의 이름을 가져오기
		logger.debug(" fileName: "+fileName);
		
		// 업로드해둔 폴더에 접근, 해당파일을 찾아서 열기
		File downFile = new File(UPLOAD_PATH +"\\"+fileName);
		
		// 파일 다운로드 처리시 필요한 옵션
		response.setHeader("Cache-Control", "no-cache");
		// 파일의 이름정보를 인코딩(한글파일 처리)
		String encodedFileName = URLEncoder.encode(fileName,"UTF-8");
		
		// 모든 파일이 다운로드창 형태로 동작
		response.addHeader("Content-disposition", "attachment; fileName="+encodedFileName);
		
		// 파일의 내용을 다른 파일로 복사
		FileInputStream fis = new FileInputStream(downFile);
		
		// 파일 출력
		OutputStream out = response.getOutputStream();
		
		// 출력 버퍼 생성
		byte[] buffer = new byte[1024 * 64]; // 64KB
		while(true) {
			int data = fis.read(buffer);
			if(data == -1) break;
			
			// 정보 출력
			out.write(buffer,0,data);
		}
		out.flush(); // 빈공간에 공백을 채워서 전달
		
		logger.debug(" 파일 다운로드 끝! ");
		fis.close();
		out.close();
	}
	
	// (모달)비밀번호 확인 - Ajax
	@PostMapping("/checkPassword")
	@ResponseBody
	public String comCheckPasswordAJAX(@RequestParam("password") String password,
                                       HttpSession session) throws Exception {
		logger.debug(" /comboard/checkPassword -> comCheckPasswordPOST() 실행! ");
		
		// 회원 정보 가져오기
		String loginUserId = (String) session.getAttribute("userid");
	    if (loginUserId == null) {
	        return "NOT_LOGIN";
	    }
	    
	    MemberVO memberInfo = memberService.getMember(loginUserId);
	    if(memberInfo == null ) {
	    	return "FAIL";
	    }
	    
	    // 회원 정보를 이용하여 개인정보 비교
	    if(memberInfo.getUserpw().equals(password)) {
	    	return "OK";
	    } else {
	    	logger.debug(" /comboard/checkPassword -> comCheckPasswordPOST() 끝! ");
	    	return "FAIL";
	    }
	    
	}
	
	// 게시글 삭제 - POST
	@PostMapping("/comDelete")
	public String comDeletePOST(@RequestParam("com_bno") int com_bno,
			                    HttpSession session,
			                    RedirectAttributes rttr) throws Exception {
		logger.debug(" /comboard/comDelete -> comDeletePOST() 실행! ");
		
		String loginUserId = (String) session.getAttribute("userid");
		if (loginUserId == null) {
	        rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
	        return "redirect:/member/login";
	    }

	    ComBoardVO board = comBoardService.getComBoard(com_bno);
	    if (board == null) {
	        rttr.addFlashAttribute("msg", "존재하지 않는 게시글입니다.");
	        return "redirect:/comboard/comListCri";
	    }
	    
	    // 첨부 파일 삭제
	    String storedFiles = board.getStoredFileName();
	    if (storedFiles != null && !storedFiles.isEmpty()) {
	        String[] fileNames = storedFiles.split(",");
	        for (String fileName : fileNames) {
	            File file = new File(UPLOAD_PATH + "\\" + fileName.trim());
	            if (file.exists()) {
	                if (file.delete()) {
	                    logger.debug("파일 삭제 성공: " + file.getName());
	                } else {
	                    logger.debug("파일 삭제 실패: " + file.getName());
	                }
	            }
	        }
	    }

	    // 게시글 삭제(DB)
	    comBoardService.deleteComBoard(com_bno);
	    rttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");

	    logger.debug(" /comboard/comDelete -> comDeletePOST() 끝!");
	    return "redirect:/comboard/comListCri";
	}
	
	// 게시글 수정 - GET
	@GetMapping("/comUpdate")
	public void comUpdateBoardGET(HttpSession session,
			                      Model model) throws Exception {
		logger.debug(" /comboard/comUpdate -> comUpdateBoardGET() 실행! ");
		String memberLoginInfo = (String) session.getAttribute("userid");
		MemberVO memberInfo = memberService.getMember(memberLoginInfo);
		model.addAttribute("memberLoginInfo", memberInfo);
	}
	
	// 게시글 수정 - POST
	@PostMapping("/comUpdate")
	public String comUpdate(MultipartHttpServletRequest multiRequest,
			                HttpSession session,
			                RedirectAttributes rttr) throws Exception {
		logger.debug(" /comboard/comUpdate -> comUpdatePOST() 실행! ");
		
		// 로그인 확인
		String loginUserId = (String) session.getAttribute("userid");
		if(loginUserId == null) {
			rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
			return "redirect:/member/login";
		}
		
		// 로그인한 회원 정보 가져오기
		MemberVO memberInfo = memberService.getMember(loginUserId);
		if(memberInfo == null) {
			rttr.addFlashAttribute("msg", "회원 정보를 불러올 수 없습니다.");
			return "redirect:/comboard/comListCri";
		}
		
		// 한글 인코딩 처리
		multiRequest.setCharacterEncoding("UTF-8");
		
		// 파라미터 받기
		int com_bno = Integer.parseInt(multiRequest.getParameter("com_bno"));
	    String com_title = multiRequest.getParameter("com_title");
	    String com_content = multiRequest.getParameter("com_content");
	    logger.debug(" 수정 요청 게시글 번호: " + com_bno);
	    logger.debug(" 수정 제목: " + com_title);
	    logger.debug(" 수정 내용: " + com_content);
	    
	    // 기존 게시글 정보 조회
	    ComBoardVO originalBoard = comBoardService.getComBoard(com_bno);
	    if(originalBoard == null) {
	    	rttr.addFlashAttribute("msg", "존재하지 않는 게시글입니다.");
	    	return "redirect:/comboard/comListCri";
	    }
	    
	    // 파일 업로드 처리
	    List<String> fileList = fileUploadProcess(multiRequest);
	    String storedFileNames = String.join(",", fileList);
	    
	    // 새파일 미업로드시 기존 파일 유지
	    if(storedFileNames.isEmpty()) {
	    	storedFileNames = originalBoard.getStoredFileName();
	    } else {
	    	// 기존 파일 삭제 처리
	    	String oldFiles = originalBoard.getStoredFileName();
	    	if(oldFiles != null && !oldFiles.isEmpty()) {
	    		String[] fileNames = oldFiles.split(",");
	    		for(String fileName : fileNames) {
	    			File file = new File(UPLOAD_PATH + "\\" + fileName.trim());
	    			if(file.exists()) {
	    				file.delete();
	    				logger.debug(" 기존 파일 삭제: "+ file.getName());
	    			}
	    		}
	    	}
	    }
		
	    // 수정된 정보 VO에 담기
	    ComBoardVO updatedVO = new ComBoardVO();
	    updatedVO.setCom_bno(com_bno);
	    updatedVO.setCom_title(com_title);
	    updatedVO.setCom_content(com_content);
	    updatedVO.setStoredFileName(storedFileNames);
	    updatedVO.setWriter(memberInfo.getName());
	    updatedVO.setEmail(memberInfo.getEmail());
	    updatedVO.setMember_id(memberInfo.getId());
	    
	    // DB 수정 처리
	    comBoardService.updateComBoard(updatedVO);
	    logger.debug(" 게시글 수정 완료: " + updatedVO);
		
	    // 완료 메시지 
	    rttr.addFlashAttribute("msg", "게시글이 수정되었습니다.");
		return "redirect:/comboard/comListCri";
	}
	
	

}
