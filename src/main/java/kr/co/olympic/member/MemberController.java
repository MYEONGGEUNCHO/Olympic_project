package kr.co.olympic.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
//@RestController
public class MemberController {
	@Autowired
	private MemberService service;
	
	
	@GetMapping("/member/login.do")
	public void login() {
		
	}
	//@ResponseBody
	@PostMapping("/member/login.do")
	public String login(Model model, @RequestBody MemberVO vo, HttpSession sess) {
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
	@GetMapping("/member/logout.do")
	public String logout(HttpSession sess, Model model) {
		sess.invalidate();
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "/index.do");
		return "common/alert";
	}
	
	//@ResponseBody
	@PostMapping("/member/regist.do")
	public String regist(Model model,@RequestBody MemberVO vo) {
		int regist = service.regist(vo);
		if(regist > 0 ) {
			return "/member/회원가입 완료 페이지";
		}
		else{
			return "alert 창 띄우기";
		}
	}
	@ResponseBody
	@GetMapping("/member/emailCheck.do")
	public int emailCheck(@RequestParam String email) {
		return service.emailCheck(email);
	}
	
	//@ResponseBody
	@PostMapping("/member/update.do")
	public String update(@RequestBody MemberVO vo, Model model) {
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
	
	@GetMapping("/member/edit.do")
	public String edit(HttpSession sess, Model model) {
		MemberVO uv = (MemberVO)sess.getAttribute("login");
		model.addAttribute("vo", service.detail(uv));
		return "member/index";
	}
	
	@PostMapping("/member/delete.do")
	public String delete(HttpSession sess, Model model) {
		MemberVO mv = (MemberVO)sess.getAttribute("login");
		int r = service.delete(mv);
		String msg = "";
		String url= "";
		if( r > 0) { //삭제한 행의 개수 반환
			msg = "회원탈퇴가 처리되었습니다.";
			url= "메인 페이지";
			
			model.addAttribute("url", url);
			model.addAttribute("msg", msg);
			return "alert창 띄우기";
		}
		else {
			sess.invalidate();
			return "메인페이지로 이동";
		}
	}
	@GetMapping("/member/membership.do")
	public String buyMembership(HttpSession sess, Model model) {
		MemberVO mv = (MemberVO)sess.getAttribute("login");
		int r = service.buy_membership(mv);
		
		String msg = "";
		String url= "마이페이지- 멤버십 페이지";
		model.addAttribute("url", url);
		if(r > 0) { //삭제한 행의 개수 반환
			msg = "구매가 완료되었습니다.";
			
			model.addAttribute("msg", msg);
//			model.addAttribute("url", url);
			
			return "alert창 띄우기";
		}
		else {
			msg = "구매 오류";
			model.addAttribute("msg", msg);
			return "alert창 띄우기";
		}
	}
	
	@GetMapping("/member/coupon.do")
	public String couponList(HttpSession sess, Model model) {
		MemberVO mv = (MemberVO)sess.getAttribute("login");
		model.addAttribute("vo", service.coupon_list(mv));
		return "쿠폰 리스트 페이지";
	}
	
	
	@PostMapping("/member/pwdCheck.do")
	public String pwdCheck(HttpSession sess, String pwd, Model model) {
		MemberVO mv = (MemberVO)sess.getAttribute("login");
		String checkpwd = mv.getPwd();
		//세션값이랑 받은 입력 값 비교
		if(pwd.equals(checkpwd)) {
			return "회원 정보 수정 페이지";
		}
		else {
			String msg = "비밀번호가 일치하지 않습니다.";
			String url= "마이페이지- 멤버십 페이지";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "alert창 띄우기";
		}
	}
	
	//TODO 이름, 이메일 유효성 검사 -> 비밀번호 초기화로 넘어가는 단계 다시 확인
	//어떻게 MemberVO를 파라미터로 보내고 받을 것이냐 생각
	//@ResponseBody
	@PostMapping("/member/checkEmail.do")
	public String checkEmail(@RequestBody MemberVO vo, RedirectAttributes redirect) {
		MemberVO email = service.checkEmail(vo);
		System.out.println(email);
		if (email == null) {
			return "It is incorrect name and email. plz check again";
		} else {
			redirect.addFlashAttribute("checkEmail", email);
			return "redirect:/member/findPwd";
//			return "It is correct!";
		}
	}
	//@ResponseBody
	@GetMapping("/member/findPwd.do")
	public String findPwd(@ModelAttribute("checkEmail") MemberVO vo, Model model) {
		
		int r = service.findPwd(vo);
		System.out.println(r);
		if(r > 0) {
//			return "생년월일로 비밀번호 초기화 페이지";
			return "reset password page";
		}
		else {
			return "alert창";
		}
	}
	

	//이메일인증
	@ResponseBody
	@PostMapping("/member/mailCheck.do")
	public String mailChecK(@RequestParam String email) throws Exception {
		String code = service.sendSimpleMessage(email);
        System.out.println("사용자에게 발송한 인증코드 ==> " + code);

        return code;
	}

}
