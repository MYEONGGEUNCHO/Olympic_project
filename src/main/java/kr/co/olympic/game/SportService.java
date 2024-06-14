package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

public interface SportService {
	// 종목 생성
	int createSport(SportVO sport);
	// 종목 리스트
	Map<String, Object> listSport(SportVO sport);
	// 종목 상세
    SportVO detailSport(GameVO game);
    // 종목 수정
    int updateSport(SportVO sport);
    // 종목 삭제
    int deleteSport(SportVO sport);
}
