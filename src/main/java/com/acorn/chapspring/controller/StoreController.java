package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.*;
import com.acorn.chapspring.service.ReportService;
import com.acorn.chapspring.service.ReviewService;
import com.acorn.chapspring.service.StoreService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/store")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
public class StoreController {
    private StoreService storeService;
    private ReviewService reviewService;
    private ReportService reportService;

    @GetMapping("/{storeNum}/detail.do")
    public String detail(Model model,
                        @SessionAttribute UserDto loginUser,
                        @PathVariable int storeNum) {
        StoresDto stores=storeService.getStoreByStoreNum(storeNum);
        model.addAttribute("stores",stores);
        return "store/detail"; // 해당 경로에 대한 뷰 이름 반환
    }
    @PostMapping("/detail.do")
    public String registerReport(@SessionAttribute UserDto loginUser,
                                 @PathVariable int storeNum,
                                 @RequestBody ReportsDto reports) {
        String redirectPath="redirect:/store/"+storeNum+"/detail.do";
        int register=0;
        try{
            register=reportService.registerReportByReview(reports);
        }catch (Exception e){
            log.error(e.getMessage());
        }
        if(register>0) {// 신고 성공
            redirectPath="redirect:/store/"+storeNum+"/detail.do";
        }
        return redirectPath;
    }


    @GetMapping("/list.do")
    public String list(
            Model model,
           @ModelAttribute StoreFilterDto storeFilterDto) {
        PageInfo<StoresDto> pageInfo = storeService.getFilteredStores(storeFilterDto);

        model.addAttribute("page", pageInfo);
        // 수업자료의 page에 해당
        model.addAttribute("filter", storeFilterDto);
        // 수업자료의 boards에 해당
        return "store/list";
    }
}
