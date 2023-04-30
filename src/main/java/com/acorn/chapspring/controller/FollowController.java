package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.FollowDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.FollowService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/follow")
@AllArgsConstructor
public class FollowController {
    private FollowService followService;
    //등록 요청
    @PostMapping("/{userId}/{follower}/handler.do")
    public int registerHandler(
            @PathVariable String userId,
            @PathVariable boolean follower,
            @SessionAttribute UserDto loginUser){ //400
        int register=0;
        //글쓴이가 자기 자신을 팔로잉 할 수 없다.
        if(loginUser.getUserId().equals(userId))return register;

        FollowDto followDto=new FollowDto();
        if(follower){//상대가 나를 팔로우중일 때
            followDto.setToId(loginUser.getUserId());//누구를=로그인유저를
            followDto.setFromId(userId);//누가=상대가
        }else{//상대가 나를 팔로우중이 아닐 때
            followDto.setToId(userId);//누구를=유저를
            followDto.setFromId(loginUser.getUserId());//누가=로그인 유저가
        }
        register=followService.register(followDto); //500
        return register;//성공시 1
    }
//    삭제 요청
    @DeleteMapping("/{userId}/{follower}/handler.do")
    public int removeHandler(
            @PathVariable String userId,
            @PathVariable boolean follower,
            @SessionAttribute UserDto loginUser){
        int remove=0;
        FollowDto follow=new FollowDto();
        if(follower){//상대도 나를 팔로우중임
            follow.setFromId(loginUser.getUserId());//누가=상대방이
            follow.setToId(userId);//누구를=로그인유저를
        }else{//상대는 나를 팔로우중이 아님
            follow.setFromId(userId);//누가=로그인유저가
            follow.setToId(loginUser.getUserId());//누구를=상대방을
        }

        remove=followService.remove(follow);//삭제
        return remove;//성공시 1
    }
}
