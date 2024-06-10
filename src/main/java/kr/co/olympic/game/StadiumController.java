package kr.co.olympic.game;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/game/stadium")
public class StadiumController {
	@Autowired
    private StadiumService service;

    @PostMapping("create.do")
    public String createStadium(@RequestBody StadiumVO stadium) {
        return "admin/game/stadium/create";
    }

    @GetMapping("index.do")
    public String listStadium(Model model, StadiumVO vo) {
    	model.addAttribute("map", service.listStadium(vo));
        return "admin/game/stadium/index";
    }

    @GetMapping("detail.do")
    public String detailStadium(@RequestBody StadiumVO stadium) {
        return "admin/game/stadium/detail";
    }

    @PostMapping("update.do")
    public String updateStadium(@RequestBody StadiumVO stadium) {
        return "admin/game/stadium/detail";
    }

    @PostMapping("delete.do")
    public String deleteStadium(@RequestBody StadiumVO stadium) {
        return "admin/game/stadium/index";
    }
}
