package kr.co.olympic.qna;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaMapper mapper;

	@Override
	public Date serverTime(Locale locale) {
		// 한국 시간대의 Calendar 객체 생성
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"), locale);

		// 현재 시간을 가져옴
		Date date = calendar.getTime();
		return date;
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
		return mapper.reply(vo);
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
	public int update(QnaVO vo) {
		if ("".equals(vo.getTitle()) || vo.getTitle() == null) {
			return 0;
		}
		if ("".equals(vo.getContent()) || vo.getContent() == null) {
			return 0;
		}
		// 게시글 정보 DB 저장
		return mapper.update(vo);
	}

	// 게시글 삭제
	@Override
	public void delete(QnaVO vo) {
		mapper.delete(vo);
	}

}
