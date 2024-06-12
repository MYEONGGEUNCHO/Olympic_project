package kr.co.olympic.game;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class GameVO {
	private int game_id;
	private String sport_name;
	private String country1_name;
	private String country2_name;
	private String tournament;
	private String country;
	private String country1_flag;
	private String country2_flag;
	private String stadium_name;
	private String paris_date;
	private String paris_time;
	private String korea_date;
	private String korea_time;
	private String sport_code;
	private int stadium_no;
	
	
	private List<PlayerVO> play_game;
	private List<CommentVO> comment;
	
	// 사용자로부터 전송되어지는 값(검색, 페이징, 필터링(조건))
	private String searchType;
	private String searchWord;
	private int page; // 사용자가 요청한 페이지 번호
	private int startIdx; // limit 앞에 들어갈 시작인덱스값
	
	public GameVO() {
		this.page = 1;
	}
	
	public int getStartIdx() {
		return (page-1) * 10;
	}
}
