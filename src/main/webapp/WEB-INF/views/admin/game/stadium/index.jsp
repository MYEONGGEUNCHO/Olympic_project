<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장메인</title>
<style type="text/css">
	th {
		text-align: center !important;
	}
	
	td {
		text-align: center;
	}
</style>
</head>
<body>
	<h3>경기장 리스트</h3>
	<div>
		<table>
			<p><span><strong>총 ${map.count }개</strong>  |  ${stadiumVO.page }/${map.totalPage }페이지</span></p>
		</table>
	</div>	
</body>
</html>