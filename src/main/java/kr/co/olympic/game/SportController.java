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
@RequestMapping("/sport")
public class SportController {
	
	@Autowired
    SportService sportService;

    @PostMapping("/create")
    public int createSport(@RequestBody SportVO sport) {
        return sportService.createSport(sport);
    }

    @GetMapping("/list")
    public List<SportVO> listSport() {
        return sportService.listSport();
    }

    @PostMapping("/detail")
    public SportVO detailSport(@RequestBody SportVO sport) {
        return sportService.detailSport(sport);
    }

    @PutMapping("/update")
    public int updateSport(@RequestBody SportVO sport) {
        return sportService.updateSport(sport);
    }

    @DeleteMapping("/delete")
    public int deleteSport(@RequestBody SportVO sport) {
        return sportService.deleteSport(sport);
    }
}
