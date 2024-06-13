package kr.co.olympic.qna;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import lombok.Data;

@Data
public class QnaVO {
	private int qna_no;
	private Timestamp regdate;
	private int type;
	private String title;
	// HTML 태그의 내용이 담기는 문의내용 content
	private String content;
	private int readcnt;
	// HTML 태그의 내용이 담기는 답변 reply
	private String reply;
	private Timestamp reply_date;
//	//TODO: game_id로 조회한 해당 qna와 연결된 game의 VO객체
//	private GameVO game_id;
	private int game_id;
	private String member_no;
	private String name;
	private QnaSearchDTO search;
	private int searchCount;
	private int state;
//	public int getGame_id() {
//		return game_id.getGame_id();
//	}
}
