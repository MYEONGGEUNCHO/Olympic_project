package kr.co.olympic.game;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommentVO {
	private int comment_no;
	private Timestamp regdate;
	private String content;
	private int game_id;
	private String member_no;
}
