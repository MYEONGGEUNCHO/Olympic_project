<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장 관리자 페이지</title>
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
	<h3>경기장 리스트</h3>
	<div>
		<table>
			<p><span><strong>총 ${map.count }개</strong>  |  ${stadiumVO.page }/${map.totalPage }페이지</span></p>
			<caption>경기장 목록</caption>
			<colgroup>
				<col width="40px">
				<col width="40px">
				<col width="40px">
				<col width="40px">
				<col width="40px">
				<col width="40px">
				<col width="40px">
				<col width="40px">
				<col width="40px">
				<col width="40px">
				<col width="40px">
			</colgroup>
			<thead>
				<tr>
					<th>stadium_no</th>
					<th>stadium_name</th>
					<th>stadium_img_url</th>
					<th>stadium_url</th>
					<th>stadium_en_name</th>
					<th>stadium_position</th>
					<th>a_seat_quantity</th>
					<th>b_seat_quantity</th>
					<th>c_seat_quantity</th>
					<th>d_seat_quantity</th>
					<th>vip_seat_quantity</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty map.list }">
					<tr>
						<td colspan="11">등록된 경기장이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="vo" items="${map.list }">
					<tr>
						<td>${vo.stadium_no }</td>
						<td>${vo.stadium_name }</td>
						<td>${vo.stadium_img_url }</td>
						<td>${vo.stadium_url }</td>
						<td>${vo.stadium_en_name }</td>
						<td>${vo.stadium_position }</td>
						<td>${vo.a_seat_quantity }</td>
						<td>${vo.b_seat_quantity }</td>
						<td>${vo.c_seat_quantity }</td>
						<td>${vo.d_seat_quantity }</td>
						<td>${vo.vip_seat_quantity }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div>
			<a href="/olympic/game/stadium/create.do">경기장 추가</a>
		</div>
		<div>
			<ul>
				<c:if test="${map.prev }">
					<li><a href="index.do?page=${map.startPage-1 }&searchType=${stadiumVO.searchType }&searchWord=${stadiumVO.searchWord }"> << </a></li>
				</c:if>
				<c:forEach var="p" begin="${map.startPage }" end="${map.endPage }">
					<c:if test="${p == stadiumVO.page }">
						<li><a href="#;">${p }</a></li>
					</c:if>
					<c:if test="${p != stadiumVO.page }">
						<li><a href="index.do?page=${p }&searchType=${stadiumVO.searchType }&searchWord=${stadiumVO.searchWord }">${p }</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${map.next }">
					<li><a href="index.do?page=${map.endPage+1 }&searchType=${stadiumVO.searchType }&searchWord=${stadiumVO.searchWord }"> >> </a></li>
				</c:if>
			</ul>
		</div>
	</div>	
</body>
</html>