package kr.co.olympic.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public Map<String, Object> listSport(SportVO param) {
    	int count = mapper.count(param); // 총개수
        // 총페이지수
        int totalPage = count / 10;
        if (count % 10 > 0) totalPage++;
        List<SportVO> list = mapper.listSport(param); // 목록
        
        Map<String, Object> map = new HashMap<>();
        map.put("count", count);
        map.put("totalPage", totalPage);
        map.put("list", list);
        
        // 하단에 페이징처리
        int endPage = (int)(Math.ceil(param.getPage()/10.0)*10);
        int startPage = endPage - 9;
        if (endPage > totalPage) endPage = totalPage;
        boolean isPrev = startPage > 1;
        boolean isNext = endPage < totalPage;
        map.put("endPage", endPage);
        map.put("startPage", startPage);
        map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		return map;
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
