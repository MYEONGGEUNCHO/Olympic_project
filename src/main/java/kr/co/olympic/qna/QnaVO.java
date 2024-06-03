package kr.co.olympic.qna;

import java.sql.Timestamp;
import java.util.List;

import kr.co.olympic.member.MemberVO;
import lombok.Data;

@Data
public class QnaVO {
	private int qna_no;
	private Timestamp regdate;
	private int type;
	private String title;
	//HTML 태그의 내용이 담기는 문의내용 content
	private String content;
	private int readcnt;
	//HTML 태그의 내용이 담기는 답변 reply
	private String reply;
//	// game_id로 조회한 해당 qna와 연결된 game의 VO객체
//	private GameVO game_id;
	// member_no로 조회한 해당 qna를 작성한 member의 VO객체
	private String member_no;

	// 첨부파일 리스트
	private List<AttachedVO> attached;
	
	//테스트용
	private int game_id;
//	private int member_no;
}
