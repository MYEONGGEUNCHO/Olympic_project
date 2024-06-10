package kr.co.olympic.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


//@RestController
@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	
	@GetMapping("/member/login.do")
	public String login() {
		return "member/login";
	}
	//@ResponseBody
	@PostMapping("/member/login.do")
	public String login(Model model, @ModelAttribute MemberVO vo, HttpSession sess) {
		MemberVO login = service.login(vo);
		if (login == null) {
			model.addAttribute("msg", "이메일 비밀번호를 확인하세요.");
			model.addAttribute("url", "/olympic/member/login.do");
			return "/common/alert";
		} else {
			sess.setAttribute("login", login);
			return "/home";
		}
	}
	
	@GetMapping("/member/logout.do")
	public String logout(HttpSession sess, Model model) {
		sess.invalidate();
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "/olympic/member/login.do");
		return "/common/alert";
	}
	
	//나중에 지울 예정
	@GetMapping("/member/pwdcheck.do")
	public String complete() {
		return "member/pwdcheck";
	}
	
	//@ResponseBody
	@PostMapping("/member/regist.do")
	public String regist(Model model, @ModelAttribute MemberVO vo) {
		int regist = service.regist(vo);
		if(regist > 0 ) {
			return "/member/complete";
		}
		else{
			model.addAttribute("error", "회원가입에 실패했습니다.");
			return "member/regist";
		}
	}
	
	@GetMapping("/member/regist.do")
	public String regist() {
		return "member/regist";
	}
	//이메일 중복체크
	@ResponseBody
	@GetMapping("/member/emailCheck.do")
	public int emailCheck(@RequestParam String email) {
		return service.emailCheck(email);
	}
	
	//@ResponseBody
	@PostMapping("/member/update.do")
	public String update(@ModelAttribute MemberVO vo, Model model, HttpSession sess) {
		MemberVO uv = (MemberVO)sess.getAttribute("login");
		int r = service.update(vo);
		String msg = "";
		String url = "/olympic/member/edit.do";
		
		if (r > 0) {
			uv.setName(vo.getName());
	        uv.setPhone(vo.getPhone());
	        uv.setPwd(vo.getPwd());
	        sess.setAttribute("login", uv);
			msg = "정상적으로 수정되었습니다.";
		} else {
			msg = "수정 오류";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		return "/common/alert";
	}
	
	@GetMapping("/member/membership.do")
	public String membership(HttpSession sess, Model model) {
		return "member/membership";
	}
	
	@GetMapping("/member/edit.do")
	public String edit(HttpSession sess, Model model) {
		MemberVO uv = (MemberVO)sess.getAttribute("login");
		model.addAttribute("vo", service.detail(uv));
		return "member/mypage";
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
	@GetMapping("/member/purchase.do")
	public String buyMembership(HttpSession sess, Model model) {
		MemberVO mv = (MemberVO)sess.getAttribute("login");
		int r = service.buy_membership(mv);
		
		String msg = "";
		String url= "/olympic/member/membership.do";
		model.addAttribute("url", url);
		if(r > 0) { //삭제한 행의 개수 반환
			msg = "구매가 완료되었습니다.";
			
			mv.setMembership("VIP");
			mv.setPoint(mv.getPoint()-10000);
			
			sess.setAttribute("login", mv);
			model.addAttribute("msg", msg);
//			model.addAttribute("url", url);
			
			return "/common/alert";
		}
		else {
			msg = "구매 오류. 다시 시도해 주세요";
			model.addAttribute("msg", msg);
			return "/common/alert";
		}
	}
	
	@GetMapping("/member/coupon.do")
	public String couponList(HttpSession sess, Model model) {
		MemberVO mv = (MemberVO)sess.getAttribute("login");
		model.addAttribute("vo", service.coupon_list(mv));
		return "쿠폰 리스트 페이지";
	}
	
	
	@PostMapping("/member/pwdCheck.do")
	public String pwdCheck(HttpSession sess, MemberVO vo, Model model) {
		//MemberVO mv = (MemberVO)sess.getAttribute("login");
		int r = service.pwdCheck(vo);
		if(r > 0) {
			return "redirect: /olympic/member/edit.do";
		}
		else {
			String msg = "비밀번호가 일치하지 않습니다.";
			String url= "/olympic/member/pwdcheck.do";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/common/alert";
		}
	}
	
	//TODO 이름, 이메일 유효성 검사 -> 비밀번호 초기화로 넘어가는 단계 다시 확인
	//어떻게 MemberVO를 파라미터로 보내고 받을 것이냐 생각
	//@ResponseBody
	@PostMapping("/member/checkEmail.do")
	public String checkEmail(@ModelAttribute MemberVO vo, RedirectAttributes redirect, Model model) {
		MemberVO email = service.checkEmail(vo);
		System.out.println(email);
		
		if (email == null) {
			System.out.println("이메일 확인 필요");
			String msg = "유효하지 않은 이름 또는 이메일 입니다.";
			String url= "/olympic/member/find.do";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/common/alert";
		} else {
//			model.addAttribute("checkEmail", email);
			redirect.addFlashAttribute("checkEmail", email);
			return "redirect:/member/findPwd.do";
//			return "It is correct!";
		}
	}
	
	@GetMapping("/member/find.do")
	public String find() {
		return "member/findpwd";
	}
	
	//@ResponseBody
	@RequestMapping("/member/findPwd.do")
	public String findPwd(@ModelAttribute("checkEmail") MemberVO vo, Model model) {
		System.out.println(vo);
		int r = service.findPwd(vo);
		System.out.println(r);
		if(r > 0) {
			model.addAttribute("reset", true);
	        return "/member/findpwd";
//			return "생년월일로 비밀번호 초기화 모달";
			//return "/member/resetpwd";
		}
		else {
			
			String msg = "다시 시도해 주세요.";
			String url= "/olympic/member/find.do";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/common/alert";
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