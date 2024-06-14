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
	cursor: pointer;
}

table {
	table-layout: fixed;
}

td {
	text-align: center;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#qna_title {
	text-align: left !important;
}

#qna_title a {
	margin-left: 1em;
}

.nav {
	flex-wrap: nowrap;
}

.nav-tabs {
	margin-left: -1em !important;
}

.nav-tabs .nav-item {
	margin-right: 2px;
}

.nav-tabs .nav-link {
	padding: 0.5rem 0.4rem 0.3rem ! important;
	margin: 0;
	font-size: 0.6em;
	color: black;
	background: #f2f2f2 !important;
	border-radius: 50% 20% 0 0;
}

.nav-link.active {
	background-color: #1f1f1f !important;
}

.nav-link.active:before {
	border: none !important;
}

.nav-tabs .nav-link.active {
	color: white !important;
}

#search-group {
	width: 300px;
}
</style>
<script src="../js/jquery-3.7.1.min.js"></script>
<script src="../js/qna-index.js"></script>


</head>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>

	<!-- 문의사항 목록 -->
	<section class="pt-7 pb-12">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<!-- Heading -->
					<h3 class="mb-10 text-center">QNA</h3>
				</div>
			</div>

			<form id="searchForm" class="d-flex justify-content-between align-items-end">
				<!-- 			문의 종류 선택 -->
				<div id="type">
					<ul class="nav nav-tabs">
						<li class="nav-item" id="type_all" data-value="all">
							<a class="nav-link active" href="#;">전체 문의</a>
						</li>
						<li class="nav-item" id="type_game" data-value="0">
							<a class="nav-link" href="#;">경기 문의</a>
						</li>
						<li class="nav-item" id="type_common" data-value="1">
							<a class="nav-link" href="#;">일반 문의</a>
						</li>
						<li class="nav-item" id="type_order" data-value="2">
							<a class="nav-link" href="#;">결제 문의</a>
						</li>
						<li class="nav-item" id="type_ticket" data-value="3">
							<a class="nav-link" href="#;">티켓 문의</a>
						</li>
						<li class="nav-item" id="type_ticket" data-value="notice">
							<a class="nav-link" href="#;">공지사항</a>
						</li>
					</ul>
				</div>
				<div class="d-flex flex-wrap pb-3" id="search-group">
					<!-- 검색 타입 선택 -->
					<select id="search_type" name="search_type" class="form-select form-select-xs">
						<option value="all" <c:if test="${search.search_type == 'all'}">selected</c:if>>전체</option>
						<option value="title" <c:if test="${search.search_type == 'title'}">selected</c:if>>제목</option>
						<option value="content" <c:if test="${search.search_type == 'content'}">selected</c:if>>내용</option>
					</select>
					<!-- 검색 창 -->
					<div class="input-group input-group-merge flex-grow-1">
						<input id="search_words" class="form-control" type="search" placeholder="Search">
						<div class="input-group-append">
							<button class="btn btn-outline-border" type="button" id="searchBtn">
								<i class="fe fe-search"></i>
							</button>
						</div>
					</div>
				</div>
			</form>
			<div class="row justify-content-center">
				<table border="1">
					<caption style="display: none;">게시판 목록</caption>
					<colgroup>
						<col width="80px" />
						<col width="80px" />
						<col width="*" />
						<col width="100px" />
						<col width="100px" />
						<col width="80px" />
						<col width="100px" />
					</colgroup>
					<thead class="lh-lg bg-dark text-white">
						<tr>
							<th data-head="q.qna_no">번호</th>
							<th data-head="type">분류</th>
							<th data-head="title">제목</th>
							<th data-head="m.name">작성자</th>
							<th data-head="regdate">작성일자</th>
							<th data-head="readcnt">조회수</th>
							<th data-head="reply">답변 상태</th>
						</tr>
					</thead>
					<tbody id="qnaList">
						<!-- AJAX로 불러온 데이터가 이곳에 삽입됨 -->
					</tbody>
				</table>
			</div>


		</div>

		<!-- Pagination -->
		<nav class="pt-3 d-flex justify-content-center justify-content-md-center">
			<ul class="pagination pagination-sm text-gray-400" id="pagination">
				<!-- ajax로 값이 들어갈 부분 -->
			</ul>
		</nav>
		<c:if test="${!empty login}">
			<div class="d-flex justify-content-end m-2">
				<a class="btn btn-sm btn-dark" href="write.do">작성하기</a>
			</div>
		</c:if>
		<c:if test="${login.state == 3}">
			<div class="d-flex justify-content-end m-2">
				<a class="btn btn-sm btn-dark" href="write.do">공지사항 작성하기</a>
			</div>
		</c:if>
	</section>
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
