package com.acorn.chapspring.controller;
import com.acorn.chapspring.dto.WaitingDto;
import com.acorn.chapspring.service.StoreService;
import com.acorn.chapspring.service.WaitingService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/waiting")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])

public class WaitingController {

    private WaitingService waitingService;

    // 대기 중인 팀 조회 API
    @GetMapping("/stores/waiting/{waitNum}/{storeNum}")
    public List<WaitingDto> getWaitingList(@PathVariable int waitNum, @PathVariable int storeNum) {
        return waitingService.getWaitingList(waitNum, storeNum);
    }

    // 대기 중인 팀 중 가장 빠른 팀 조회 API
    @GetMapping("/waiting/status/fast/{storeNum}/{waitNum}")
    public WaitingDto getFastWaiting(@PathVariable int storeNum, @PathVariable int waitNum) {
        return waitingService.getFastWaiting(storeNum, waitNum);
    }

    // 대기 등록 API
//    @PostMapping("/waiting/add")
//    public int addWaiting(@RequestBody WaitingDto waitingDto) {
//
//        return waitingService.addWaiting(waitingDto);
//    }
    @PostMapping("/waiting/add")
    public ModelAndView addWaiting(@RequestBody WaitingDto waitingDto) {
        int result = waitingService.addWaiting(waitingDto);
        ModelAndView modelAndView = new ModelAndView();
        if(result > 0) {
            modelAndView.setViewName("redirect:/waiting/waitingStatus");
        } else {
            modelAndView.setViewName("redirect:/error");
        }
        return modelAndView;
    }
//    이거 한번 ㅅ ㅣ험해봐야함
    

    // 대기 수정 API
    @PutMapping("/waiting/waitingModify/{waitNum}/{userPeople}")
    public int modifyWaiting(@RequestBody WaitingDto waitingDto) {
        return waitingService.modifyWaiting(waitingDto);
    }

    // 대기 삭제 API
    @DeleteMapping("/{waitNum}/{waitingNum}")
    public int deleteWaiting(@PathVariable int waitNum, @PathVariable int waitingNum) {
        return waitingService.deleteWaiting(waitNum, waitingNum);
    }
}
