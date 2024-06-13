package kr.co.olympic.game;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/game")
public class GameController {
	@Autowired
	private GameService service;
	
	@GetMapping("index.do")
    public String listStadium(Model model, GameVO vo) {
    	model.addAttribute("map", service.listGame(vo));
        return "game/index";
    }
}
