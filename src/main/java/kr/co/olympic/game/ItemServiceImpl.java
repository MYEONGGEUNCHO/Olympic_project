package kr.co.olympic.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ItemServiceImpl implements ItemService {
	
	@Autowired
	private ItemMapper mapper;

    @Override
    public int createItem(ItemVO item) {
        return mapper.createItem(item);
    }

    @Override
    public Map<String, Object> listItem(ItemVO param) {
    	int count = mapper.count(param); // 총개수
        // 총페이지수
        int totalPage = count / 10;
        if (count % 10 > 0) totalPage++;
        List<ItemVO> list = mapper.listItem(param); // 목록
        
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
    public ItemVO detailItem(ItemVO item) {
        return mapper.detailItem(item);
    }

    @Override
    public int updateItem(ItemVO item) {
        return mapper.updateItem(item);
    }

    @Override
    public int deleteItem(ItemVO item) {
        return mapper.deleteItem(item);
    }
}
