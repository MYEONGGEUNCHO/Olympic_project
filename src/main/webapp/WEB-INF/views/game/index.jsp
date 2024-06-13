<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>올림픽 경기 일정</title>
</head>
<body>
	<div>
		<input type="date"
			name="search_type"
			id="search_date"
			min="2024-07-26"
			max="2024-08-11"			
			value="2024-07-26">
		<select name="search_type" id="search_sport">
			<option value="all" selected>전체종목</option>
			<option value="3x3 농구">3x3 농구</option>
			<option value=""></option>
		</select>
		<c:if test="${empty map.list }">
			<tr>
				<td colspan="15">등록된 종목이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${map.list }">
			<div>
				
			</div>
		</c:forEach>
		
	</div>
</body>
</html>