package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

public interface SportService {
	int createSport(SportVO sport);
	Map<String, Object> listSport(SportVO vo);
    List<SportVO> listSport();
    SportVO detailSport(SportVO sport);
    int updateSport(SportVO sport);
    int deleteSport(SportVO sport);
}
