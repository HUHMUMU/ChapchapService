package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ReviewLikesDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.ReviewLikeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/store/like")
@Log4j2
public class ReviewLikeController {
    private ReviewLikeService reviewLikeService;

    @GetMapping("/{reviewNum}/handler.do")
    public @ResponseBody int handler(
            @PathVariable int reviewNum,
            @SessionAttribute UserDto loginUser){

        ReviewLikesDto reviewLike=reviewLikeService.checkLikeByUser(reviewNum,loginUser.getUserId());

        return 0;
    }

}
