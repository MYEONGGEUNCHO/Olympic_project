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
	

}
