package kr.co.olympic.game;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.olympic.member.MemberVO;

@Controller
@RequestMapping("/game")
public class GameController {
	@Autowired
	private GameService gameService;

	@GetMapping("index.do")
	public String listGame(Model model, HttpSession session, GameVO vo) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		model.addAttribute("login", member);
		model.addAttribute("map", gameService.searchGame(vo));
		return "game/index";
	}

	@GetMapping("detail.do")
	public String detailGame(Model model, HttpSession session, GameVO game) {
		// detail페이지에서 필요한 game, stadium, sport, item 테이블 정보 받아오기
		MemberVO member = (MemberVO) session.getAttribute("login");
		Map<String, Object> map = new HashMap<>();
		// qna, comment는 ajax로 받아오기
		map.put("member", member);
        map.put("game", game);
        model.addAttribute("game", gameService.detailGame(map));
		return "game/detail";
	}
	
	@GetMapping("createFavorite.do")
	public void createFavorite(Model model, HttpSession session, GameVO game) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		String member_no = member.getMember_no();
		Map<String, Object> map = new HashMap<>();
		model.addAttribute("game", gameService.createFavorite(map));
	}
	
	@GetMapping("deleteFavorite.do")
	public void deleteFavorite(Model model, HttpSession session, GameVO game) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		String member_no = member.getMember_no();
		Map<String, Object> map = new HashMap<>();
		model.addAttribute("game", gameService.deleteFavorite(map));
	}

}
