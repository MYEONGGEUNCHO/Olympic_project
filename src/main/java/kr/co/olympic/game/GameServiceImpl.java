package kr.co.olympic.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GameServiceImpl implements GameService {

	@Autowired
	private GameMapper mapper;
	@Autowired
	private StadiumMapper stadiumMapper;
	@Autowired
	private SportMapper sportMapper;
	@Autowired
	private ItemMapper itemMapper;
	// TODO: player 정보가 저장되면 가져오기

	@Override
	public Map<String, Object> listGame(GameVO param) {
		int count = mapper.count(param); // 총개수
		// 총페이지수
		int totalPage = count / 10;
		if (count % 10 > 0)
			totalPage++;
		List<GameVO> list = mapper.listGame(param); // 목록
		Map<String, Object> map = new HashMap<>();
		map.put("count", count);
		map.put("totalPage", totalPage);
		map.put("list", list);

		// 하단에 페이징처리
		int endPage = (int) (Math.ceil(param.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage)
			endPage = totalPage;
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("isPrev", isPrev);
		map.put("isNext", isNext);
		return map;
	}

	@Override
	public List<GameVO> listByDate(GameVO game) {
		return null;
	}

	@Override
	public List<GameVO> listByGame(GameVO game) {
		return null;
	}

	@Override
	public int createGame(GameVO game) {
		return mapper.createGame(game);
	}

	@Override
	public GameVO detailGame(GameVO game) {
		GameVO result = mapper.detailGame(game);
		result.setItem(itemMapper.detailItem(result));
		result.setStadium(stadiumMapper.detailStadium(result));
		result.setSport(sportMapper.detailSport(result));
		return result;
	}

	@Override
	public int updateGame(GameVO game) {
		return 0;
	}

	@Override
	public int deleteGame(GameVO game) {
		return 0;
	}

	@Override
	public int createComment(Map<String, Object> map) {

		return 0;
	}

	@Override
	public List<CommentVO> listComment(GameVO game) {
		return mapper.listComment(game);
	}

	@Override
	public int createFavorite(Map<String, Object> map) {
		return mapper.createFavorite(map);
	}

	@Override
	public List<GameVO> listFavorite(Map<String, Object> map) {
		return null;
	}

	@Override
	public int deleteFavorite(Map<String, Object> map) {
		return mapper.deleteFavorite(map);
	}
}
