<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA 글쓰기 테스트</title>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- Editor's Style -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script>
	$(function() {
		const editor = new toastui.Editor({
			el : document.querySelector('#editor'), // 에디터를 적용할 요소 (컨테이너)
			height : '500px', // 에디터 영역의 높이 값 (OOOpx || auto)
			initialEditType : 'markdown', // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
			initialValue : '내용을 입력해 주세요.', // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
			previewStyle : 'vertical' // 마크다운 프리뷰 스타일 (tab || vertical)
		});
	});
</script>
</head>
<body>

	<form action="/qna/write.do" method="post">
		<label> 에디터 적용 </label>
		<div id="editor"></div>
	</form>
</body>
</html>