package kr.co.olympic.game;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/game")
public class AdminGameController {
	@Autowired
	private GameService service;
	
	@GetMapping("write.do")
	public String write() {
		return "admin/game/write";
	}
	
	@PostMapping("create.do")
	public String createGame(Model model, HttpServletRequest request, GameVO vo) {
		HttpSession sess = request.getSession();
		int r = service.createGame(vo);
		if (r > 0) {
    		model.addAttribute("cmd", "move");
    		model.addAttribute("msg", "정상적으로 저장되었습니다.");
    		model.addAttribute("url", "/olympic/admin/game/index.do");
    	} else {
    		model.addAttribute("cmd", "back");
    		model.addAttribute("msg", "등록 오류");
    	}
    	return "common/alert";
	}
	@GetMapping("index.do")
    public String listStadium(Model model, GameVO vo) {
    	model.addAttribute("map", service.listGame(vo));
        return "admin/game/index";
    }

    @GetMapping("detail.do")
    public String detailGame(@RequestBody StadiumVO vo) {
        return "admin/game/detail";
    }

    @PostMapping("update.do")
    @ResponseBody
    public int updateGame(@ModelAttribute GameVO vo) {
    	return service.updateGame(vo);
//    	return r;
//    	if (r > 0) {
//    		model.addAttribute("cmd", "move");
//    		model.addAttribute("msg", "정상적으로 수정되었습니다.");
//    		model.addAttribute("url", "/olympic/admin/game/stadium/index.do");
//    	} else {
//    		model.addAttribute("cmd", "back");
//    		model.addAttribute("msg", "등록 오류");
//    	}
//        return "common/alert";
    }

    @ResponseBody
    @PostMapping("delete.do")
    public int deleteGame(GameVO vo) {
    	return service.deleteGame(vo);
    	
    }
}
