package kr.co.olympic.game;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.olympic.member.MemberVO;

@Controller
@RequestMapping("/admin/game/item")
public class AdminItemController {
	@Autowired
	private ItemService service;
	
	@GetMapping("write.do")
	public String write() {
		return "admin/game/item/write";
	}

    @PostMapping("create.do")
    public String createItem(Model model, HttpServletRequest request, ItemVO vo) {
    	HttpSession sess = request.getSession();
    	MemberVO login = (MemberVO)sess.getAttribute("login");
    	int r = service.createItem(vo);
    	if (r > 0) {
    		model.addAttribute("cmd", "move");
    		model.addAttribute("msg", "정상적으로 저장되었습니다.");
    		model.addAttribute("url", "/olympic/admin/game/item/index.do");
    	} else {
    		model.addAttribute("cmd", "back");
    		model.addAttribute("msg", "등록 오류");
    	}
        return "common/alert";
    }

    @GetMapping("index.do")
    public String listItem(Model model, ItemVO vo) {
    	model.addAttribute("map", service.listItem(vo));
        return "/admin/game/item/index";
    }

    @GetMapping("detail.do")
    public String detailItem(@RequestBody ItemVO vo) {
        return "/admin/game/item/detail";
    }

    @PostMapping("update.do")
    public String updateItem(@RequestBody ItemVO vo) {
        return "/admin/game/item/detail";
    }

    @PostMapping("delete.do")
    public String deleteItem(@RequestBody ItemVO vo) {
        return "/admin/game/item/index";
    }
}
