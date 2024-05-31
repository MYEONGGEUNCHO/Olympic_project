package kr.co.olympic.qna;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface QnaService {

	// 문의글 작성
	int write(QnaVO vo, HttpServletRequest request);

	// 목록 조회 - 페이징 처리
	List<QnaVO> list(Map<String, Integer> map);

	// 개수 체크
	int count(Map<String, Integer> map);

	// 답변 작성
	int reply(QnaVO vo);

}
