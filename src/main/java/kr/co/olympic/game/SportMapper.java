package kr.co.olympic.game;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SportMapper {
	// #종목관련
	// 종목 생성
	int createSport(SportVO sport);
	// 종목 리스트
	// 종목 수정
	// 종목 삭제
	// 종목 상세조회
}
