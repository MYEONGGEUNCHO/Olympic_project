<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>올림픽 경기일정 관리자 추가</title>
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
		var sport_name = form['sport_name'].value;
		var country1_name = form['country1_name'].value;
		var country2_name = form['country2_name'].value;
		var tournament = form['tournament'].value;
		var country = form['country'].value;
		var country1_flag = form['country1_flag'].value;
		var country2_flag = form['country2_flag'].value;
		var stadium_name = form['stadium_name'].value;
		var paris_date = form['paris_date'].value;
		var paris_time = form['paris_time'].value;
		var korea_date = form['korea_date'].value;
		var korea_time = form['korea_time'].value;
		var sport_code = form['sport_code'].value;
		var stadium_no = form['stadium_no'].value;
		
		// 경기장 ID 숫자인지 확인
		if (!isNumeric(stadium_no)) {
			alert("좌석 수는 숫자여야 합니다.");
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
	<h3>올림픽 경기일정 관리자 추가</h3>
	<form method="post" name="frm" id="frm" action="/olympic/admin/game/create.do">
		<table>
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
			<tbody>
				<tr>
					<th>종목명</th>
					<td>
						<input type="text" name="sport_name" value=""/>
					</td>
				</tr>
				<tr>
					<th>국가1이름</th>
					<td>
						<input type="text" name="country1_name" value=""/>
					</td>
				</tr>
				<tr>
					<th>국가2이름</th>
					<td>
						<input type="text" name="country2_name" value=""/>
					</td>
				</tr>
				<tr>
					<th>토너먼트</th>
					<td>
						<input type="text" name="tournament" value=""/>
					</td>
				</tr>
				<tr>
					<th>국가대진</th>
					<td>
						<input type="text" name="country" value=""/>
					</td>
				</tr>
				<tr>
					<th>국가1국기_IMG_URL</th>
					<td>
						<input type="text" name="country1_flag" value=""/>
					</td>
				</tr>
				<tr>
					<th>국가2국기_IMG_URL</th>
					<td>
						<input type="text" name="country2_flag" value=""/>
					</td>
				</tr>
				<tr>
					<th>경기장이름</th>
					<td>
						<input type="text" name="stadium_name" value=""/>
					</td>
				</tr>
				<tr>
					<th>파리경기일자</th>
					<td>
						<input type="text" name="paris_date" value=""/>
					</td>
				</tr>
				<tr>
					<th>파리경기시간</th>
					<td>
						<input type="text" name="paris_time" value=""/>
					</td>
				</tr>
				<tr>
					<th>한국경기일자</th>
					<td>
						<input type="text" name="korea_date" value=""/>
					</td>
				</tr>
				<tr>
					<th>한국경기시간</th>
					<td>
						<input type="text" name="korea_time" value=""/>
					</td>
				</tr>
				<tr>
					<th>종목코드</th>
					<td>
						<input type="text" name="sport_code" value=""/>
					</td>
				</tr>
				<tr>
					<th>경기장ID</th>
					<td>
						<input type="text" name="stadium_no" value=""/>
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