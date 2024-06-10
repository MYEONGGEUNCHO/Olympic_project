<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>종목 관리자 페이지</title>
<style type="text/css">
	table {
        width: 100%;
        border-collapse: collapse;
    }
	th, td {
		text-align: center;
		border: 1px solid #ddd;
        padding: 8px;
        max-width: 150px; /* 셀의 최대 너비 설정 */
        overflow: hidden; /* 넘치는 부분 숨기기 */
        text-overflow: ellipsis; /* 넘치는 부분 생략 (...) 표시 */
        white-space: nowrap; /* 텍스트 줄바꿈 방지 */
	}
</style>
</head>
<body>
	<h3>종목 리스트</h3>
	<div>
		<table>
			<p><span><strong>총 ${map.count }개</strong>  |  ${sportVO.page }/${map.totalPage }페이지</span></p>
			<caption>종목 목록</caption>
			<colgroup>
				<col width="50px" height="30px">
				<col width="50px" height="30px">
				<col width="50px" height="30px">
				<col width="50px" height="30px">
				<col width="50px" height="30px">
				<col width="50px" height="30px">
				<col width="50px" height="30px">
			</colgroup>
			<thead>
				<tr>
					<th>sport_code</th>
					<th>sport_name</th>
					<th>title_image</th>
					<th>link</th>
					<th>sport_info</th>
					<th>sport_rule</th>
					<th>sport_history</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty map.list }">
					<tr>
						<td colspan="7">등록된 종목이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="vo" items="${map.list }">
					<tr>
						<td >${vo.sport_code }</td>
						<td >${vo.sport_name }</td>
						<td >${vo.title_image }</td>
						<td >${vo.link }</td>
						<td >${vo.sport_info }</td>
						<td >${vo.sport_rule }</td>
						<td >${vo.sport_history }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div>
			<a href="/olympic/game/sport/create.do">종목 추가</a>
		</div>
		<div>
			<ul>
				<c:if test="${map.prev }">
					<li><a href="index.do?page=${map.startPage-1 }&searchType=${stadiumVO.searchType }&searchWord=${stadiumVO.searchWord }"> << </a></li>
				</c:if>
				<c:forEach var="p" begin="${map.startPage }" end="${map.endPage }">
					<c:if test="${p == sportVO.page }">
						<li><a href="#;">${p }</a></li>
					</c:if>
					<c:if test="${p != sportVO.page }">
						<li><a href="index.do?page=${p }&searchType=${stadiumVO.searchType }&searchWord=${stadiumVO.searchWord }">${p }</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${map.next }">
					<li><a href="index.do?page=${map.endPage+1 }&searchType=${stadiumVO.searchType }&searchWord=${stadiumVO.searchWord }"> >> </li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>