package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ChapDealDto;
import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.service.ChapStoryService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;


@Controller //< @Component 요청과 응답을 처리 가능
@RequestMapping("/chapstory")
@Log4j2 //log 필드로 로그남길 수 있다.(파일로 저장 가능[유지기간,성질])
public class ChapStoryController {
    private ChapStoryService chapStoryService;

    public ChapStoryController(ChapStoryService chapStoryService) {this.chapStoryService=chapStoryService;}
    @GetMapping("/write.do")
    public String list() {
        return "chapstory/write"; // 해당 경로에 대한 뷰 이름 반환
    }

    @GetMapping("/list.do")
    public String chapList(
            Model model){
        List<ChapstorysDto> chaps;
        chaps= chapStoryService.list();
        model.addAttribute("chapstorys",chaps);
        return "chapstory/list";
    }

    @GetMapping("/{chapNum}/detail.do")
    public String chapDetail(
            Model model,
            @PathVariable int chapNum){
        ChapstorysDto chaps = chapStoryService.detail(chapNum);
        model.addAttribute("c",chaps);
        return "chapstory/detail";}

    @GetMapping("/{userId}/blogMain.do")
    public String chapMain(
            Model model,
            @PathVariable String userId){
        List<ChapstorysDto> chaps;
        chaps = chapStoryService.blogMain(userId);
        model.addAttribute("chapstorys",chaps);
        return "chapstory/blogMain";}

    @GetMapping("/register.do")
    public String register(){return "chapstory/register";}
}
