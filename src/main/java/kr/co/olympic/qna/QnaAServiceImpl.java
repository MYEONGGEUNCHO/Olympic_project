package kr.co.olympic.qna;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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

}
