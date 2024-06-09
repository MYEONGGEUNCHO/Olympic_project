package kr.co.olympic.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SportServiceImpl implements SportService {
	
	@Autowired
    SportMapper sportMapper;

    @Override
    public int createSport(SportVO sport) {
        return sportMapper.createSport(sport);
    }

    @Override
    public List<SportVO> listSport() {
        return sportMapper.listSport();
    }

    @Override
    public SportVO detailSport(SportVO sport) {
        return sportMapper.detailSport(sport);
    }

    @Override
    public int updateSport(SportVO sport) {
        return sportMapper.updateSport(sport);
    }

    @Override
    public int deleteSport(SportVO sport) {
        return sportMapper.deleteSport(sport);
    }
}
