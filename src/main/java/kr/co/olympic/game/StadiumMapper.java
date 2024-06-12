package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StadiumMapper {
	// 경기장 생성
	int createStadium(StadiumVO vo);
	// 경기장 리스트
	List<StadiumVO> listStadium(StadiumVO vo);
	// 상세조회
	StadiumVO detailStadium(StadiumVO vo);
	// 경기장 수정
	int updateStadium(StadiumVO vo);
	// 경기장 삭제
	int deleteStadium(StadiumVO vo);
	// 경기장 수
	int count(StadiumVO vo);
}
