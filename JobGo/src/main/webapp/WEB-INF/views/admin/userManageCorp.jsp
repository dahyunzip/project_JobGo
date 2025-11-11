<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div>
		<h2> 기업회원 관리</h2>
		<table>
			<thead>
				<tr> 기업 ID </tr>
				<tr> 회사명 </tr>	
				<tr> 담당자 </tr>
				<tr> 이메일 </tr>
				<tr> 가입일 </tr>
				<tr> 상태 </tr>
			</thead>
			<tbody>
				<c:forEach>
					<tr>
						<td></td>
						<td></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	
	</div>

</body>
</html>