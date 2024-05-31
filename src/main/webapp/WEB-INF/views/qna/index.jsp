<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> QNA 조회 테스트 페이지</title>
</head>
<body>
	<c:forEach var="list" items="${qna }">
		<p>${list.qna_no }</p>
		<p>${list.regdate}</p>
		<p>${list.type }</p>
		<p>${list.title }</p>
		<p>${list.content }</p>
		<p>${list.readcnt }</p>
		<p>${list.reply }</p>
		<p>${list.member_no }</p>
		<p>${list.attached}</p>
		<p>${list.game_id }</p>
	</c:forEach>

</body>
</html>