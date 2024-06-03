package kr.co.olympic.qna;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class QnaAServiceImpl implements QnaService {

	@Autowired
	private QnaMapper mapper;

	@Override
	public int write(QnaVO vo, HttpServletRequest request) {
//		if (!file.isEmpty() && file != null) {
//			// 파일명
//			String org = file.getOriginalFilename();
//			String ext = org.substring(org.lastIndexOf("."));
//			String real = System.currentTimeMillis()+ext;
//			// 파일저장
//			String path = request.getRealPath("/upload/board/")+real;
//			try {
//				file.transferTo(new File(path));
//			} catch (Exception e) {}
//			AttachedVO fileVO = new AttachedVO();
//			List<AttachedVO> list = new ArrayList<>();
//			fileVO.setOriginal(org);
//			fileVO.setReal(real);
//			list.add(fileVO);
//			vo.setAttached(list);
//		}
		int r = mapper.write(vo);
		return r;
	}

	@Override
	public List<QnaVO> list(Map<String, Integer> map) {
		List<QnaVO> list = mapper.list(map);
//		list.
//		System.out.println(list.toString());
		return list;
	}

	@Override
	public int count(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return 0;
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
