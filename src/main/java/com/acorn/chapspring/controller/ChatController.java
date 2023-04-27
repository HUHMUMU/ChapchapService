package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ChatRoomDto;
import com.acorn.chapspring.service.ChatRoomService;
import org.springframework.ui.Model;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/chat")
public class ChatController {
    private ChatRoomService chatRoomService;
    @GetMapping("/room/list.do")
    public String list(Model model) {
        List<ChatRoomDto> rooms=chatRoomService.list();
        model.addAttribute("rooms", rooms);
        return "/chat/roomList";
    }
    @GetMapping("/room/{crId}/detail.do")
    public String detail(
            Model model,
            @PathVariable int crId) {
        model.addAttribute("crId",crId);
        return "/chat/roomDetail";
    }
}
