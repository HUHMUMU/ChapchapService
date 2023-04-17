package com.example.chapchapserviceproject.controller;

import com.example.chapchapserviceproject.dto.UserDto;
import com.example.chapchapserviceproject.service.UserService;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
@Log4j2
public class UserController {
    private UserService userService;

    //회원 가입
    @GetMapping("/signup.do")
    public void signupForm() {}
    @PostMapping("/signup.do")
    public String signupAction(
            @ModelAttribute UserDto user,
            RedirectAttributes redirectAttributes) {
        int signup=0;
        String errorMsg=null;
        try {
            signup=userService.signup(user);
        } catch (Exception e) {
            log.error(e);
            errorMsg=e.getMessage();
        }

        if (signup>0) {
            redirectAttributes.addFlashAttribute("msg","회원가입 성공");
            return "redirect:/";
        } else {
            redirectAttributes.addFlashAttribute("msg", "회원 가입 실패 : " + errorMsg);
            return "redirect:/user/signup.do";
        }
    }
}
