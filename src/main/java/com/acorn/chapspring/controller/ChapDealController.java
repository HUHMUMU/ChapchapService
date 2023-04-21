package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ChapDealDto;
import com.acorn.chapspring.service.ChapDealService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/chapdeal")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
public class ChapDealController {
    private ChapDealService chapDealService;
    @GetMapping("/list.do")
    public String list(Model model) {
        List<ChapDealDto> chapDeals=chapDealService.list();
        model.addAttribute("chapDeals",chapDeals);
        // list.do에 대한 로직 구현
        return "chapdeal/list"; // 해당 경로에 대한 뷰 이름 반환
    }

}
