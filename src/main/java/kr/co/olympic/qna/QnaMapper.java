package kr.co.olympic.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaMapper {
	// 접속 테스트
	int test();

	// 문의글 작성
	int write(QnaVO vo);

	// 공지사항 조회 최근 3개만
	List<QnaVO> notice();

	// 목록 조회 - 페이징 처리
	List<QnaVO> list(QnaSearchDTO search);

	// 개수 체크
	int count(QnaSearchDTO search);

	// 답변 작성
	int reply(QnaVO vo);

	// 상세 페이지 조회(조회수 증가X)
	QnaVO detail(Integer qna_no);

	// 조회수 증가
	int updateReadCnt(Integer qna_no);

	// 문의글 수정
	int update(QnaVO vo);

	// 문의글 삭제
	void delete(QnaVO vo);

	// 파일 업로드
	int saveAttachedFile(AttachedVO vo);

	// 파일 삭제

}
