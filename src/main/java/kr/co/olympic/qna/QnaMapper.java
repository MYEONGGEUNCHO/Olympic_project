package kr.co.olympic.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaMapper {

	// 문의글 작성
	int write(QnaVO vo);
	// 목록 조회 - 페이징 처리
	List<QnaVO> list(Map<String,Integer> map);
	// 개수 체크
	int count(Map<String,Integer> map);
	// 답변 작성
	int reply(QnaVO vo);
	
	
}
