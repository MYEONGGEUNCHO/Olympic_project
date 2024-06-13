package kr.co.olympic.qna;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaMapper mapper;

	@Override
	public String serverTime(Locale locale) {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", locale);
		String formattedDate = dateFormat.format(date);
		return formattedDate;
	}

	@Override
	public int write(QnaVO vo) {
		if ("".equals(vo.getTitle()) || vo.getTitle() == null) {
			return 0;
		}
		if ("".equals(vo.getContent()) || vo.getContent() == null) {
			return 0;
		}
		// 게시글 정보 DB 저장
		return mapper.write(vo);
	}

	@Override
	public List<QnaVO> notice() {
		return mapper.notice();
	}

	@Override
	@Transactional
	public List<QnaVO> list(QnaSearchDTO dto) {
		// 페이지네이션 처리
		Map<String, Object> pages = new HashMap<>();
		int count = mapper.count(dto);
		int totalPage = (int) Math.ceil(count / 10.0);
		int endPage = (int) (Math.ceil(dto.getPage() / 10.0) * 10);
		int startPage = endPage - 9;
		if (endPage > totalPage)
			endPage = totalPage;
		boolean isPrev = startPage > 1;
		boolean isNext = endPage < totalPage;
		pages.put("count", count);
		pages.put("totalPage", totalPage);
		pages.put("endPage", endPage);
		pages.put("startPage", startPage);
		pages.put("isPrev", isPrev);
		pages.put("isNext", isNext);
		dto.setPages(pages);
		// 모든 처리 후 qna 조회 결과 리턴
		return mapper.list(dto);
	}

	@Override
	public int count(QnaSearchDTO dto) {
		return mapper.count(dto);
	}

	@Override
	public int reply(QnaVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public QnaVO detail(Integer qna_no) {
		return mapper.detail(qna_no);
	}

	@Override
	public int updateReadCnt(Integer qna_no) {
		return mapper.updateReadCnt(qna_no);
	}

	@Override
	@Transactional
	public QnaVO detailWithCnt(Integer qna_no) {
		mapper.updateReadCnt(qna_no);
		return mapper.detail(qna_no);
	}

	// 게시글 수정
	@Override
	public QnaVO update(QnaVO vo) {
//		TODO:: 파일 수정여부 체크해서 파일 add/delete 트랜잭션 묶어야함 
		return mapper.update(vo);
	}

	// 게시글 삭제
	@Override
	public void delete(QnaVO vo) {
		// TODO:: Attached에서 첨부파일 삭제 메소드 불러와야함
		mapper.delete(vo);
	}

}
