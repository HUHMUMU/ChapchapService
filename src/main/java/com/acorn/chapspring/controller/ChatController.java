package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ChatRoomDto;
import com.acorn.chapspring.service.ChatMsgService;
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
    private ChatMsgService chatMsgService;
    //MVC 로 진행
    //*채팅룸 리스트 /chat/room/list.do
    //*채팅룸 싱세(입장) /chat/room/{crId}/detail.do
    //AJAX 로 진행
    //*채팅룸에서 메세지 보내기 /chat/msg/{crId}/register.do
    //*채팅룸에서 메세지 조회(특정시간 이후 조회) /chat/msg/{crId}/list.do?postTime=2023-04-25+17:04:00
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
