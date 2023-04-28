package com.acorn.chapspring.controller;


import com.acorn.chapspring.dto.ChapstorylikesDto;
import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.ChapstoryLikeService;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/chapstory/like")
@AllArgsConstructor
@Log4j2
public class ChapstoryLikeController {
    private ChapstoryLikeService chapstoryLikeService;
//    @GetMapping("{chapNum}/read.do")
//    public String readLikeCnt(
//            @PathVariable int chapNum,
//            @SessionAttribute(required = false)UserDto loginUser,
//            Model model){
//        String templatePage;
//        ChapstorylikesDto likes;
//        model.addAttribute("id",chapNum);
//        if(loginUser!=null){
//            likes=chapstoryLikeService.read(chapNum, loginUser.getUserId());
//            templatePage="/chapstory/loginLikes";
//        }else{
//            likes=chapstoryLikeService.read(chapNum);
//            templatePage="/chapstory/likes";
//        }
//        log.info(likes);
//        model.addAttribute("likes",likes);
//        return  templatePage;
//    }

//    @Data
//    class HandlerDto{
//        enum HandlerType{REGISTER,REMOVE}
//        private HandlerType handlerType;
//        int handler; //0실패 1성공
//    }
//
    @GetMapping("/{chapNum}/handler.do")
    public @ResponseBody int handler(
            @PathVariable int chapNum,
            @SessionAttribute UserDto loginUser){

        ChapstorylikesDto chapLike=chapstoryLikeService.detail(chapNum,loginUser.getUserId());

        int handler=0;
        ChapstorylikesDto like = new ChapstorylikesDto();
        like.setUserId(loginUser.getUserId());
        like.setChapNum(chapNum);
        if(chapLike==null){ //등록
            handler=chapstoryLikeService.register(like);
        }else{
            handler=chapstoryLikeService.remove(like);
        }
        return handler;
    }


}
