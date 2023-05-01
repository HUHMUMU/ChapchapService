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
@RequestMapping("/")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
public class MainController {
    private MainService mainService;


    @GetMapping("/findStore.do")
    public String findStoreFrom(
            @RequestParam("findStore") String findStore,
            @RequestParam("searchValue") String searchValue,
            Model model
    ) {
        List<StoresDto> stores
        if (findStore.equals("storeAddress"))
        List<StoresDto> stores = mainService.getStoreByAddress(searchValue);
        else if () {

        }


        model.addAttribute("findStore", findStore);
            model.addAttribute("searchValue", searchValue);

        return "store/list"; //렌더할 뷰
    }


    @GetMapping("/searchStore.do")
    public String searchStoreFrom(
            @RequestParam("siAddress1") String siAdd,
            @RequestParam("guAddress1") String guAdd,
            Model model
    ) {

        StoresDto store = mainService.getStoreByStoreReviews(getSiAdd2(siAdd), guAdd);
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

    @GetMapping("/searchCafe.do")
    public String searchCafeFrom(
            @RequestParam("siAddress2") String siAdd,
            @RequestParam("guAddress2") String guAdd,
            Model model
    ) {

        StoresDto cafe = mainService.getStoreByCafeReviews(getSiAdd2(siAdd), guAdd);
        if (cafe != null) {
            model.addAttribute("cafe", cafe);
        } else {
            // 가게 정보가 없는 경우, 뷰에 출력할 기본값을 설정합니다.
            model.addAttribute("cafeTitle", "카페를 찾지 못했습니다.");
            model.addAttribute("cafeText", "다른 지역을 검색해보세요.");
            model.addAttribute("cafeImageUrl", "http://localhost:8080/images/main/볶음밥.jpg");
        }
        return "index"; //렌더할 뷰
    }

    @GetMapping("/searchPub.do")
    public String searchPubFrom(
            @RequestParam("siAddress3") String siAdd,
            @RequestParam("guAddress3") String guAdd,
            Model model
    ) {

        StoresDto pub = mainService.getStoreByPubReviews(getSiAdd2(siAdd), guAdd);
        if (pub != null) {
            model.addAttribute("pub", pub);
        } else {
            // 가게 정보가 없는 경우, 뷰에 출력할 기본값을 설정합니다.
            model.addAttribute("pubTitle", "술집을 찾지 못했습니다.");
            model.addAttribute("pubText", "다른 지역을 검색해보세요.");
            model.addAttribute("pubImageUrl", "http://localhost:8080/images/main/볶음밥.jpg");
        }
        return "index"; //렌더할 뷰
    }

    private String getSiAdd2(String siAdd) {
        switch (siAdd) {
            case "general01":
                return "강원";
            case "general02":
                return "경기";
            case "general03":
                return "경남";
            case "general04":
                return "경북";
            case "general05":
                return "광주";
            case "general06":
                return "대구";
            case "general07":
                return "대전";
            case "general08":
                return "부산";
            case "general09":
                return "서울";
            case "general10":
                return "울산";
            case "general11":
                return "인천";
            case "general12":
                return "전남";
            case "general13":
                return "전북";
            case "general14":
                return "제주";
            case "general15":
                return "충남";
            case "general16":
                return "충북";
            default:
                throw new IllegalArgumentException("Invalid siAdd: " + siAdd);
        }
    }
}