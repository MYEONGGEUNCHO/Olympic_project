package kr.co.olympic.qna;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.olympic.member.MemberVO;

@Controller
public class QnaController {
	@Autowired
	private QnaService service;

	@GetMapping("/qna/index.do")
	public String index(Model model, QnaSearchDTO dto, Locale locale, HttpSession session) {
		List<QnaVO> qnaList = service.list(dto);
//		model.addAttribute("qna", qnaList);
//		model.addAttribute("search", dto);
		model.addAttribute("serverTime", service.serverTime(locale));
		return "qna/index";
	}

	@PostMapping("/qna/search.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> search(@RequestBody QnaSearchDTO dto) {
		Map<String, Object> map = new HashMap<>();
		map.put("noticeResults", service.notice());
		map.put("searchResults", service.list(dto));
		map.put("searchConditions", dto);
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	@GetMapping("/qna/write.do")
	public String write(Model model, Locale locale) {
//		System.out.println("####write get 요청 들어옴");
		model.addAttribute("serverTime", service.serverTime(locale));
		return "qna/write";
	}

	@PostMapping("/qna/write.do")
	@ResponseBody
	public String write(@RequestBody QnaVO vo, Model model, HttpSession session, HttpServletRequest request) {
		// 세션에서 로그인 정보를 가져올 수 있다면 사용
		MemberVO loginMember = (MemberVO) session.getAttribute("login");
		if (loginMember == null) {
			model.addAttribute("msg", "로그인 정보가 없습니다.");
			return "common/alert";
		}

		if (service.write(vo) != 1) {
			model.addAttribute("msg", "문의사항 작성에 실패했습니다.");
			return "common/alert";
		}
		return "redirect: qna/index";

	}

	@GetMapping("/qna/detail.do")
	public String detailWithCnt(Model model, @RequestParam(value = "qna_no") Integer qna_no) {
		model.addAttribute("qna", service.detailWithCnt(qna_no));
		return "qna/detail";
	}

	@PostMapping("/qna/delete.do")
	@ResponseBody
	public ResponseEntity<String> delete(@RequestBody QnaVO qnaVO, HttpSession session) {
		MemberVO loginMember = (MemberVO) session.getAttribute("login");
		if (loginMember == null) {
			loginMember = new MemberVO();
			loginMember.setMember_no("3333"); // 테스트용 데이터
		}
		if (loginMember.getMember_no().equals(qnaVO.getMember_no())) {
			service.delete(qnaVO);
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("실패");

//			model.addAttribute("msg", "본인이 작성한 게시글만 삭제가 가능합니다.");
//			model.addAttribute("url", "/qna/index.do");
//			return "common/alert.do";
		}
		return ResponseEntity.ok("삭제가 완료되었습니다.");
	}

	@GetMapping("/qna/update.do")
	public String update(Model model, HttpSession session, Locale locale,
			@RequestParam(value = "qna_no") Integer qna_no) {
		model.addAttribute("qna", service.detail(qna_no));
		model.addAttribute("serverTime", service.serverTime(locale));
		return "qna/update";
	}

	@PostMapping("/qna/update.do")
	@ResponseBody
	public String update(Model model, HttpSession session, @RequestBody QnaVO qnaVO) {
		int result = 0;
		MemberVO loginMember = (MemberVO) session.getAttribute("login");
		if (loginMember == null) {
			model.addAttribute("msg", "로그인 정보가 없습니다.");
			return "common/alert";
		}
		if (loginMember.getMember_no().equals(qnaVO.getMember_no())) {
			result = service.update(qnaVO);
			if (result == 0) {
				model.addAttribute("msg", "게시글 수정에 실패했습니다.");
				return "common/alert";
			}
		} else {
			model.addAttribute("msg", "본인이 작성한 게시글만 수정이 가능합니다.");
			model.addAttribute("url", "/qna/index.do");
			return "common/alert";
		}
		return "qna/index";
	}

}
