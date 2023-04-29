package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ReviewsDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.ReviewService;
import com.acorn.chapspring.service.StoreService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
//@AllArgsConstructor
@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/review")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
public class ReviewController {
    private ReviewService reviewService;
    private StoreService storeService;

    @Value("${static.path}")
    private String staticPath;

    public ReviewController(ReviewService reviewService) {this.reviewService=reviewService;}

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
        if(!img.isEmpty()){
            String[] cotentTypes=img.getContentType().split("/");
            if(cotentTypes[0].equals("image")){
                String fileName=System.currentTimeMillis()+"_"+(int)(Math.random()*10000)+"."+cotentTypes[1];
                Path path= Paths.get(staticPath+"/public/img/review/"+fileName);
                img.transferTo(path);
                //fetch 에서 resp.status 200 일때만 처리하기 때문에 그냥 오류가 발생하면 500
                reviews.setImg("/public/img/review/"+fileName);
            }
        }
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

    @GetMapping("/{reviewNum}/remove.do")
    public String removeAction(@PathVariable int reviewNum,
                               @ModelAttribute ReviewsDto reviews,
                               @SessionAttribute UserDto loginUser,
                               RedirectAttributes redirectAttributes){
        String redirectPath="redirect:/store/"+reviews.getStoreNum()+"/detail.do";
        String msg="삭제 실패";
        int remove = 0;
        try{
            remove=reviewService.remove(reviewNum);
        }catch (Exception e){
            log.error(e);
        }
        if(remove>0){
            msg="삭제 성공!";
        }
        redirectAttributes.addFlashAttribute("msg",msg);
        return redirectPath;
    }
}
