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

import kr.co.olympic.member.MemberVO;

@Controller
@RequestMapping("/admin/game/sport")
public class AdminSportController {
	@Autowired
	private SportService service;
	
	@GetMapping("write.do")
	public String write() {
		return "admin/game/sport/write";
	}

    @PostMapping("create.do")
    public String createSport(Model model, HttpServletRequest request, SportVO vo) {
    	HttpSession sess = request.getSession();
    	int r = service.createSport(vo);
    	if (r > 0) {
    		model.addAttribute("cmd", "move");
    		model.addAttribute("msg", "정상적으로 저장되었습니다.");
    		model.addAttribute("url", "/olympic/admin/game/sport/index.do");
    	} else {
    		model.addAttribute("cmd", "back");
    		model.addAttribute("msg", "등록 오류");
    	}
    	return "common/alert";
    }

    @GetMapping("index.do")
    public String listSport(Model model, SportVO vo) {
    	model.addAttribute("map", service.listSport(vo));
    	return "admin/game/sport/index";
    }

    @GetMapping("detail.do")
    public String detailSport(@RequestBody SportVO vo) {
        return "/admin/game/item/detail";
    }
    
    @ResponseBody
    @PostMapping("update.do")
    public int updateSport(@ModelAttribute SportVO vo) {
    	return service.updateSport(vo);
    }

    @ResponseBody
    @PostMapping("delete.do")
    public int deleteSport(SportVO vo) {
    	return service.deleteSport(vo);
    }
}
