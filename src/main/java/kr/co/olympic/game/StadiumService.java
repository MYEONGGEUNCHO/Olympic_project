package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

public interface StadiumService {
	// 경기장 생성
	int createStadium(StadiumVO stadium);
	// 경기장 리스트
	Map<String, Object> listStadium(StadiumVO vo);
	// 경기장 상세
    StadiumVO detailStadium(StadiumVO vo);
    // 경기장 수정
    int updateStadium(StadiumVO vo);
    // 경기장 삭제
    int deleteStadium(StadiumVO vo);
}
