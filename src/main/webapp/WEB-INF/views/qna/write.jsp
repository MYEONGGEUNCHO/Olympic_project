<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="../js/jquery-3.7.1.min.js"></script>

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<!-- Editor's Style -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="../js/qna-write.js"></script>

</head>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<!-- CONTENT -->
	<section class="pt-7 pb-12">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<!-- Heading -->
					<h3 class="mb-10 text-center">문의사항 작성</h3>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-12 col-md-8">
					<!-- 수정 안되는 부분-->
					<p id="date">작성일자 : ${serverTime}</p>
					<p id="writer">작성자 : ${login.name}</p>
					<!-- 분류 -->
					<div class="form-group">
					<input type="hidden" name="writer" value="${login.member_no}">
						<c:if test="${!empty param.game_id}">
							<input type="radio" id="game" name="type" value=0 checked>
							<label for="game">경기 문의</label>
						</c:if>
						<c:if test="${empty param.game_id}">
							<input type="radio" id="common" name="type" value=1 checked>
							<label for="common">일반 문의</label>
							<input type="radio" id="order" name="type" value=2>
							<label for="order">결제 문의</label>
							<input type="radio" id="ticket" name="type" value=3>
							<label for="ticket">티켓 문의</label>
						</c:if>
					</div>
					<!-- 제목 -->
					<div class="form-group">
						<input class="form-control form-control-sm" name="title" id="title" type="text" placeholder="제목" required>
					</div>
					<!-- 내용 -->
					<div class="form-group mb-7" id="editor"></div>
					<!-- Button -->
					<button type="button" class="btn btn-dark" id="btn">작성하기</button>
				</div>
			</div>
		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
