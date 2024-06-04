<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA 상세 페이지 테스트</title>
<script>

</script>

</head>

<body>
	<div>
		<h1>${qna.title }</h1>
		<p>조회수 : ${qna.readcnt } </p>
		<table border="1">
			<thead>
				<tr>
					<th>qna_no</th>
					<th>regdate</th>
					<th>type</th>
					<th>content</th>
					<th>reply</th>
					<th>member_no</th>
					<th>attached</th>
					<th>game_id</th>
				</tr>
			</thead>
				<tr>
					<td>${qna.qna_no}</td>
					<td>${qna.regdate}</td>
					<td>${qna.type}</td>
					<td>${qna.content}</td>
					<td>${qna.reply}</td>
					<td>${qna.member_no}</td>
					<td>${qna.attached}</td>
					<td>${qna.game_id}</td>
				</tr>

		</table>
		
		<a href="/qna/update.do">
		수정하기
		</a>
		<a href="/qna/delete.do">
		삭제하기
		</a>
		
	</div>
</body>
</html>
