package kr.co.olympic.qna;

import java.util.Date;
import java.util.List;
import java.util.Locale;

public interface QnaService {
	// 서버 시간 전달
	Date serverTime(Locale locale);

	// 문의글 작성
	int write(QnaVO vo);
	
	// 공지사항 조회
	List<QnaVO> notice();

	// 목록 조회
	List<QnaVO> list(QnaSearchDTO search);

	// 개수 체크
	int count(QnaSearchDTO search);

	// 답변 작성
	int reply(QnaVO vo);

	// 상세 페이지 확인(조회수 증가X)
	QnaVO detail(Integer qna_no);

	// 상세 페이지 확인(조회수 증가O)
	QnaVO detailWithCnt(Integer qna_no);

	// 조회수 증가
	int updateReadCnt(Integer qna_no);

	// 게시글 수정
	int update(QnaVO vo);

	// 게시글 삭제
	void delete(QnaVO vo);
	
}
