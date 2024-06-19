<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장 관리자 추가</title>
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
	    var stadiumName = form['stadium_name'].value;
	    var stadiumImgUrl = form['stadium_img_url'].value;
	    var stadiumUrl = form['stadium_url'].value;
	    var stadiumEnName = form['stadium_en_name'].value;
	    var stadiumPosition = form['stadium_position'].value;
	    var aSeatQuantity = form['a_seat_quantity'].value;
	    var bSeatQuantity = form['b_seat_quantity'].value;
	    var cSeatQuantity = form['c_seat_quantity'].value;
	    var dSeatQuantity = form['d_seat_quantity'].value;
	    var vipSeatQuantity = form['vip_seat_quantity'].value;
	
	    // 필드가 비어있는지 확인
	    if (isEmpty(stadiumName) || isEmpty(stadiumImgUrl) || isEmpty(stadiumUrl) || isEmpty(stadiumEnName) || isEmpty(stadiumPosition) ||
	        isEmpty(aSeatQuantity) || isEmpty(bSeatQuantity) || isEmpty(cSeatQuantity) || isEmpty(dSeatQuantity) || isEmpty(vipSeatQuantity)) {
	        alert("모든 필드를 입력해주세요.");
	        return false;
	    }
	
	    // 좌석 수가 숫자인지 확인
	    if (!isNumeric(aSeatQuantity) || !isNumeric(bSeatQuantity) || !isNumeric(cSeatQuantity) || !isNumeric(dSeatQuantity) || !isNumeric(vipSeatQuantity)) {
	        alert("좌석 수는 숫자여야 합니다.");
	        return false;
	    }
	
	    // 문자열 길이 체크
	    if (stadiumName.length > 50 || stadiumImgUrl.length > 100 || stadiumUrl.length > 100 || stadiumEnName.length > 50 || stadiumPosition.length > 100) {
	        alert("입력값의 길이가 너무 깁니다. (경기장 이름 최대 50자, URL 최대 100자)");
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
	<h3>경기장 관리자 추가</h3>
	<form method="post" name="frm" id="frm" action="/olympic/admin/game/stadium/create.do">
		<table>
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
			<tbody>
				<tr>
					<th>경기장 이름</th>
					<td>
						<input type="text" name="stadium_name" value=""/>
					</td>
				</tr>
				<tr>
					<th>경기장 이미지 URL</th>
					<td>
						<input type="text" name="stadium_img_url" value=""/>
					</td>
				</tr>
				<tr>
					<th>경기장 주소 URL</th>
					<td>
						<input type="text" name="stadium_url" value=""/>
					</td>
				</tr>
				<tr>
					<th>영문 경기장명</th>
					<td>
						<input type="text" name="stadium_en_name" value=""/>
					</td>
				</tr>
				<tr>
					<th>경기장 주소</th>
					<td>
						<input type="text" name="stadium_position" value=""/>
					</td>
				</tr>
				<tr>
					<th>A좌석 수</th>
					<td>
						<input type="text" name="a_seat_quantity" value=""/>
					</td>
				</tr>
				<tr>
					<th>B좌석 수</th>
					<td>
						<input type="text" name="b_seat_quantity" value=""/>
					</td>
				</tr>
				<tr>
					<th>C좌석 수</th>
					<td>
						<input type="text" name="c_seat_quantity" value=""/>
					</td>
				</tr>
				<tr>
					<th>D좌석 수</th>
					<td>
						<input type="text" name="d_seat_quantity" value=""/>
					</td>
				</tr>
				<tr>
					<th>VIP좌석 수</th>
					<td>
						<input type="text" name="vip_seat_quantity" value=""/>
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