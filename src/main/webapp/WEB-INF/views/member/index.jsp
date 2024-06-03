<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>
$(document).ready(function() {
    $('#emailCheck').click(function() {
        var email = $('#email').val().trim();

        if (email === '') {
            alert('이메일을 입력해주세요.');
            $("#email").focus();
            return;
        }

        var con = true;
        // AJAX request to check if email is duplicated
        $.ajax({
            url: '/olympic/member/emailCheck.do',
            data: { email: email },
            async: false,
            success: function(res) {
                if (res == '1') {
                    alert('중복된 이메일입니다.\r\n다른 이메일을 입력해 주세요');
                    con = false;
                    return;
                } else {
                	 if ($('#authCodeInput').length === 0) {
                         $('#emailCheck').after(
                             '<div id="authCodeInput" style="margin-top: 10px;">' +
                             '<label for="authCode">인증 코드: </label>' +
                             '<input type="text" id="authCode" name="authCode">' +
                             '<button id="checkAuth" type="button">인증확인</button>'+
                             '</div>'
                         );
                     }
	               	 
	               	 $.ajax({
	               		 url: '/olympic/member/mailCheck.do',
	               		 type: 'POST',
	               		 data: {email: $('#email').val()},
	               		 success: function(data){
	               			 if( data != ''){
	               				var authcode = data;
	               			 }
	               		 }	               		 
	               	 });
                    alert('인증 코드가 발송되었습니다.');
                }
            }, //success
            error: function() {
                alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
});
</script>
</head>
<body>
	<h3 class="sub_title">회원가입</h3>
	<form name="frm" id="frm" action="/member/regist.do" method="post">
		<table class="board_write">
			<tbody>
				<tr>
					<th>*이메일</th>
					<td><input type="text" name="email" id="email"
						class="inNextBtn" style="float: left;"> <span
						class="email_check"><a href="javascript:;"
							class="btn bgGray" style="float: left; width: auto; clear: none;"
							id="emailCheck">인증 코드 발송</a></span></td>
				</tr>
				<tr>
					<th>*비밀번호</th>
					<td><input type="password" name="pwd" id="pw"
						style="float: left;"> <span class="ptxt">비밀번호는 숫자,
							영문 조합으로 8자 이상으로 입력해주세요.</span></td>
				</tr>
				<tr>
					<th>*비밀번호<span>확인</span></th>
					<td><input type="password" name="pw_check" id="pw_check"
						style="float: left;"></td>
				</tr>
				<tr>
					<th>*이름</th>
					<td><input type="text" name="name" id="name"
						style="float: left;"></td>
				</tr>
				<tr>
					<th>*생년월일</th>
					<td><input type="text" name="birth" id="birth"
						style="float: left;"></td>
				</tr>
				<tr>
					<th>*휴대폰 번호</th>
					<td><input type="text" name="hp" id="hp" value=""
						maxlength="15" style="float: left;"></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="cmd" value="write.do" /> <input
			type="hidden" name="checkEmail" id="checkEmail" value="0" />
	</form>
	<div class="btnSet clear">
		<div>
			<a href="javascript:;" class="btn" onclick="goSave();">가입</a> <a
				href="javascript:;" class="btn" onclick="history.back();">취소</a>
		</div>
	</div>

</body>
</html>