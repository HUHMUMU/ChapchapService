package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.service.MainService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@AllArgsConstructor
@Controller
@RequestMapping("/")
@Log4j2
public class MainController {
    private MainService mainService;



    @PostMapping("/searchStore.do")
    public String searchBestStore(
            String siAdd,
            String guAdd,
            Model model,
            RedirectAttributes redirectAttributes) {
        StoresDto store = mainService.getStoreByAddressReviews(siAdd, guAdd);
        if (store != null) {
            System.out.println(store);
            model.addAttribute("store", store);
            return "/";
        }
        redirectAttributes.addFlashAttribute("msg", "검색 결과가 없습니다.");
        return "redirect:/";
    }
}