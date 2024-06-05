<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>
var check = false;  //이메일 본인인증 확인 변수
var intervalId = null; // 타이머를 관리할 변수
$(document).ready(function() {
	$('#emailCheck').click(function() {
	    var email = $('#registerEmail').val().trim();

	    if (email === '') {
	        alert('이메일을 입력해주세요.');
	        $("#email").focus();
	        return;
	    }
	 	// 타이머 초기화
	    if (intervalId !== null) {
	        clearInterval(intervalId);
	        intervalId = null;
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
	                     $('#formAuth').after(
	                    		 '<div class="col-12 row" id="authCodeInput">'+
	                             <!-- Email -->
	                             '<div class="form-group col-md-8 mb-1">'+
	                               '<label class="visually-hidden col-sm-2 col-form-label col-form-label-sm" for="registerFirstName">Email</label>'+
	                               '<input class="form-control form-control-sm" id="authCode" type="text" placeholder="인증번호 입력" required>'+
	                             '</div>'+
	                             '<div class = "col-6 col-md-4">'+
	                             	'<button class="btn btn-sm btn-dark" id="checkAuth">'+
	                               '본인 인증 확인'+
	                             	'</button>'+
	                             '</div>'+
	                           '</div>'+
	                           '<div>'+
	                           	'<div class = "col-md-4 mx-2 mb-3" id="timer" >남은 시간: <span id="min">3</span>:<span id="sec">00</span>'+
	                             '</div>'+
	                           '</div>'
	                     );
	                 }
	               	 
	               	 $.ajax({
	               		 url: '/olympic/member/mailCheck.do',
	               		 type: 'POST',
	               		 data: {email: $('#registerEmail').val()},
	               		 success: function(data){

	               			 if( data != ''){
	               				 console.log(data);
	               				 alert('인증 코드가 발송되었습니다. 이메일을 확인해주세요.');
	               				 
	               				 $('#timer').show();
	                                let time = 180;
	                                const takeTarget = () => {
	                                	intervalId = setInterval(function () {
	                                        if (time > 0) {
	                                            time = time - 1;
	                                            let min = Math.floor(time / 60);
	                                            let sec = String(time % 60).padStart(2, "0");
	                                            $('#min').text(min);
	                                            $('#sec').text(sec);
	                                        } else {
	                                            clearInterval(intervalId);
	                                            $('#checkAuth').prop('disabled', true);
	                                            alert('인증 시간이 만료되었습니다. 다시 시도해주세요.');
	                                        }
	                                    }, 1000);
	                                };
	                                takeTarget();
	               				
	               				 
		               			 $('#checkAuth').click(function() {
	                                 var userInputCode = $('#authCode').val().trim();
	                                 if (userInputCode === data) {
	                                     alert('본인 확인이 완료되었습니다.');
	                                     $('#registerEmail').prop('readonly', true);
	                                     //$('#checkEmail').val('1');
	                                     clearInterval(intervalId); // 타이머 멈춤
	                                     $('#timer').hide(); // 타이머 숨김
	                                     
	                                     check = true;
	                                 } else {
	                                     alert('인증 코드가 일치하지 않습니다. 다시 확인해주세요.');
	                                 }
	                             });
	               			 } else{
	               				 alert('에러 발생');
	               			 }
	               		 }	               		 
	               	 });
	                
	            }
	        }, //success
	        error: function() {
	            alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
	        }
	    });
	});
    
});




function goSave(){
		if(!check){
			alert('이메일 인증이 완료되지 않았습니다.');
			$('#registerEmail').focus();
			return;
		}
	
		 if ($("#pw").val() == '') {
				alert('비밀번호를 입력하세요');
				$("#pw").focus();
				return;
			}
		if ($("#pw").val() != $("#pw_check").val()) {
			alert('비밀번호를 확인하세요');
			return;
		}
		var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/;
		if ($("#pw").val().match(reg) == null) {
			alert('비밀번호는 영문+숫자 조합으로 8자이상 입력하세요');
			$("#pw").val('');
			$("#pw_check").val('');
			return;
		}
		if ($("#name").val() == '') {
			alert('이름을 입력하세요');
			$("#name").focus();
			return;
		}
		if ($("#name").val() == '') {
			alert('이름을 입력하세요');
			$("#name").focus();
			return;
		}
		if ($("#birth").val() == '') {
			alert('생년월일을 입력하세요');
			$("#birth").focus();
			return;
		}
		$("#frm").submit();
}
</script>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<section class="pt-7 pb-12">
		<div class="container">
			<div class="row justify-content-center">
	 <div class="col-12 col-md-6">

            <!-- Card -->
            <div class="card card-lg">
              <div class="card-body">

                <!-- Heading -->
                <h6 class="mb-7">회원가입</h6>

                <!-- Form -->
                <form name="frm" id="frm" action="/olympic/member/regist.do" method="post">
                  <div class="row">
                    <div class="col-12 row" id="formAuth">
                      <!-- Email -->
                      <div class="form-group col-md-8">
                        <label class="visually-hidden" for="registerEmail">
                          Email
                        </label>
                        <input class="form-control form-control-sm" name="email" id="registerEmail" type="email" placeholder="Email *" required>
             
                      </div>
                      <div class = "col-6 col-md-2">
                      	<button class="btn btn-sm btn-dark" id="emailCheck">
                        인증 코드 전송
                      	</button>
                      </div>
                    </div>
                    
              
                    <div class="col-12 col-md-6">
                      <!-- Password -->
                      <div class="form-group">
                        <label class="visually-hidden" for="registerPassword">
                          Password *
                        </label>
                        <input class="form-control form-control-sm" name="pwd" id="pw" type="password" placeholder="Password *" required>
                      </div>
                    </div>
                    
                    <div class="col-12 col-md-6">
                      <!-- Password -->
                      <div class="form-group">
                        <label class="visually-hidden" for="registerPasswordConfirm">
                          Confirm Password *
                        </label>
                        <input class="form-control form-control-sm" name="pw_check" id="pw_check" type="password" placeholder="Confrm Password *" required>
                      </div>
                    </div>
                    
                    <div class="col-12">
                      <!-- Email -->
                      <div class="form-group">
                        <label class="visually-hidden" for="registerLastName">
                          이름
                        </label>
                        <input class="form-control form-control-sm" name="name" id="registerLastName" type="text" placeholder="Name *" required maxlength='6'>
                      </div>
                    </div>
                    
                    <div class="col-12">
                      <!-- Email -->
                      <div class="form-group">
                        <label class="visually-hidden" for="registerFirstName">
                          Birthday
                        </label>
                        <input class="form-control form-control-sm" name="birthday" id="birth" type="date" value="2024-07-24" placeholder="Birthday * 2024-07-24" required>
                      </div>
                    </div>
                    
                    <div class="col-12">
                      <!-- Email -->
                      <div class="form-group">
                        <label class="visually-hidden" for="registerFirstName">
                          phone
                        </label>
                        <input class="form-control form-control-sm" name="phone" id="phone" type="tel" placeholder="Phone *"  pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
                      </div>
                    </div>
                    
                    <div class="col-12 col-md-auto">
                      <!-- Link -->
                      <div class="form-group fs-sm text-muted">
                        By registering your details, you agree with our Terms & Conditions,
                        and Privacy and Cookie Policy.
                      </div>

                    </div>
                   
                    <div class="col-12">

                      <!-- Button -->
                      <button class="btn btn-sm btn-dark" type="button" onclick="goSave()">
                        Register
                      </button>

                    </div>
                  </div>
                </form>

              </div>
            </div>

          </div>
          	</div>
		</div>
	</section>
<%-- 	<%@include file="../contactus.jsp"%> --%>
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
