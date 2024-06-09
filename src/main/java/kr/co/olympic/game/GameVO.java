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
	private Timestamp paris_time;
	private Timestamp paris_date;
	private Timestamp korea_time;
	private Timestamp korea_date;
	private String sport_code;
	private int stadium_no;
	
	
	private List<PlayerVO> play_game;
	private List<CommentVO> comment;
}
