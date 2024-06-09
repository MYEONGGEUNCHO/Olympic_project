package kr.co.olympic.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/item")
public class ItemController {
	
	@Autowired
    ItemService itemService;

    @PostMapping("/create")
    public int createItem(@RequestBody ItemVO item) {
        return itemService.createItem(item);
    }

    @GetMapping("/list")
    public List<ItemVO> listItem() {
        return itemService.listItem();
    }

    @PostMapping("/detail")
    public ItemVO detailItem(@RequestBody ItemVO item) {
        return itemService.detailItem(item);
    }

    @PutMapping("/update")
    public int updateItem(@RequestBody ItemVO item) {
        return itemService.updateItem(item);
    }

    @DeleteMapping("/delete")
    public int deleteItem(@RequestBody ItemVO item) {
        return itemService.deleteItem(item);
    }
}
