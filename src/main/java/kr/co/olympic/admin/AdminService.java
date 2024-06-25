package kr.co.olympic.admin;

import java.util.List;

import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberVO;

public interface AdminService {
	MemberVO loginAdmin(MemberVO vo);
	int updateMember(MemberVO vo);
	List<MemberVO> memberList();
	int resetMember(MemberVO vo);
	int couponAdmin(CouponVO vo);
	MemberVO detailMember(String member_no);
	
	//차트 그리기 용도
	List<AnalyticsVO> sumSalesByGame();
	List<AnalyticsVO> sumSalesByDays();
	List<AnalyticsVO> countSalesByGame();
	List<AnalyticsVO> countSalesByDays();
	List<AnalyticsVO> countCancelsByGame();
	List<AnalyticsVO> countCancelsByDays();

}
