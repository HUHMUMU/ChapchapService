package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ReviewsDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.ReviewService;
import com.acorn.chapspring.service.StoreService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
@AllArgsConstructor
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/review")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
public class ReviewController {
    private ReviewService reviewService;
    private StoreService storeService;

//    @Value("${img.upload.path}")
//    private String uploadPath; //등록
//    @Value("${static.path}")
//    private String staticPath; //삭제

    @GetMapping("/{storeNum}/register.do")
    public String registerForm(Model model,
                               @PathVariable int storeNum,
                               @SessionAttribute UserDto loginUser){
        StoresDto stores = storeService.getStoreByStoreNum(storeNum);
        model.addAttribute("stores",stores);
        return "review/register";
    }
    @PostMapping("/register.do")
    public String registerAction(@SessionAttribute UserDto loginUser,
                                 @ModelAttribute ReviewsDto reviews,
                                 MultipartFile img) throws IOException {
        String redirectPath="redirect:/review/"+reviews.getStoreNum()+"/register.do";
        int register = 0;
        if(!loginUser.getUserId().equals(reviews.getUserId())) return redirectPath;
//        if(!img.isEmpty()){
//            String[] cotentTypes=img.getContentType().split("/");
//            if(cotentTypes[0].equals("image")){
//                String fileName=System.currentTimeMillis()+"_"+(int)(Math.random()*10000)+"."+cotentTypes[1];
//                Path path= Paths.get(uploadPath+"/review/"+fileName);
//                img.transferTo(path);
//                //fetch 에서 resp.status 200 일때만 처리하기 때문에 그냥 오류가 발생하면 500
//                reviews.setImg("/public/img/review/"+fileName);
//            }
//        }
        try{
            register=reviewService.register(reviews);
        }catch (Exception e){
            log.error(e.getMessage());
        }
        if(register>0) {// 리뷰 등록 성공
            redirectPath="redirect:/store/"+reviews.getStoreNum()+"/detail.do";
        }
        return redirectPath;
    }
}
