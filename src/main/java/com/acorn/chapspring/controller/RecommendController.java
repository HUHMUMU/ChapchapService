package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.RecommendStoreDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.RecommendService;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.List;


@AllArgsConstructor
@RequestMapping("/recommend")
@Controller
@Log4j2
public class RecommendController {
    private RecommendService recommendService;


    @GetMapping("/{userId}/list.do")
    public String list(
            @PathVariable String userId,
            RedirectAttributes redirectAttributes,
            Model model){
            List<RecommendStoreDto> recommend=recommendService.recommendList(userId);

            model.addAttribute("recommend",recommend);


            return "/user/detail/recommend/list";
    }

    @Data
    class HandlerDto{
        private int add;
        private int remove;
    }
    @PostMapping("/handler.do")
    public @ResponseBody HandlerDto addHandler(
            @ModelAttribute RecommendStoreDto recommendstore,
            @SessionAttribute UserDto loginUser
        )throws IOException {
        HandlerDto handler=new HandlerDto();
        int add=recommendService.add(recommendstore);
        handler.setAdd(add);
        return handler;
    }

    @DeleteMapping("/handler.do")
    public @ResponseBody HandlerDto removeHandler(
            RecommendStoreDto recommendstore,
            @SessionAttribute UserDto loginUser
    ){
        HandlerDto handler=new HandlerDto();
        int remove=recommendService.delete(recommendstore);
        handler.setRemove(remove);
        return handler;
    }
}


