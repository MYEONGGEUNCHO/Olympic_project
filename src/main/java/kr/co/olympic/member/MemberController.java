package kr.co.olympic.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.olympic.member.MemberVO;

//@Controller
@RestController
public class MemberController {
	@Autowired
	private MemberService service;
	
	
	@GetMapping("/member/login.do")
	public void login() {
		
	}
	
	@PostMapping("/member/login.do")
	public String login(Model model, MemberVO vo, HttpSession sess) {
		MemberVO login = service.login(vo);
		if (login == null) {
			model.addAttribute("msg", "이메일 비밀번호를 확인하세요.");
			model.addAttribute("url", "/member/login.do");
			return "/member/login.jsp";
		} else {
			sess.setAttribute("login", login);
			return "redirect:/member/index.jsp";
		}
	}
	
	@PostMapping("/member/regist.do")
	public String regist(Model model, MemberVO vo) {
		int regist = service.regist(vo);
		if(regist > 0 ) {
			return "/member/회원가입 완료 페이지";
		}
		else{
			return "alert 창 띄우기";
		}
	}
	
	//ajax를 통해 올거임
	@GetMapping("/member/emailCheck.do")
	public int emailCheck(String email) {
		return service.emailCheck(email);
	}
	
	@PostMapping("/member/update.do")
	public String update(MemberVO vo, Model model) {
		int r = service.update(vo);
		String msg = "";
		String url = "edit.do";
		
		if (r > 0) {
			msg = "정상적으로 수정되었습니다.";
		} else {
			msg = "수정 오류";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		return "alert창 띄우기";
	}
	
	@PostMapping("/member/edit.do")
	public String edit(HttpSession sess, Model model, HttpServletRequest request) {
		
		MemberVO uv = (MemberVO)sess.getAttribute("login");
		model.addAttribute("vo", service.detail(uv));
		return "회원정보 수정페이지";
	}
//	@PostMapping("")
	
//}
	
	//이메일인증
//	@GetMapping("/mailCheck")
//	public String mailChecK(String email) {
//		return mailService.joinEmail(email);
//	}

}
