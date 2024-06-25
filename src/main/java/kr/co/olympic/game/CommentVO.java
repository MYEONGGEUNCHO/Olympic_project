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
	private String name;
	private String email;

	public String getEmail() {
		if(this.email == null) return "****";
		return this.email.substring(0, 3) + "***";
	}
}
