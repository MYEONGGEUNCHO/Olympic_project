package kr.co.olympic.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.olympic.member.MemberVO;

@Controller
public class AdminController {

	@Autowired
	private AdminService service;
	
	@GetMapping("/admin/index.do")
	public String adlogin() {
		return "/admin/login";
	}
	
	@PostMapping("/admin/login.do")
	public String loginAdmin(Model model, @ModelAttribute MemberVO vo, HttpSession sess) {
		MemberVO login = service.loginAdmin(vo);
		if (login == null) {
			model.addAttribute("msg", "이메일 비밀번호를 확인하세요.");
			model.addAttribute("url", "/olympic/admin/login.do");
			return "/common/alert";
		} else {
			sess.setAttribute("login", login);
			return "/admin/member/index";
		}
	}
}
