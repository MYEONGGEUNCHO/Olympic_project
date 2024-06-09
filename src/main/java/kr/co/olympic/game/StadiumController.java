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
@RequestMapping("/stadium")
public class StadiumController {
	
	@Autowired
    StadiumService stadiumService;

    @PostMapping("/create")
    public int createStadium(@RequestBody StadiumVO stadium) {
        return stadiumService.createStadium(stadium);
    }

    @GetMapping("/list")
    public List<StadiumVO> listStadium() {
        return stadiumService.listStadium();
    }

    @PostMapping("/detail")
    public StadiumVO detailStadium(@RequestBody StadiumVO stadium) {
        return stadiumService.detailStadium(stadium);
    }

    @PutMapping("/update")
    public int updateStadium(@RequestBody StadiumVO stadium) {
        return stadiumService.updateStadium(stadium);
    }

    @DeleteMapping("/delete")
    public int deleteStadium(@RequestBody StadiumVO stadium) {
        return stadiumService.deleteStadium(stadium);
    }
}
