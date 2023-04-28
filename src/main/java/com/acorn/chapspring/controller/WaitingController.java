package com.acorn.chapspring.controller;
import com.acorn.chapspring.dto.*;
import com.acorn.chapspring.service.StoreService;
import com.acorn.chapspring.service.StoresWaitingService;
import com.acorn.chapspring.service.WaitingService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/waiting")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])

public class WaitingController {

    private WaitingService waitingService;
    private StoreService storeService;
    private StoresWaitingService storesWaitingService;

    // 대기 중인 팀 조회 API
    @GetMapping("/waiting/{storeNum}/waitingStatus.do")
    public List<WaitingDto> getWaitingList(Model model,
                                           @SessionAttribute UserDto loginUser,
                                           @PathVariable int storeNum) {
        StoresDto stores=storeService.getStoreByStoreNum(storeNum);
        return "waiting/waitingStatus";
    }

//    // 대기 중인 팀 중 가장 빠른 팀 조회 API
//    @GetMapping("/waiting/{storeNum}/waitingStatus.do")
//    public WaitingDto getFastWaiting(@PathVariable int storeNum, @PathVariable int waitNum) {
//        return waitingService.getFastWaiting(storeNum, waitNum);
//    }

    // 대기 등록 API
//    @PostMapping("/waiting/add")
//    public int addWaiting(@RequestBody WaitingDto waitingDto) {
//
//        return waitingService.addWaiting(waitingDto);
//    }
    @GetMapping("/{storeNum}/waitingStatus.do")
    public String waitingStatus(Model model,
                                @SessionAttribute UserDto loginUser,
                                @PathVariable int storeNum){
        StoresDto stores = storeService.getStoreByStoreNum(storeNum);
//        WaitingDto waiting=waitingService.getFastWaiting(storeNum);
        return "waiting/waitingStatus";
    }
    @GetMapping("/{storeNum}/waitingAdd.do")
    public String addWaiting(Model model,
                           @PathVariable int storeNum,
                           @SessionAttribute UserDto loginUser) {
        System.out.println("test");
        StoresDto stores = storeService.getStoreByStoreNum(storeNum);
        StoresWaitingDto storeswaiting = storesWaitingService.getStoreWaitingByStoreNum(storeNum);

        model.addAttribute("stores",stores); // stores. 이걸 쓸 수 있는건 이걸 써줘서야
        model.addAttribute("storeswaiting",storeswaiting);
        return "waiting/waitingAdd";
    }
    // 이게 동환이가 건들여서 된 결과물 =>
    @PostMapping("/waitingAdd.do")
    public String addWaiting(@SessionAttribute UserDto loginUser,
                             @PathVariable int storeNum,
                             @RequestBody UsersWaitingDto userswaiting) {
        String redirectPath="redirect:/waiting/"+storeNum+"waitingAdd.do";
        int register=0;
        try{
            register=waitingService.addWaiting(userswaiting);
        }catch (Exception e){
            log.error(e.getMessage());
        }
        if(register>0){// 웨이팅 등록 성공
            redirectPath="redirect:/waiting/"+storeNum+"/waitingStatus.do";
        }
        return redirectPath;
    }
//    이거 한번 ㅅ ㅣ험해봐야함

//    @GetMapping("/{storeNum}/register.do")
//    public String registerForm(Model model,
//                               @PathVariable int storeNum,
//                               @SessionAttribute UserDto loginUser){
//        StoresDto stores = storeService.getStoreByStoreNum(storeNum);
//        model.addAttribute("stores",stores);
//        return "review/register";
//    }
    

    // 대기 수정 API
    @PutMapping("/waiting/waitingModify/{waitNum}/{userPeople}")
    public int modifyWaiting(
            @RequestBody WaitingDto waitingDto) {
        return waitingService.modifyWaiting(waitingDto);
    }

    // 대기 삭제 API
    @DeleteMapping("/{waitNum}/{waitingNum}")
    public int deleteWaiting(@PathVariable int waitNum, @PathVariable int waitingNum) {
        return waitingService.deleteWaiting(waitNum, waitingNum);
    }
}
