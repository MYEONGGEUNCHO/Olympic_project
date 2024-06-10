package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

public interface StadiumService {
	int createStadium(StadiumVO vo);
	Map<String, Object> listStadium(StadiumVO vo);
    StadiumVO detailStadium(StadiumVO vo);
    int updateStadium(StadiumVO vo);
    int deleteStadium(StadiumVO vo);
}
