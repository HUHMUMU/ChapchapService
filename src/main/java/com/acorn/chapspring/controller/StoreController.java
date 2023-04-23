package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.service.StoreService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/store")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
public class StoreController {
    private StoreService storeService;
    @GetMapping("/{storeNum}/detail.do")
    public String detail(Model model,
                        @PathVariable int storeNum) {
        StoresDto stores=storeService.getStoreByStoreNum(storeNum);
        model.addAttribute("stores",stores);
        return "store/detail"; // 해당 경로에 대한 뷰 이름 반환
    }

    @GetMapping("/list.do")
    public String list() {
        return "store/list"; // 해당 경로에 대한 뷰 이름 반환
    }
}
