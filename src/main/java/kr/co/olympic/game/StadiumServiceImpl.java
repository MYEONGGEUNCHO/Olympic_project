package kr.co.olympic.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StadiumServiceImpl implements StadiumService {
	
	@Autowired
	StadiumMapper stadiumMapper;

    @Override
    public int createStadium(StadiumVO stadium) {
        return stadiumMapper.createStadium(stadium);
    }

    @Override
    public List<StadiumVO> listStadium() {
        return stadiumMapper.listStadium();
    }

    @Override
    public StadiumVO detailStadium(StadiumVO stadium) {
        return stadiumMapper.detailStadium(stadium);
    }

    @Override
    public int updateStadium(StadiumVO stadium) {
        return stadiumMapper.updateStadium(stadium);
    }

    @Override
    public int deleteStadium(StadiumVO stadium) {
        return stadiumMapper.deleteStadium(stadium);
    }
}
