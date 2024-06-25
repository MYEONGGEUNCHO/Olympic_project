package kr.co.olympic.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper mapper;

	@Override
	public MemberVO loginAdmin(MemberVO vo) {
		return mapper.loginAdmin(vo);
	}

	@Override
	public int updateMember(MemberVO vo) {
		return mapper.updateMember(vo);
	}

	@Override
	public List<MemberVO> memberList() {
		return mapper.memberList();
	}

	@Override
	public int resetMember(MemberVO vo) {
		return mapper.resetMember(vo);
	}

	@Override
	public int couponAdmin(CouponVO vo) {
		return mapper.couponAdmin(vo);
	}

	@Override
	public MemberVO detailMember(String member_no) {
		return mapper.detailMember(member_no);
	}

	// 차트 그리기 용도
	@Override
	public List<AnalyticsVO> sumSalesByGame() {
		return mapper.sumSalesByGame();
	}

	@Override
	public List<AnalyticsVO> sumSalesByDays() {
		return mapper.sumSalesByDays();
	}

	@Override
	public List<AnalyticsVO> countSalesByGame() {
		return mapper.countSalesByGame();
	}

	@Override
	public List<AnalyticsVO> countSalesByDays() {
		return mapper.countSalesByDays();
	}

	@Override
	public List<AnalyticsVO> countCancelsByGame() {
		return mapper.countCancelsByGame();
	}

	@Override
	public List<AnalyticsVO> countCancelsByDays() {
		return mapper.countCancelsByDays();
	}

}
