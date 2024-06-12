<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>종목 관리자 추가</title>
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
<script type="text/javascript">
	function goSave() {
	    if (validateForm()) {
	        document.getElementById('frm').submit();
	    }
	}
	
	function validateForm() {
		var form = document.forms['frm'];
		var sportCode = form['sport_code'].value;
		var sportName = form['sport_name'].value;
		var titleImage = form['title_image'].value;
		var link = form['link'].value;
		var sportInfo = form['sport_info'].value;
		var sportRule = form['sport_rule'].value;
		var sportHistory = form['sport_history'].value;
		
		// 필드가 비어있는지 확인
		if (isEmpty(sportCode) || isEmpty(sportName) || isEmpty(titleImage) || isEmpty(link) ||
			isEmpty(sportInfo) || isEmpty(sportRule) || isEmpty(sportHistory)) {
			alert("모든 필드를 입력해주세요.");
			return false;
		}
		
		// 문자열 길이 체크
		if (sportCode.length > 10 || sportName.length > 255 || titleImage.length > 255 ||
				link.length > 255) {
			alert("입력값의 길이가 너무 깁니다.(경기장 코드 최대 10자, 종목설명, 규치, 올림픽 역사는 6만자 내외, 나머지는 255자)")
			return false;
		}
		
		return true;
	}
	
	function isEmpty(value) {
	    return !value.trim();
	}
	
	function isNumeric(value) {
	    return /^[0-9]+$/.test(value);
	}
</script>
</head>
<body>
	<h3>종목 관리자 추가</h3>
	<form method="post" name="frm" id="frm" action="/olympic/admin/game/sport/create.do">
		<table>
			<colgroup>
				<col width="50px">
				<col width="50px">
				<col width="50px">
				<col width="50px">
				<col width="50px">
				<col width="50px">
				<col width="50px">
			</colgroup>
			<tbody>
				<tr>
					<th>종목코드</th>
					<td>
						<input type="text" name="sport_code" value=""/>
					</td>
				</tr>
				<tr>
					<th>종목명</th>
					<td>
						<input type="text" name="sport_name" value=""/>
					</td>
				</tr>
				<tr>
					<th>종목 이미지 URL</th>
					<td>
						<input type="text" name="title_image" value=""/>
					</td>
				</tr>
				<tr>
					<th>종목 링크</th>
					<td>
						<input type="text" name="link" value=""/>
					</td>
				</tr>
				<tr>
					<th>종목 설명</th>
					<td>
						<input type="text" name="sport_info" value=""/>
					</td>
				</tr>
				<tr>
					<th>종목 규칙</th>
					<td>
						<input type="text" name="sport_rule" value=""/>
					</td>
				</tr>
				<tr>
					<th>종목 올림픽 역사</th>
					<td>
						<input type="text" name="sport_history" value=""/>
					</td>
				</tr>
			</tbody>
		</table>
		<div>
			<a href="javascript:goSave()">생성</a>
		</div>
	</form>
</body>
</html>