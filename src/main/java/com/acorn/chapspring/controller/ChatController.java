package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.UserDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ChatController {
    @GetMapping("/chattingRoom.do")
    public String chattingRoom(
            @SessionAttribute(required = false) UserDto loginUser,
            RedirectAttributes redirectAttributes) {
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("msg","로그인 후 이용 하실 수 있습니다.");
            return "redirect:/user/login.do";
        }
        return "/chattingRoom";
    }
}
