<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<script src="../js/jquery-3.7.1.min.js"></script>

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<!-- Editor's Style -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<script>
	let editor;

	$(function() {
		editor = new toastui.Editor({
			el : document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
			height : '500px', // 에디터 영역의 높이 값 (OOOpx || auto)
			initialEditType : 'wysiwyg', // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
			initialValue : '내용을 입력해 주세요.', // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
			previewStyle : 'vertical', // 마크다운 프리뷰 스타일 (tab || vertical)
			language : 'ko-KR',
			autofocus : true,
// 			TODO: 이미지 처리 최적화 필요함
// 			hooks: {
// 				addImageBlobHook(blob, callback) => {
// 				    const formData = new FormData();
// 		                    formData.append('file', blob);

// 		                    $.ajax({
// 		                        url: '/qna/upload.do',
// 		                        type: 'POST',
// 		                        data: formData,
// 		                        processData: false,
// 		                        contentType: false,
// 		                        success: (response) => {
// 		                            callback(response.url, 'alt text');
// 		                        },
// 		                        error: (jqXHR, textStatus, errorThrown) => {
// 		                            console.error('Error uploading file:', textStatus, errorThrown);
// 		                        }
// 		                    });
// 			}
		});
		$("#btn").click(function(e) {
			write();
		})
	});
	function write() {
		// 		$("#printdiv").html(editor.getMarkdown());		
		// 		$("#printdiv").html(editor.getHTML());
		// 		console.log("HTML:", editor.getHTML());
		// 		console.log("Markdown:", editor.getMarkdown());
		const inner_html = editor.getHTML();
		$.ajax({
			type : 'POST',
			url : '/olympic/qna/write.do',
			headers : {
				"Content-Type" : "application/json",
			},
			data : JSON.stringify({
				type : $("input[name='type']:checked").val(),
				title : $("#title").val(),
				content : inner_html
			}),
			success : function(response) {
				// 				console.log("Response:", response);
				// 성공 시 수행할 동작
				alert('글이 성공적으로 작성되었습니다.');
				location.href = "/olympic/qna/index.do";
			},
			error : function(xhr, status, error) {
				console.error("Error:", error);
				// 에러 시 수행할 동작
				alert('글 작성 중 오류가 발생했습니다.');
			}
		});
	}
</script>

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
					<button type="button" class="btn btn-dark" id="btn">입력하기</button>
				</div>
			</div>
		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
