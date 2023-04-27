package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.service.MainService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
public class MainController {
    private MainService mainService;

    @GetMapping("/searchStore.do")
    public String searchStoreFrom(){
        return "/"; //렌더할 뷰
    }
    @PostMapping("/searchStore.do")
    public String searchBestStore(
            @RequestParam("siAddress") String siAdd,
            @RequestParam("guAddress") String guAdd,
            Model model){
        StoresDto store = mainService.getStoreByAddressReviews(siAdd, guAdd);
        model.addAttribute("store",store);
        return "redirect:/";
    }
}