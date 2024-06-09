package kr.co.olympic.game;

import java.util.List;

public interface StadiumService {
	int createStadium(StadiumVO stadium);
    List<StadiumVO> listStadium();
    StadiumVO detailStadium(StadiumVO stadium);
    int updateStadium(StadiumVO stadium);
    int deleteStadium(StadiumVO stadium);
}
