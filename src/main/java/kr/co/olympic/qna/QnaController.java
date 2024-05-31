package kr.co.olympic.qna;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.olympic.member.MemberVO;

@Controller
public class QnaController {
	@Autowired
	private QnaService service;
	
	@GetMapping("/qna/index.do")
	public String index(Model model, QnaVO vo, HttpSession sess) {
		MemberVO login = (MemberVO)sess.getAttribute("login");
		
		return "qna/index";
	}
	
	@GetMapping("/qna/write.do")
	public String write(Model model, HttpSession sess) {
		return "qna/write";
	}
	@PostMapping("/qna/write.do")
	public String write(Model model, HttpSession sess, QnaVO vo) {
		
		return "qna/write";
	}
}
