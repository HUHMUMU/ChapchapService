package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.FollowDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.FollowService;
import com.acorn.chapspring.service.UserService;
import lombok.AllArgsConstructor;

import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/follow")
@AllArgsConstructor
public class FollowController {
    private FollowService followService;
    private UserService userService;
    //등록 요청
    @PostMapping("/{userId}/handler.do")
    public int registerHandler(
            @PathVariable String userId,
            @SessionAttribute UserDto loginUser){ //400
        int register=0;
        //글쓴이가 자기 자신을 팔로잉 할 수 없다.
        if(loginUser.getUserId().equals(userId))return register;

        FollowDto follow=new FollowDto();

        follow.setFromId(loginUser.getUserId());
        follow.setToId(userId);


        register=followService.register(follow); //등록
        return register;//성공시 1
    }
//    삭제 요청
    @DeleteMapping("/{userId}/handler.do")
    public int removeHandler(
            @PathVariable String userId,
            @SessionAttribute UserDto loginUser){

            int remove=0;
            FollowDto follow=new FollowDto();


            follow.setFromId(loginUser.getUserId());
            follow.setToId(userId);



        remove=followService.remove(follow);//삭제
        return remove;//성공시 1
    }
}
