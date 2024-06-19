package kr.co.olympic.game;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SportMapper {
	// #종목관련
	// 종목 생성
	int createSport(SportVO sport);
	// 종목 리스트
	List<SportVO> listSport(SportVO sport);
	// 종목 상세조회
	SportVO detailSport(GameVO game);
	// 종목 수정
	int updateSport(SportVO sport);
	// 종목 삭제
	int deleteSport(SportVO sport);
	// 종목 수
	int count(SportVO sport);
}
