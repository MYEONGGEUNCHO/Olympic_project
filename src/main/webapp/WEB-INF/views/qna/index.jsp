<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	문의사항 목록 -->
	<section class="pt-7 pb-12">
		<div class="container">
			<div class="row">
				<div class="col-12">

					<!-- Heading -->
					<h3 class="mb-10 text-center">QNA</h3>

				</div>
			</div>
			<div class="row justify-content-center">
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
		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
