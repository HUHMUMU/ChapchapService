package com.acorn.chapspring.controller;
import com.acorn.chapspring.dto.*;
import com.acorn.chapspring.service.StoreService;
import com.acorn.chapspring.service.StoresWaitingService;
import com.acorn.chapspring.service.WaitingService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public List<UsersWaitingDto> getWaitingList(Model model,
                                                @SessionAttribute UserDto loginUser,
                                                @PathVariable int storeNum) {
        StoresDto stores=storeService.getStoreByStoreNum(storeNum);
        return null;
    }

//    // 대기 중인 팀 중 가장 빠른 팀 조회 API
//    @GetMapping("/waiting/{storeNum}/waitingStatus.do")
//    public UsersWaitingDto getFastWaiting(@PathVariable int storeNum, @PathVariable int waitNum) {
//        return waitingService.getFastWaiting(storeNum, waitNum);
//    }

    // 대기 등록 API
//    @PostMapping("/waiting/add")
//    public int addWaiting(@RequestBody UsersWaitingDto waitingDto) {
//
//        return waitingService.addWaiting(waitingDto);
//    }
    @GetMapping("/{storeNum}/waitingStatus.do/{waitNum}")
    public String waitingStatus(Model model,
                                @SessionAttribute UserDto loginUser,
                                @PathVariable int storeNum,
                                @PathVariable int waitNum
                                ){
        StoresWaitingDto storeswaiting = storesWaitingService.getStoreWaitingByStoreNum(storeNum);
        int prevWaitingCount = waitingService.getPrevWaitingCount(storeNum, waitNum);
        UsersWaitingDto waiting = waitingService.getWaitingByWaitNum(storeNum, waitNum);
        int estimatedWaitTime = storeswaiting.getTimeSetup() * prevWaitingCount;

        model.addAttribute("prevWaitingCount", prevWaitingCount);
        model.addAttribute("waiting", waiting);
        model.addAttribute("estimatedWaitTime", estimatedWaitTime);
        model.addAttribute("storeswaiting", storeswaiting);
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
    @PostMapping ("/{storeNum}/waitingAdd.do")
    public String addWaiting(@SessionAttribute UserDto loginUser,
                             @PathVariable int storeNum,
                             @RequestParam int user_people,
                             Model model) {
        int currentWaitingCount = waitingService.getWaitingCount(storeNum);
        int addWaiting = waitingService.addWaiting(currentWaitingCount + 1, loginUser.getUserId(), storeNum, user_people);

        if(addWaiting>0){// 웨이팅 등록 성공
            return "redirect:/waiting/"+storeNum+"/waitingStatus.do/"+ (currentWaitingCount + 1);
        }
        else  {
            return "redirect:/waiting/"+storeNum+"/waitingAdd.do";
        }
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
    
//    @GetMapping()
//    public int
//    // 대기 수정 API
//    @PutMapping("/waiting/{storeNum}/waitingModify.do/")
//    public String modifyWaiting(
//            @RequestBody UsersWaitingDto usersWaitingDto) {
//        int modifyWaiting=waitingService.modifyWaiting();
//        int modify=waitingService.modifyWaiting();
//        if(modify>0){
//            return "redirect:/waiting/{storeNum}/waitingStatus.do/{waitNum}";
//        }
//        return waitingService.modifyWaiting(usersWaitingDto);
//    } // 20:28 삭제 되나?

    // 대기 삭제 API
    @GetMapping("/{waitNum}/remove.do")
    public String removeAction(@PathVariable int waitingNum,
                                @SessionAttribute UserDto loginUser,
                                RedirectAttributes redirectAttributes) {
        String redirectPath="redirect:/waiting/"+waitingNum+"/waitingStatus.do";
        String msg="삭제 실패";
        UsersWaitingDto usersWaitingDto=null;
        int remove=0;
        try{
            usersWaitingDto=waitingService.detail(waitingNum);
            remove=waitingService.remove(waitingNum);
        }catch (Exception e){
            log.error(e);;
        }
        if(remove>0){
            msg="삭제 성공!";
            redirectPath="redirect:/store/detail.do";
        }
        redirectAttributes.addFlashAttribute("msg",msg);
        return redirectPath;

    }

}
