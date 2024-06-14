package kr.co.olympic.game;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/game")
public class GameController {
	@Autowired
	private GameService gameService;

	@GetMapping("index.do")
	public String listGame(Model model, GameVO vo) {
		model.addAttribute("map", gameService.listGame(vo));
		return "game/index";
	}

	@GetMapping("detail.do")
	public String detailGame(Model model, HttpSession session, GameVO game) {
		// detail페이지에서 필요한 game, stadium, sport, item 테이블 정보 받아오기
		model.addAttribute("game", gameService.detailGame(game));
		// qna, comment는 ajax로 받아오기
		return "game/detail";
	}
}
