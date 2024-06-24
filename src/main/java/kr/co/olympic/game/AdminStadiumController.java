package kr.co.olympic.game;

import java.util.HashMap;
import java.util.Map;

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
@RequestMapping("/admin/game/stadium")
public class AdminStadiumController {
	@Autowired
    private StadiumService service;
	
	@GetMapping("write.do")
	public String write() {
		return "admin/game/stadium/write";
	}

    @PostMapping("create.do")
    public String createStadium(Model model, HttpServletRequest request, StadiumVO vo) {
    	HttpSession sess = request.getSession();
    	int r = service.createStadium(vo);
    	if (r > 0) {
    		model.addAttribute("cmd", "move");
    		model.addAttribute("msg", "정상적으로 저장되었습니다.");
    		model.addAttribute("url", "/olympic/admin/game/stadium/index.do");
    	} else {
    		model.addAttribute("cmd", "back");
    		model.addAttribute("msg", "등록 오류");
    	}
        return "common/alert";
    }

    @GetMapping("index.do")
    public String listStadium(Model model, StadiumVO vo) {
    	model.addAttribute("map", service.listStadium(vo));
        return "admin/game/stadium/index";
    }
    @ResponseBody
    @PostMapping("update.do")
    public int updateStadium(@ModelAttribute StadiumVO vo) {
    	return service.updateStadium(vo);
    }

    @PostMapping("delete.do")
    public String deleteStadium(Model model, StadiumVO vo) {
    	int r = service.deleteStadium(vo);
    	if (r > 0) {
    		model.addAttribute("cmd", "move");
    		model.addAttribute("msg", "정상적으로 삭제되었습니다.");
    		model.addAttribute("url", "/olympic/admin/game/stadium/index.do");
    	} else {
    		model.addAttribute("cmd", "back");
    		model.addAttribute("msg", "삭제 오류");
    	}
        return "common/alert";
    }
}
