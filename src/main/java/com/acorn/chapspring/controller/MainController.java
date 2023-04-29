package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.StoreFilterDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.service.MainService;
import com.acorn.chapspring.service.StoreService;
import com.github.pagehelper.PageInfo;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
@RequestMapping("/")
public class MainController {
    private MainService mainService;


    @GetMapping("/searchStore.do")
    public String searchStoreFrom(
            @RequestParam("siAddress") String siAdd,
            @RequestParam("guAddress") String guAdd,
            Model model
    ){
        String siAdd2 = null;
        if(siAdd == "general09")
            siAdd2 = "서울";

        StoresDto store = mainService.getStoreByAddressReviews(siAdd2, guAdd);
        if (store != null) {
            model.addAttribute("store", store);
        } else {
            // 가게 정보가 없는 경우, 뷰에 출력할 기본값을 설정합니다.
            model.addAttribute("storeTitle", "맛집을 찾지 못했습니다.");
            model.addAttribute("storeText", "다른 지역을 검색해보세요.");
            model.addAttribute("storeImageUrl", "http://localhost:8080/images/main/볶음밥.jpg");
        }
        return "index"; //렌더할 뷰
    }
//    @PostMapping("/searchStore.do")
//    public String searchBestStore(
//            @RequestParam("siAddress") String siAdd,
//            @RequestParam("guAddress") String guAdd,
//            Model model){
//        StoresDto store = mainService.getStoreByAddressReviews(siAdd, guAdd);
//        if (store != null) {
//            model.addAttribute("store", store);
//        } else {
//            // 가게 정보가 없는 경우, 뷰에 출력할 기본값을 설정합니다.
//            model.addAttribute("storeTitle", "맛집을 찾지 못했습니다.");
//            model.addAttribute("storeText", "다른 지역을 검색해보세요.");
//            model.addAttribute("storeImageUrl", "http://localhost:8080/images/main/볶음밥.jpg");
//        }
//        return "forward:/";
//    }
}