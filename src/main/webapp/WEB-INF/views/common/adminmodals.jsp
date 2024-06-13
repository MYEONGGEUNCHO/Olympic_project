<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Bootstrap Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">회원 정보 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="post" action="/olympic/admin/updateMember.do">
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
                <div class="modal-footer">
                	<button type="button" class="btn btn-danger" id="resetPwdBtn">비밀번호 초기화</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>
