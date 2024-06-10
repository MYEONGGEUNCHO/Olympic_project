package kr.co.olympic.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StadiumServiceImpl implements StadiumService {
	
	@Autowired
	private StadiumMapper mapper;

    @Override
    public int createStadium(StadiumVO stadium) {
        return mapper.createStadium(stadium);
    }

    @Override
    public Map<String, Object> listStadium(StadiumVO param) {
    	int count = mapper.count(param); // 총개수
        // 총페이지수
        int totalPage = count / 10;
        if (count % 10 > 0) totalPage++;
        List<StadiumVO> list = mapper.listStadium(param); // 목록
        
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
    public StadiumVO detailStadium(StadiumVO stadium) {
        return mapper.detailStadium(stadium);
    }

    @Override
    public int updateStadium(StadiumVO stadium) {
        return mapper.updateStadium(stadium);
    }

    @Override
    public int deleteStadium(StadiumVO stadium) {
        return mapper.deleteStadium(stadium);
    }
}
