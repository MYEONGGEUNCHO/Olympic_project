package kr.co.olympic.admin;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.olympic.member.CouponVO;
import kr.co.olympic.member.MemberService;
import kr.co.olympic.member.MemberVO;
import kr.co.olympic.qna.QnaSearchDTO;
import kr.co.olympic.qna.QnaService;
import kr.co.olympic.qna.QnaVO;

@Controller
public class AdminController {

	@Autowired
	private AdminService service;
	@Autowired
	private MemberService memservice;
	@Autowired
	private QnaService qnaservice;
	
	@GetMapping("/admin/login.do")
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
			return "redirect: /olympic/admin/index.do";
		}
	}
	
	@GetMapping("/admin/index.do")
	public String index(Model model, HttpSession session) {
		List<MemberVO> memberList = service.memberList();
		 // 날짜 포맷 변경
        SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
        for (MemberVO member : memberList) {
            String formattedDate = newFormat.format(member.getCredate());
            member.setFormattedCredate(formattedDate);
        }
		model.addAttribute("memberList", memberList);
		return "admin/member/index";
	}
	
	@PostMapping("/admin/updateMember.do")
	public String updateMember(MemberVO vo, Model model) {
		int r = service.updateMember(vo);
		if(r>0) {
			return "redirect: /olympic/admin/index.do";
		}
		else {
			model.addAttribute("msg","수정오류");
			model.addAttribute("url","/olympic/admin/index.do");
			return "/common/alert";
		}
		
	}
	@PostMapping("/admin/resetPwd.do")
	public ResponseEntity<Integer> resetPwd(MemberVO vo) {
		int r = service.resetMember(vo);
		return ResponseEntity.ok(r);
	}
	
	@GetMapping("/admin/issueCoupon.do")
	public String issueCoupon(CouponVO vo, Model model) {
		vo.setCoupon_no(memservice.createKey());
		int r = service.couponAdmin(vo);
		model.addAttribute("url","/olympic/admin/index.do");
		if(r>0) {
			model.addAttribute("msg","쿠폰이 지급되었습니다.");
			return "/common/alert";
		}
		else {
			model.addAttribute("msg","수정오류");
			return "/common/alert";
		}
	}
	
	@GetMapping("/admin/detail.do")
	public String detailMember(@RequestParam("member_no") String memberNo, Model model) {
		MemberVO detail = service.detailMember(memberNo);
		QnaSearchDTO dto = new QnaSearchDTO();
		dto.setMember_no(memberNo);
		model.addAttribute("detail", detail);
		List<QnaVO> qna = qnaservice.list(dto);
		model.addAttribute("qna", qna);
		return "/admin/member/detail";
	}
}
