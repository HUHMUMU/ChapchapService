package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ChapstoryimgsDto;
import com.acorn.chapspring.dto.ReviewsDto;
import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.*;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
    private ReviewRepliesService reviewRepliesService;
    private ReportService reportService;
    private ReviewLikeService reviewLikeService;
    private StoreService storeService;

    @Value("${static.path}")
    private String staticPath;

    public ReviewController(ReviewService reviewService,
                            StoreService storeService,
                            ReportService reportService,
                            ReviewRepliesService reviewRepliesService,
                            ReviewLikeService reviewLikeService) {
        this.reviewService=reviewService;
        this.storeService=storeService;
        this.reviewRepliesService=reviewRepliesService;
        this.reportService=reportService;
        this.reviewLikeService=reviewLikeService;
    }

    @GetMapping("/{storeNum}/register.do")
    public String registerForm(Model model,
                               @PathVariable int storeNum,
                               @SessionAttribute UserDto loginUser){
        StoresDto stores = storeService.getStoreByStoreNum(storeNum); //가게 정보 불러오기
        model.addAttribute("stores",stores);
        return "review/register";
    }
    @PostMapping("/register.do")
    public String registerAction(@SessionAttribute UserDto loginUser,
                                 @ModelAttribute ReviewsDto reviews,
                                 BindingResult bindingResult,
                                 @RequestParam("img")MultipartFile img) throws IOException {
        String redirectPath="redirect:/review/"+reviews.getStoreNum()+"/register.do";
        int register = 0;
        if(img != null){
            String[] contentTypes=img.getContentType().split("/");
            if(contentTypes[0].equals("image")){
                String fileName=System.currentTimeMillis()+"_"+(int)(Math.random()*10000)+"."+contentTypes[1];
                Path path= Paths.get(staticPath+"/public/img/review/"+fileName);
                img.transferTo(path);
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

    @GetMapping("/{storeNum}/{reviewNum}/remove.do")
    public String removeAction(@PathVariable int reviewNum,
                               @PathVariable int storeNum,
                               @ModelAttribute ReviewsDto reviews,
                               @SessionAttribute UserDto loginUser,
                               RedirectAttributes redirectAttributes){
        String redirectPath="redirect:/store/"+reviews.getStoreNum()+"/detail.do";
        String msg="삭제 실패";
        int remove = 0;
        try{
            if(reviewRepliesService.findRepliesByReview(reviewNum)!=null){
                remove=reviewRepliesService.removeReply(reviewNum); //리뷰의 댓글 삭제
            }
            remove+=reportService.removeReportByReview(reviewNum); //리뷰의 신고 삭제
            remove+=reviewLikeService.removeLikeByReview(reviewNum); //리뷰의 좋아요 삭제
            remove+=reviewService.remove(reviewNum); //리뷰 삭제
        }catch (Exception e){
            log.error(e);
        }
        if(remove>0){
//            if(reviews.getImg()!=null){ //이미지파일에서 삭제
//                File imgFile=new File(staticPath+reviews.getImg());
//                if(imgFile.exists())imgFile.delete();
//            }
            msg="삭제 성공!";
            redirectPath="redirect:/store/"+storeNum+"/detail.do";
        }
        redirectAttributes.addFlashAttribute("msg",msg);
        return redirectPath;
    }
}
