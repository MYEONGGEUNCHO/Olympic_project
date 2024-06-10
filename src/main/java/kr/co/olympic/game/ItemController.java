package kr.co.olympic.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/game/item")
public class ItemController {
	@Autowired
	private ItemService service;

    @PostMapping("create.do")
    public String createItem(@RequestBody ItemVO item) {
        return "/admin/game/item/create";
    }

    @GetMapping("index.do")
    public String listItem() {
        return "/admin/game/item/index";
    }

    @GetMapping("detail.do")
    public String detailItem(@RequestBody ItemVO item) {
        return "/admin/game/item/detail";
    }

    @PostMapping("update.do")
    public String updateItem(@RequestBody ItemVO item) {
        return "/admin/game/item/detail";
    }

    @PostMapping("delete.do")
    public String deleteItem(@RequestBody ItemVO item) {
        return "/admin/game/item/index";
    }
}
