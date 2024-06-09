package kr.co.olympic.game;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.olympic.member.MemberVO;

@Mapper
public interface GameMapper {
	//#경기관련
	//경기 전체 리스트
	List<GameVO> listGame();
	//경기 날짜별 리스트
	List<GameVO> listByDate(GameVO game);
	//경기 종목별 리스트
	List<GameVO> listByGamec(GameVO game);
	//경기 생성
	int createGame(GameVO game);
	//경기 상세조회
	GameVO detailGame(int game_id);
	//경기 수정
	int updateGame(GameVO game);
	//경기 삭제
	int deleteGame(int game_id);
	//경기 댓글 등록
	int createComment(GameVO game, CommentVO comment);
	//경기 댓글 리스트
	List<CommentVO> listComment(GameVO game);
	// 관심 경기 등록
	int createFavorite(MemberVO member, GameVO game);
	// 관심 경기 조회
	List<GameVO> listFavorite(MemberVO member);
	// 관심 경기 삭제
	int deleteFavorite(MemberVO member, GameVO game);
}
