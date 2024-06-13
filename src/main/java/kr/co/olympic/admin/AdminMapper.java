package kr.co.olympic.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberVO;

@Mapper
public interface AdminMapper {
	//관리자
	MemberVO loginAdmin(MemberVO vo);
	int updateMember(MemberVO vo);
	List<MemberVO> memberList();
	int resetMember(MemberVO vo);
	int couponAdmin(CouponVO vo);
	
}
