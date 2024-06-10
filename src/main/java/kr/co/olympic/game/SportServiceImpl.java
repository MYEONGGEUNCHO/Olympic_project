package kr.co.olympic.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SportServiceImpl implements SportService {
	
	@Autowired
    private SportMapper mapper;

    @Override
    public int createSport(SportVO sport) {
        return mapper.createSport(sport);
    }

    @Override
    public List<SportVO> listSport() {
        return mapper.listSport();
    }

    @Override
    public SportVO detailSport(SportVO sport) {
        return mapper.detailSport(sport);
    }

    @Override
    public int updateSport(SportVO sport) {
        return mapper.updateSport(sport);
    }

    @Override
    public int deleteSport(SportVO sport) {
        return mapper.deleteSport(sport);
    }
}
