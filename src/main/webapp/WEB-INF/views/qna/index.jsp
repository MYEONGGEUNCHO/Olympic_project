<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="ko">
<head>
<style>
th {
	text-align: center !important;
}

td {
	text-align: center;
}

#qna_title {
	text-algin: left !important;
}
</style>
<script>
	$(function() {
		$.ajax({

		})
	})
</script>


</head>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<form method="get" class="d-flex">
		<!-- 검색 타입 선택 -->
		<select name="type" class="form-select form-select-xs">
			<option value="all" <c:if test="${search.type == 'all'}">selected</c:if>>전체 문의</option>
			<option value="0" <c:if test="${search.type == '0'}">selected</c:if>>게임 문의</option>
			<option value="1" <c:if test="${search.type == '1'}">selected</c:if>>일반 문의</option>
			<option value="2" <c:if test="${search.type == '2'}">selected</c:if>>티켓 문의</option>
			<option value="3" <c:if test="${search.type == '3'}">selected</c:if>>결제 문의</option>
		</select>

		<!-- 	검색 창 -->
		<div class="input-group input-group-merge">
			<input class="form-control" type="search" placeholder="Search">
			<div class="input-group-append">
				<button class="btn btn-outline-border" type="submit" value="검색">
					<i class="fe fe-search"></i>
				</button>
			</div>
		</div>
	</form>

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
					<caption style="display: none;">게시판 목록</caption>
					<colgroup>
						<col width="80px" />
						<col width="80px" />
						<col width="*" />
						<col width="100px" />
						<col width="200px" />
						<col width="100px" />
						<col width="100px" />
					</colgroup>
					<thead class="lh-lg bg-dark text-white">
						<tr>
							<th>번호</th>
							<th>분류</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일자</th>
							<th>조회수</th>
							<th>답변 상태</th>
						</tr>
					</thead>
					<c:forEach var="item" items="${qna}">
						<tr class="lh-lg bg-light border border-top border-secondary">
							<td>${item.qna_no}</td>
							<td>
								<c:if test="${item.type == 0}"> 
							경기 문의
							</c:if>
								<c:if test="${item.type == 1}"> 
							일반 문의
							</c:if>
								<c:if test="${item.type == 2}"> 
							결제 문의
							</c:if>
								<c:if test="${item.type == 3}"> 
							티켓 문의
							</c:if>
							</td>
							<td class="text-break" id="qna_title">
								<a href="${pageContext.request.contextPath}/qna/detail.do?qna_no=${item.qna_no }">${item.title}</a>
							</td>
							<!-- member_no를 통해 조회 -->
							<td class="text-break">${item.name}</td>
							<td class="small">
								<%-- 서버 시간과 아이템의 등록 날짜를 비교 --%>
								<c:set var="itemDateStr" value="${fn:substring(item.regdate, 0, 10)}" />
								<c:choose>
									<c:when test="${itemDateStr == serverTime}">
										<fmt:formatDate value="${item.regdate}" pattern="HH:mm" />
									</c:when>
									<c:otherwise>
										<fmt:formatDate value="${item.regdate}" pattern="MM.dd(EE) HH:mm" />
									</c:otherwise>
								</c:choose>

							</td>
							<td>${item.readcnt}</td>
							<c:if test="${empty item.reply }">
								<td>대기중</td>
							</c:if>
							<c:if test="${!empty item.reply }">
								<td>답변 완료</td>
							</c:if>
						</tr>
					</c:forEach>

				</table>
			</div>
			<div class="d-flex justify-content-end m-2">
				<a class="btn btn-sm btn-dark" href="write.do">작성하기</a>
			</div>
			<!-- Pagination -->
			<nav class="pt-3 d-flex justify-content-center justify-content-md-center">
				<ul class="pagination pagination-sm text-gray-400">
					<c:if test="${search.pages.isPrev}">
						<li class="page-item">
							<a class="page-link page-link-arrow" href="?page=${search.pages.startPage - 1}">
								<i class="fa fa-caret-left"></i>
							</a>
						</li>
					</c:if>

					<c:forEach var="i" begin="${search.pages.startPage}" end="${search.pages.endPage}">
						<li class="page-item <c:if test='${i == search.page}'>active</c:if>">
							<a class="page-link" href="?page=${i}">${i}</a>
						</li>
					</c:forEach>

					<c:if test="${search.pages.isNext}">
						<li class="page-item">
							<a class="page-link page-link-arrow" href="?page=${search.pages.endPage + 1}">
								<i class="fa fa-caret-right"></i>
							</a>
						</li>
					</c:if>
				</ul>
			</nav>


		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
