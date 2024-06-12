<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>올림픽 경기일정 관리자 페이지</title>
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
	<h3>올림픽 경기일정 리스트</h3>
	<div>
		<table>
			<p><span><strong>총 ${map.count }개</strong>  |  ${gameVO.page }/${map.totalPage }페이지</span></p>
			<caption>올림픽 경기일정 목록</caption>
			<colgroup>
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
				<col width="35px">
			</colgroup>
			<thead>
				<tr>
					<th>game_id</th>
					<th>sport_name</th>
					<th>country1_name</th>
					<th>country2_name</th>
					<th>tournament</th>
					<th>country</th>
					<th>country1_flag</th>
					<th>country2_flag</th>
					<th>stadium_name</th>
					<th>paris_date</th>
					<th>paris_time</th>
					<th>korea_date</th>
					<th>korea_time</th>
					<th>sport_code</th>
					<th>stadium_no</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty map.list }">
					<tr>
						<td colspan="15">등록된 종목이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="vo" items="${map.list }">
					<tr>
						<td>${vo.game_id }</td>
						<td>${vo.sport_name }</td>
						<td>${vo.country1_name }</td>
						<td>${vo.country2_name }</td>
						<td>${vo.tournament }</td>
						<td>${vo.country }</td>
						<td>${vo.country1_flag }</td>
						<td>${vo.country2_flag }</td>
						<td>${vo.stadium_name }</td>
						<td>${vo.paris_date }</td>
						<td>${vo.paris_time }</td>
						<td>${vo.korea_date }</td>
						<td>${vo.korea_time }</td>
						<td>${vo.sport_code }</td>
						<td>${vo.stadium_no }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 
		<c:if test="${login.state == 3 }">
			<div>
				<a href="/olympic/admin/game/create.do">올림픽 경기일정 추가</a>
			</div>
		</c:if>
		 -->
		<div>
			<a href="/olympic/admin/game/write.do">올림픽 경기일정 추가</a>
		</div>
		<div>
			<ul>
				<c:if test="${map.prev }">
					<li><a href="index.do?page=${map.startPage-1 }&searchType=${gameVO.searchType }&searchWord=${gameVO.searchWord }"> << </a></li>
				</c:if>
				<c:forEach var="p" begin="${map.startPage }" end="${map.endPage }">
					<c:if test="${p == gameVO.page }">
						<li><a href="#;">${p }</a></li>
					</c:if>
					<c:if test="${p != gameVO.page }">
						<li><a href="index.do?page=${p }&searchType=${gameVO.searchType }&searchWord=${gameVO.searchWord }">${p }</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${map.prev }">
					<li><a href="index.do?page=${map.endPage+1 }&searchType=${gameVO.searchType }&searchWord=${gameVO.searchWord }"> >> </li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>