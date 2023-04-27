package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.RecommendStoreDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.RecommendService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;


@AllArgsConstructor
@RequestMapping("/recommend")
@Controller
public class RecommendController {
    private RecommendService recommendService;


    @GetMapping("/{userId}/list.do")
    public String list(
            @PathVariable String userId,
            RedirectAttributes redirectAttributes,
            Model model){
            List<RecommendStoreDto> recommend=recommendService.recommendList(userId);

            model.addAttribute("recommend",recommend);


            return "/user/detail/recommendList";
    }
}
