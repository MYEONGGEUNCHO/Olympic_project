package kr.co.olympic.game;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.olympic.member.MemberVO;
import kr.co.olympic.order.PaymentVO;
import kr.co.olympic.qna.QnaVO;

@Controller
@RequestMapping("/game")
public class GameController {
	@Autowired
	private GameService service;
	
	@GetMapping("index.do")
    public String listGame(Model model, GameVO vo) {
    	model.addAttribute("map", service.listGame(vo));
        return "game/index";
    }
	
	@GetMapping("detail.do")
    public String detailGame(
    		Model model
    		, GameVO game
    		, StadiumVO stadium
    		, SportVO sport
    		, ItemVO item
    		, MemberVO member
    		, CommentVO comment
    		, QnaVO qna
    		, PaymentVO payment) {
		model.addAttribute("map", service.detailGame(game));
        return "game/detail";
    }
}
