package kr.co.olympic.game;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/game/sport")
public class SportController {
	@Autowired
	private SportService service;

    @PostMapping("create.do")
    public String createSport(@RequestBody SportVO sport) {
        return "/admin/game/sport/create";
    }

    @GetMapping("index.do")
    public String listSport(Model model, SportVO vo) {
    	model.addAttribute("map", service.listSport(vo));
        return "/admin/game/sport/index";
    }

    @GetMapping("detail.do")
    public String detailSport(@RequestBody SportVO sport) {
        return "/admin/game/item/detail";
    }

    @PostMapping("update.do")
    public String updateSport(@RequestBody SportVO sport) {
        return "/admin/game/sport/detail";
    }

    @PostMapping("delete.do")
    public String deleteSport(@RequestBody SportVO sport) {
        return "/admin/game/sport/index";
    }
}
