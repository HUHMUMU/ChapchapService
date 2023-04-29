//package com.acorn.chapspring.controller;
//
//import com.acorn.chapspring.dto.ReviewLikesDto;
//import com.acorn.chapspring.dto.UserDto;
//import com.acorn.chapspring.service.ReviewLikeService;
//import lombok.AllArgsConstructor;
//import lombok.Data;
//import lombok.extern.log4j.Log4j2;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//@AllArgsConstructor //모든 필드를 pojo 형식의 생성자로 자동 생성
//@Controller //< @Component 요청과 응답을 처리 가능
//@RequestMapping("/store/like")
//@Log4j2
//public class ReviewLikeController {
//    private ReviewLikeService reviewLikeService;
//
//    @GetMapping("/{reviewNum}/read.do")
//    public String readLikeStatusCnt(
//            @PathVariable int reviewNum,
//            @SessionAttribute(required = false)UserDto loginUser,
//            Model model){
//        String templatePage;
//        ReviewLikesDto likes;
//        model.addAttribute("id",reviewNum);
//        if(loginUser!=null){
//            likes=reviewLikeService.checkLikeByUser(reviewNum,loginUser.getUserId());
//            templatePage="/store/loginLike";
//        }else{
//            likes=reviewLikeService.checkLike(reviewNum);
//            templatePage="/store/like";
//        }
//        log.info(likes);
//        model.addAttribute("likes",likes);
//        return templatePage;
//    }
//
//    @Data
//    class HandlerDto{
//        enum HandlerType{REGISTER,MODIFY,REMOVE}
//        private HandlerType handlerType;
//        private String rlStatus;
//        int handler; //0실패 1성공
//    }
//
//    @GetMapping("/{rlStatus}/{reviewNum}/handler.do")
//    public @ResponseBody HandlerDto handler(
//            @PathVariable int reviewNum,
//            @PathVariable String rlStatus,
//            @SessionAttribute UserDto loginUser){
//        HandlerDto handlerDto=new HandlerDto();
//        handlerDto.setRlStatus(rlStatus);
//
//        ReviewLikesDto reviewLike=reviewLikeService.checkLikeByUser(reviewNum,loginUser.getUserId());
//
//        int handler=0;
//        ReviewLikesDto like=new ReviewLikesDto();
//        like.setUserId(loginUser.getUserId());
//        like.setRlStatus(rlStatus);
//        like.setReviewNum(reviewNum);
//        if (reviewLike==null){ //등록
//            handlerDto.setHandlerType(HandlerDto.HandlerType.REGISTER);
//            handler=reviewLikeService.registerLike(like);
//        }else { //수정 or 삭제
//            if(reviewLike.getRlStatus().equals(rlStatus)) {//삭제 좋아요가 눌렀는데 다시 좋아요를 누른것
//                handlerDto.setHandlerType(HandlerDto.HandlerType.REMOVE);
//                handler=reviewLikeService.removeLike(like);
//            }else { //수정 좋아요를 눌렀는데 싫어요를 누른것
//                handlerDto.setHandlerType(HandlerDto.HandlerType.MODIFY);
//                handler=reviewLikeService.modifyLike(like);
//            }
//        }
//        handlerDto.setHandler(handler);
//
//        return handlerDto;
//    }
//
//}
