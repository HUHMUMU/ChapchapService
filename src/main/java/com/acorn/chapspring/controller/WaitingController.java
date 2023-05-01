package com.acorn.chapspring.controller;
import com.acorn.chapspring.dto.*;
import com.acorn.chapspring.service.StoreService;
import com.acorn.chapspring.service.StoresWaitingService;
import com.acorn.chapspring.service.WaitingService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.catalina.User;
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

    @GetMapping("/{storeNum}/waitingStatus.do")
    public String waitingStatus(Model model,
                                @SessionAttribute UserDto loginUser,
                                @PathVariable int storeNum
                                ){
        StoresWaitingDto storeswaiting = storesWaitingService.getStoreWaitingByStoreNum(storeNum);
        List<UsersWaitingDto> waitings = waitingService.getWaitingByWaitNum( storeNum,loginUser.getUserId());

        model.addAttribute("waitings", waitings);
        model.addAttribute("storeswaiting", storeswaiting);
        return "waiting/waitingStatus";
    }
    @GetMapping("/{storeNum}/waitingAdd.do")
    public String addWaiting(Model model,
                           @PathVariable int storeNum,
                           @SessionAttribute UserDto loginUser) {
        StoresDto stores = storeService.getStoreByStoreNum(storeNum);
        StoresWaitingDto storeswaiting = storesWaitingService.getStoreWaitingByStoreNum(storeNum);

        model.addAttribute("stores",stores); // stores. 이걸 쓸 수 있는건 이걸 써줘서야
        model.addAttribute("storeswaiting",storeswaiting);
        return "waiting/waitingAdd";
    }

    @PostMapping ("/waitingAdd.do")
    public String addWaiting(@SessionAttribute UserDto loginUser,
                            @ModelAttribute UsersWaitingDto usersWaitingDto,
                             Model model) {
        usersWaitingDto.setUserId(loginUser.getUserId());
        int addWaiting = waitingService.addWaiting(usersWaitingDto);

        if(addWaiting>0){// 웨이팅 등록 성공
            return "redirect:/waiting/"+usersWaitingDto.getStoreNum()+"/waitingStatus.do";
        }
        else  {
            return "redirect:/waiting/"+usersWaitingDto.getStoreNum()+"/waitingAdd.do";
        }
    }

    @GetMapping("/{storeNum}/waitingModify.do")
    public String modifyWaiting(
            Model model,
            @PathVariable int storeNum,
            @SessionAttribute UserDto loginUser) {
        StoresDto stores = storeService.getStoreByStoreNum(storeNum);


        UsersWaitingDto userWaiting=waitingService.detail(storeNum,loginUser.getUserId());
        model.addAttribute("userWaiting",userWaiting);
        model.addAttribute("stores",stores); // stores. 이걸 쓸 수 있는건 이걸 써줘서야
        return "/waiting/waitingModify";
    } // 20:28 삭제 되나?
    @PostMapping("/{storeNum}/waitingModify.do")
    public String modifyWaitingAction(
            Model model,
            @PathVariable int storeNum,
            @SessionAttribute UserDto loginUser,
            @RequestParam int user_people,
            RedirectAttributes redirectAttributes) {
        UsersWaitingDto userWaiting=waitingService.detail(storeNum,loginUser.getUserId());
        userWaiting.setUserPeople(user_people);
        int modifyWaiting=waitingService.modifyPeople(userWaiting);
        String msg="";
        String redirectPath="";
        if(modifyWaiting>0){
            msg="인원 수정 성공";
            redirectPath="redirect:/waiting/"+storeNum+"/waitingStatus.do";
        }else{
            return msg="실패했슈";
            
        }
        redirectAttributes.addFlashAttribute("msg",msg);
        return redirectPath;
    }

    
    

    @GetMapping("/{waitingNum}/remove.do")
    public String removeAction( Model model,
                                @PathVariable int waitingNum,
                                @SessionAttribute UserDto loginUser,
                                RedirectAttributes redirectAttributes) {
        String redirectPath="";
        String msg="";
        int remove=0;
        try{
            remove=waitingService.remove(waitingNum);
        }catch (Exception e){
            log.error(e);;
        }
        if(remove>0){
            msg="삭제 성공!";
            redirectPath="redirect:/store/"+waitingNum+"/detail.do";
        }else{
            msg="삭제 실패!";
            redirectPath="redirect:/waiting/"+waitingNum+"/waitingStatus.do";

        }
        redirectAttributes.addFlashAttribute("msg",msg);
        return redirectPath;

    }

}
