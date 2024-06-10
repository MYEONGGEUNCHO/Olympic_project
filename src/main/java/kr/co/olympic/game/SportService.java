package kr.co.olympic.game;

import java.util.List;

public interface SportService {
	int createSport(SportVO sport);
    List<SportVO> listSport();
    SportVO detailSport(SportVO sport);
    int updateSport(SportVO sport);
    int deleteSport(SportVO sport);
}
