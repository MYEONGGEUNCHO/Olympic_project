package kr.co.olympic.qna;

import java.util.List;
import java.util.Map;

public interface QnaService {

	// 문의글 작성
	int write(QnaVO vo);
	// 목록 조회 - 페이징 처리
	List<QnaVO> list(Map<String,Integer> map);
	// 개수 체크
	int count(Map<String,Integer> map);
	// 답변 작성
	int reply(QnaVO vo);
	
}
