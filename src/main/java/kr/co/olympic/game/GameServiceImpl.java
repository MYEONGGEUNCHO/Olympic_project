package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.olympic.member.MemberVO;

public class GameServiceImpl implements GameService {
	@Autowired
	private GameMapper mapper;
	
	@Override
	public List<GameVO> listGame() {
		return null;
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
		return 0;
	}

	@Override
	public GameVO detailGame(GameVO game) {
		return null;
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
	public List<CommentVO> listComment(CommentVO comment) {
		return null;
	}

	@Override
	public int createFavorite(MemberVO member, GameVO game) {
		return 0;
	}

	@Override
	public List<GameVO> listFavorite(MemberVO member) {
		return null;
	}

	@Override
	public int deleteFavorite(MemberVO member, GameVO game) {
		return 0;
	}

}
