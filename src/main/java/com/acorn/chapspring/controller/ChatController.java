package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.ChatMsgDto;
import com.acorn.chapspring.dto.ChatRoomDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.mapper.ChatMsgMapper;
import com.acorn.chapspring.mapper.ChatRoomMapper;
import com.acorn.chapspring.service.ChatMsgService;
import com.acorn.chapspring.service.ChatRoomService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/chat")
@Log4j2
public class ChatController {
    private ChatRoomService chatRoomService;
    private ChatMsgMapper chatMsgMapper;
    private ChatRoomMapper chatRoomMapper;
    @Value("${static.path}") //application.yml의 설정 값 가져오기
    private String imgUploadPath;
    public ChatController(ChatRoomService chatRoomService, ChatMsgMapper chatMsgMapper, ChatRoomMapper chatRoomMapper) {
        this.chatRoomService = chatRoomService;
        this.chatMsgMapper = chatMsgMapper;
        this.chatRoomMapper = chatRoomMapper;
    }

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
//    채팅방 등록
    @GetMapping("/room/register.do")
    public String registerForm(@SessionAttribute UserDto loginUser){
        return "/chat/register";
    }
    @PostMapping("/room/register.do")
    public String register(@ModelAttribute ChatRoomDto chatRoomDto,
                                      MultipartFile img,
                                      @SessionAttribute UserDto loginUser,
                                      RedirectAttributes redirectAttributes) throws IOException {
        int register=0;
        String msg="채팅 등록 실패";
        log.info(imgUploadPath);

        try {
            if(img!=null && !img.isEmpty()){//파일을 선택하지 않아도 null 이 아님
                String contentType=img.getContentType(); // image/png or image/jpeg or text/xml or application/json
                String [] contentTypes=contentType.split("/");
                if(contentTypes[0].equals("image")){
                    String fileName=System.currentTimeMillis()+"_"+(int)(Math.random()*10000)+"."+contentTypes[1];
                    String imgPath=imgUploadPath+"/public/img/chat/"+fileName; //서버 컴퓨터의 물리적 위치
                    Path path= Paths.get(imgPath);
                    img.transferTo(path); //이미지 저장
                    chatRoomDto.setProfileImg("/public/img/chat/"+fileName); //서버가 이미지를 배포하는 위치
                }
            }///Users/yun-usang/Documents/ChapChapService/ChapchapService/src/main/resources/static/public/img/chat
                register = chatRoomService.register(chatRoomDto);
        } catch (Exception e) {
            log.error(e.getMessage());
            msg+="에러 :"+e.getMessage();
        }
        if (register>0) {
            msg="채팅방 등록 성공";
        }
        redirectAttributes.addFlashAttribute("msg",msg);
        return "redirect:/chat/room/list.do";
    }
}

