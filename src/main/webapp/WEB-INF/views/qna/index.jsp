<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA 조회 테스트 페이지</title>
</head>
<body>
	<div>
		<h1>현재 QNA 리스트</h1>
		<table border="1">
			<thead>
				<tr>
					<th>qna_no</th>
					<th>regdate</th>
					<th>type</th>
					<th>title</th>
					<th>content</th>
					<th>readcnt</th>
					<th>reply</th>
					<th>member_no</th>
					<th>attached</th>
					<th>game_id</th>
				</tr>
			</thead>
			<c:forEach var="item" items="${qna}">
				<tr>
					<td>${item.qna_no}</td>
					<td>${item.regdate}</td>
					<td>${item.type}</td>
					<td>
						<a href="/qna/detail.do?qna_no=${item.qna_no }">${item.title}</a>
					</td>
					<td>${item.content}</td>
					<td>${item.readcnt}</td>
					<td>${item.reply}</td>
					<td>${item.member_no}</td>
					<td>${item.attached}</td>
					<td>${item.game_id}</td>
				</tr>
			</c:forEach>

		</table>
	</div>
</body>
</html>
