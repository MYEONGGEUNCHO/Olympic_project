package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StadiumMapper {
	// 경기장 생성
	int createStadium(StadiumVO stadium);
	// 경기장 리스트
	List<StadiumVO> listStadium(StadiumVO stadium);
	// 상세조회
	StadiumVO detailStadium(GameVO game);
	// 경기장 수정
	int updateStadium(StadiumVO stadium);
	// 경기장 삭제
	int deleteStadium(StadiumVO stadium);
	// 경기장 수
	int count(StadiumVO stadium);
}
