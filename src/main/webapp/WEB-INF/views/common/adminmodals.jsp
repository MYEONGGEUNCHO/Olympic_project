<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 관리자 수정 모달 -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">회원 정보 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="memberfrm" method="post" action="/olympic/admin/updateMember.do">
                <div class="modal-body">
                    <input type="hidden" id="editEmail" name="email">
                    <div class="form-group">
                        <label for="editName">이름</label>
                        <input type="text" name="name" class="form-control" id="editName" name="name">
                    </div>
                    <div class="form-group">
                        <label for="editPoint">포인트</label>
                        <input type="number" name="point" class="form-control" id="editPoint" name="point">
                    </div>
                    <div class="form-group">
                        <label for="editMembership">멤버십</label>
                        <select class="form-control" id="editMemberShip" name="membership">
                            <option value="common">common</option>
                            <option value="VIP">VIP</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editState">상태</label>
                        <select class="form-control" id="editState" name="state">
                            <option value="0">회원</option>
                            <option value="1">탈퇴</option>
                            <option value="2">계정잠금</option>
                            <option value="3">관리자</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer d-flex">
                	<button type="button" class="btn btn-danger ms-auto" id="resetPwdBtn" style="margin-right: auto;">비밀번호 초기화</button>
                    <button type="button" id="saveBtn" class="btn btn-primary">저장</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 관리자 쿠폰 발행 모달 -->
<div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="couponModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="couponModalLabel">쿠폰 발행</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="get" action="/olympic/admin/issueCoupon.do">
                <div class="modal-body">
                    <input type="hidden" id="couponMemberNo" name="member_no">
                    <div class="form-group">
                        <label for="couponEmail">이메일</label>
                        <input type="text" class="form-control" id="couponEmail" name="email" readonly>
                    </div>
                    <div class="form-group">
                        <label for="couponContent">내용</label>
                        <input type="text" class="form-control" id="couponContent" name="content">
                    </div>
                    <div class="form-group">
                        <label for="couponDiscount">할인 비율</label>
                        <input type="number" class="form-control" id="couponDiscount" name="discount">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">발행</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 올림픽 경기일정 추가 -->
<div class="modal fade" id="editGameModal" tabindex="-1" role="dialog" aria-labelledby="insertGameModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="insertGameModalLabel">올림픽 경기일정 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="post" name="frm" id="gamefrm" action="/olympic/admin/game/update.do">
            <input type="hidden" id="editgame_id" name="game_id">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="sport_name">종목명</label>
                                <input type="text" class="form-control" id="editsport_name" name="sport_name">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="tournament">토너먼트</label>
                                <input type="text" class="form-control" id="edittournament" name="tournament">
                            </div>
                        </div>
                        <div class="col-md-4">
                        	<div class="form-group">
                                <label for="sport_code">종목코드</label>
                                <input type="text" class="form-control" id="editsport_code" name="sport_code">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="stadium_name">경기장 이름</label>
                                <input type="text" class="form-control" id="editstadium_name" name="stadium_name">
                            </div>
                            <div class="form-group">
                                <label for="country">국가 대진</label>
                                <input type="text" class="form-control" id="editcountry" name="country">
                            </div>
                            
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="stadium_no">경기장 ID</label>
                                <input type="number" class="form-control" id="editstadium_no" name="stadium_no">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="country1_name">국가1 이름</label>
                                <input type="text" class="form-control" id="editcountry1_name" name="country1_name">
                            </div>
                            <div class="form-group">
                                <label for="country1_flag">국가1 국기 IMG URL</label>
                                <input type="text" class="form-control" id="editcountry1_flag" name="country1_flag">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="country2_name">국가2 이름</label>
                                <input type="text" class="form-control" id="editcountry2_name" name="country2_name">
                            </div>
                            <div class="form-group">
                                <label for="country2_flag">국가2 국기 IMG URL</label>
                                <input type="text" class="form-control" id="editcountry2_flag" name="country2_flag">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="paris_date">파리 경기 일자</label>
                                <input type="text" class="form-control" id="editparis_date" name="paris_date">
                            </div>
                            <div class="form-group">
                                <label for="korea_date">한국 경기 일자</label>
                                <input type="text" class="form-control" id="editkorea_date" name="korea_date">
                            </div>
                        </div>
                        <div class="col-md-6">
                            
                            <div class="form-group">
                                <label for="paris_time">파리 경기 시간</label>
                                <input type="text" class="form-control" id="editparis_time" name="paris_time">
                            </div>
                            <div class="form-group">
                                <label for="korea_time">한국 경기 시간</label>
                                <input type="text" class="form-control" id="editkorea_time" name="korea_time">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="saveGame">수정</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 경기장 수정 -->
<div class="modal fade" id="editStadiumModal" tabindex="-1" role="dialog" aria-labelledby="insertGameModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editStadiumModalLabel">경기장 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="post" name="frm" id="stadiumfrm" action="/olympic/admin/game/stadium/update.do">
            <input type="hidden" id="editstadiumNo" name="stadium_no">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="stadiumName">경기장 이름</label>
                                <input type="text" class="form-control" id="editstadiumName" name="stadium_name">
                            </div>
                        </div>
                        <div class="col-md-4">
                        	<div class="form-group">
                                <label for="stadium_en_name">stadium_en_name</label>
                                <input type="text" class="form-control" id="editstadium_en_name" name="stadium_en_name">
                            </div>
                            
                        </div>
                        <div class="col-md-4">
                        	<div class="form-group">
                                <label for="stadium_position">stadium_position</label>
                                <input type="text" class="form-control" id="editstadium_position" name="stadium_position">
                            </div>
                        	
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="stadium_img_url">stadium_img_url</label>
                                <input type="text" class="form-control" id="editstadium_img_url" name="stadium_img_url">
                            </div>
                            
                            
                        </div>
                        <div class="col-md-6">
                        	<div class="form-group">
                                <label for="stadium_url">stadium_url</label>
                                <input type="text" class="form-control" id="editstadium_url" name="stadium_url">
                            </div>
                            
                        </div>
                    </div>
                    <div class="row">
                    	<div class="col-md-6">
                    		<div class="form-group">
                                <label for="a_seat_quantity">a_seat_quantity</label>
                                <input type="number" class="form-control" id="edita_seat_quantity" name="a_seat_quantity">
                            </div>
                            <div class="form-group">
                                <label for="b_seat_quantity">b_seat_quantity</label>
                                <input type="number" class="form-control" id="editb_seat_quantity" name="b_seat_quantity">
                            </div>
                            <div class="form-group">
                                <label for="c_seat_quantity">c_seat_quantity</label>
                                <input type="number" class="form-control" id="editc_seat_quantity" name="c_seat_quantity">
                            </div>
                            <div class="form-group">
                                <label for="d_seat_quantity">d_seat_quantity</label>
                                <input type="number" class="form-control" id="editd_seat_quantity" name="d_seat_quantity">
                            </div>
                            
                    	</div>
                    	
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="saveStadium">수정</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 경기장 수정 -->
<div class="modal fade" id="editSportModal" tabindex="-1" role="dialog" aria-labelledby="insertGameModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editSportModalLabel">종목 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="post" name="frm" id="sportfrm" action="/olympic/admin/game/stadium/update.do">
            <input type="hidden" id="editstadiumNo" name="stadium_no">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="editsport_code">경기 코드</label>
                                <input type="text" class="form-control" id="editsportCode" name="sport_code" readonly>
                            </div>
                        </div>
                        <div class="col-md-3">
                        	<div class="form-group">
                                <label for="editsport_name">sport_name</label>
                                <input type="text" class="form-control" id="editsportName" name="sport_name">
                            </div>
                            
                        </div>
                        <div class="col-md-6">
                        	<div class="form-group">
                                <label for="title_image">title_image</label>
                                <input type="text" class="form-control" id="edittitle_image" name="title_image">
                            </div>
                        	
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label for="link">link</label>
                                <input type="text" class="form-control" id="editlink" name="link">
                            </div>
                            
                            
                        </div>
                    </div>
                    <div class="row">
                    	<div class="col-md-10">
                    		<div class="form-group">
                                <label for="sport_info">sport_info</label>
                                <input type="text" class="form-control" id="editsport_info" name="sport_info">
                            </div>
                    		<div class="form-group">
                                <label for="sport_rule">sport_rule</label>
                                <input type="text" class="form-control" id="editsport_rule" name="sport_rule">
                            </div>
                            <div class="form-group">
                                <label for="sport_history">sport_history</label>
                                <input type="text" class="form-control" id="editsport_history" name="sport_history">
                            </div>
                            
                    	</div>
                    	
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="saveSport">수정</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 경기장 수정 -->
<div class="modal fade" id="editItemModal" tabindex="-1" role="dialog" aria-labelledby="insertGameModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editItemModalLabel">Item 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="post" name="frm" id="itemfrm" action="/olympic/admin/game/item/update.do">
            <input type="hidden" id="itemitem_no" name="item_no">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-2">
                            <div class="form-group">
                                <label for="itema_seat_sold">a_seat_sold</label>
                                <input type="number" class="form-control" id="itema_seat_sold" name="a_seat_sold">
                            </div>
                        </div>
                        <div class="col-md-2">
                        	<div class="form-group">
                                <label for="itemb_seat_sold">b_seat_sold</label>
                                <input type="number" class="form-control" id="itemb_seat_sold" name="b_seat_sold">
                            </div>
                            
                        </div>
                        <div class="col-md-2">
                        	<div class="form-group">
                                <label for="itemc_seat_sold">c_seat_sold</label>
                                <input type="number" class="form-control" id="itemc_seat_sold" name="c_seat_sold">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label for="itemd_seat_sold">d_seat_sold</label>
                                <input type="number" class="form-control" id="itemd_seat_sold" name="d_seat_sold">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label for="itemvip_seat_sold">vip_seat_sold</label>
                                <input type="number" class="form-control" id="itemvip_seat_sold" name="vip_seat_sold">
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                    	<div class="col-md-3">
                    		<div class="form-group">
                                <label for="itemstate">state</label>
                            	<select class="form-control" id="itemstate" name="state">
		                            <option value="true">true</option>
		                            <option value="false">false</option>
		                        </select>
                            </div>
                    	</div>
                    	<div class="col-md-3">
                            <div class="form-group">
                                <label for="itemis_korean">korean_advancement</label>
                            	<select class="form-control" id="itemis_korean" name="korean_advancement">
		                            <option value="true">true</option>
		                            <option value="false">false</option>
		                        </select>
                            </div>
                    	</div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="itema_seat_price">a_seat_price</label>
                                <input type="text" class="form-control" id="itema_seat_price" name="a_seat_price">
                            </div>
                        </div>
                        <div class="col-md-3">
                        	<div class="form-group">
                                <label for="itemb_seat_price">b_seat_price</label>
                                <input type="text" class="form-control" id="itemb_seat_price" name="b_seat_price">
                            </div>
                        </div>
                        <div class="col-md-3">
                        	<div class="form-group">
                                <label for="itemc_seat_price">c_seat_price</label>
                                <input type="text" class="form-control" id="itemc_seat_price" name="c_seat_price">
                            </div>
	                     </div>
                        <div class="col-md-3">
	                            <div class="form-group">
	                                <label for="itemd_seat_price">d_seat_price</label>
	                                <input type="text" class="form-control" id="itemd_seat_price" name="d_seat_price">
	                            </div>
	                    </div>
                    </div>
					<div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="itemvip_seat_price">vip_seat_price</label>
                                <input type="text" class="form-control" id="itemvip_seat_price" name="vip_seat_price">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="saveItem">수정</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>