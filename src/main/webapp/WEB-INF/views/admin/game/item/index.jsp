<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 관리자 페이지</title>
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
<script>
	// 페이지 로드 시 실행될 JavaScript
	window.onload = function() {
	    console.log("페이지가 로드되었습니다.");
	    
	    // 서버에서 받은 데이터 예시
	    var itemVO = ${map.list}; // 서버에서 받은 데이터를 JavaScript 객체로 할당
	    console.log("서버에서 받은 데이터:", itemVO);
	}
</script>
</head>
<body>
	<h3>상품 리스트</h3>
	<div>
		<table>
			<p><span><strong>총 ${map.count }개</strong>  |  ${itemVO.page }/${map.totalPage }페이지</span></p>
			<caption>상품 목록</caption>
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
				<col width="40px">
				<col width="40px">
				<col width="40px">
			</colgroup>
			<thead>
				<tr>
					<th>item_no</th>
					<th>a_seat_sold</th>
					<th>b_seat_sold</th>
					<th>c_seat_sold</th>
					<th>d_seat_sold</th>
					<th>vip_seat_sold</th>
					<th>state</th>
					<th>korean_advancement</th>
					<th>a_seat_price</th>
					<th>b_seat_price</th>
					<th>c_seat_price</th>
					<th>d_seat_price</th>
					<th>vip_seat_price</th>
					<th>game_id</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty map.list }">
					<tr>
						<td colspan="14">등록된 종목이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="vo" items="${map.list }">
					<tr>
						<td>${vo.item_no }</td>
						<td>${vo.a_seat_sold }</td>
						<td>${vo.b_seat_sold }</td>
						<td>${vo.c_seat_sold }</td>
						<td>${vo.d_seat_sold }</td>
						<td>${vo.vip_seat_sold }</td>
						<td>${vo.state }</td>
						<td>${vo.korean_advancement }</td>
						<td>${vo.a_seat_price }</td>
						<td>${vo.b_seat_price }</td>
						<td>${vo.c_seat_price }</td>
						<td>${vo.d_seat_price }</td>
						<td>${vo.vip_seat_price }</td>
						<td>${vo.game_id }</td>
					</tr>			
				</c:forEach>
			</tbody>
		</table>
		<div>
			<a href="/olympic/admin/game/item/write.do">상품 추가</a>
		</div>
		<div>
			<ul>
				<c:if test="${map.prev }">
					<li><a href="index.do?page=${map.startPage-1 }&searchType=${itemVO.searchType }&searchWord=${itemVO.searchWord }"> << </a></li>
				</c:if>
				<c:forEach var="p" begin="${map.startPage }" end="${map.endPage }">
					<c:if test="${p == itemVO.page }">
						<li><a href="#;">${p }</a></li>
					</c:if>
					<c:if test="${p != itemVO.page }">
						<li><a href="index.do?page=${p }&searchType=${itemVO.searchType }&searchWord=${itemVO.searchWord }">${p }</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${map.next }">
					<li><a href="index.do?page=${map.endPage+1 }&searchType=${itemVO.searchType }&searchWord=${itemVO.searchWord }"> >> </li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>