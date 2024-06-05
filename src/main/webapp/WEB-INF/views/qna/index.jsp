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
</head>
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
					<thead>
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
						<tr>
							<td>${item.qna_no}</td>
							<td>${item.type}</td>
							<td id="qna_title">
								<a href="${pageContext.request.contextPath}/qna/detail.do?qna_no=${item.qna_no }">${item.title}</a>
							</td>
							<!-- 							member_no를 통해 조회 필요 -->
							<td>${item.name}</td>
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
							<%-- 							<td class="text-truncate">${item.content}</td> --%>
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
		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
