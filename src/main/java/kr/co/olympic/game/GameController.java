package kr.co.olympic.game;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.olympic.member.MemberVO;

@Controller
@RequestMapping("/game")
public class GameController {
	@Autowired
	private GameService gameService;
	
	@Value("${google_api_key}")
	private String apikey;

	@GetMapping("index.do")
	public String searchGame(Model model, HttpSession session, GameVO game) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		Map<String, Object> map = new HashMap<>();
		map.put("member", member);
		map.put("game", game);
		model.addAttribute("member", member);
		model.addAttribute("map", gameService.searchGame(map));
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
        model.addAttribute("member", member);
        model.addAttribute("game", gameService.detailGame(map));
        model.addAttribute("apikey", apikey);
		return "game/detail";
	}
	
	@PostMapping("createFavorite.do")
	@ResponseBody
	public int createFavorite(Model model, HttpSession session, GameVO game) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member.getMember_no());
		map.put("game_id", game.getGame_id());
		return gameService.createFavorite(map);
	}
	
	@PostMapping("deleteFavorite.do")
	@ResponseBody
	public int deleteFavorite(Model model, HttpSession session, GameVO game) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member.getMember_no());
		map.put("game_id", game.getGame_id());
		return gameService.deleteFavorite(map);
	}
	
	@PostMapping("createComment.do")
	@ResponseBody
	public int createComment(Model model, HttpSession session, CommentVO comment
		) {
		MemberVO member = (MemberVO) session.getAttribute("login");
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member.getMember_no());
        map.put("game_id", comment.getGame_id());
        map.put("content", comment.getContent());
        map.put("regdate", new Timestamp(System.currentTimeMillis()));
		return gameService.createComment(map);
	}
	
	@GetMapping("listComment.do")
	@ResponseBody
	public List<CommentVO> listComment(Model model, HttpSession session, GameVO game) {
		return gameService.listComment(game);
	}
}
