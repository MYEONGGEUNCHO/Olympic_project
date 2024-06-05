<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA 상세 페이지 테스트</title>
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
	$(function() {
		$("#modify").click(function() {
			$.ajax({
				type: "POST",
				url: "/olympic/qna/update.do",
				headers : {
					"Content-Type" : "application/json",
				},
				data : JSON.stringify({ 
					qna_no: "${qna.qna_no}",
					member_no: "${qna.member_no}",
					}),
				success: function() {
					alert('삭제가 완료되었습니다.');
					location.href = "/olympic/qna/index.do";
				},
				error : function(xhr, status, error) {
					console.error("Error:", status);
					// 에러 시 수행할 동작
		            alert('글 삭제 중 오류가 발생했습니다: ' + xhr.responseText);
				}
			});
		});
		$("#delete").click(function() {
// 			console.log("${qna}");
			$.ajax({
				type: "POST",
				url: "/olympic/qna/delete.do",
				headers : {
					"Content-Type" : "application/json",
				},
				data : JSON.stringify({ 
					qna_no: "${qna.qna_no}",
					member_no: "${qna.member_no}",
					}),
				success: function() {
					alert('삭제가 완료되었습니다.');
					location.href = "/olympic/qna/index.do";
				},
				error : function(xhr, status, error) {
					console.error("Error:", status);
					// 에러 시 수행할 동작
		            alert('글 삭제 중 오류가 발생했습니다: ' + xhr.responseText);
				}
			});
		});

	});
</script>

</head>

<body>
	<div>
		<h1>${qna.title }</h1>
		<p>조회수 : ${qna.readcnt }</p>
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
		<!-- 		TODO:: post요청 보내고 받아야함 -->
		<button type="button" id="modify">수정하기</button>
		<button type="button" id="delete">삭제하기</button>
	</div>
</body>
</html>
