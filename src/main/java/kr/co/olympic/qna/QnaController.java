package kr.co.olympic.qna;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
	public String index(Model model, QnaVO vo, Locale locale, HttpSession sess,
			@RequestParam(value = "game_id", required = false) Integer game_id,
			@RequestParam(value = "member_no", required = false) Integer member_no,
			@RequestParam(value = "type", required = false) Integer type) {
		MemberVO login = (MemberVO) sess.getAttribute("login");
		Map<String, Integer> map = new HashMap<>();
		if (game_id != null) {
			map.put("game_id", game_id);
		}
		if (member_no != null) {
			map.put("member_no", member_no);
		}
		if (type != null) {
			map.put("type", type);
		}
		map.put("startIdx", 1);
		model.addAttribute("qna", service.list(map));
		// 오늘 날짜 작성된 게시글은 시간만 표시해주기 위한 날짜 전송
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);

//		System.out.println(map.toString());
		return "qna/index";
	}

	@GetMapping("/qna/write.do")
	public String write(Model model, Locale locale) {
//		System.out.println("####write get 요청 들어옴");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.FULL, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate); 

		return "qna/write";
	}

	@PostMapping("/qna/write.do")
	@ResponseBody
	public String write(@RequestBody QnaVO vo, HttpSession session, HttpServletRequest request) {
		// 세션에서 로그인 정보를 가져올 수 있다면 사용
		MemberVO loginMember = (MemberVO) session.getAttribute("login");
		if (loginMember == null) {
			loginMember = new MemberVO();

			loginMember.setMember_no("testuuid"); // 테스트용 데이터
			loginMember.setName("테스트");
		}
//		qnaVO.setMember_no(loginMember.getMember_no());
//		System.out.println("########write post 요청 들어왔습니다.");
		service.write(vo, request); // 파일 업로드가 없으므로 null 전달

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
	public String update(Model model, HttpSession session, Locale locale, @RequestParam(value="qna_no") Integer qna_no) {
//		QnaVO qna = service.detail(qna_no);
		model.addAttribute("qna",service.detail(qna_no));	
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.FULL, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate); 
		
		return "qna/update";
	}
	
	@PostMapping("/qna/update.do")
	@ResponseBody
	public String update(Model model, HttpSession session, @RequestBody QnaVO qnaVO) {
		MemberVO loginMember = (MemberVO) session.getAttribute("login");
		if (loginMember.getMember_no().equals(qnaVO.getMember_no())) {
			service.update(qnaVO);
		} else {
			model.addAttribute("msg", "본인이 작성한 게시글만 수정이 가능합니다.");
			model.addAttribute("url", "/qna/index.do");
			return "common/alert.do";
		}
		return "qna/index";
	}

}
