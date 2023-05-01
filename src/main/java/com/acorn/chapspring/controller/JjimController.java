package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.JjimManageDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.JjimService;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@AllArgsConstructor
@Controller
@RequestMapping("/jjim")
@Log4j2
public class JjimController {
    private JjimService jjimService;
    @Data
    class HandlerDto{
        private int add;
        private int remove;
    }
    @PostMapping("/handler.do")
    public @ResponseBody HandlerDto addHandler(
            @ModelAttribute JjimManageDto jjim,
            @SessionAttribute UserDto loginUser
            ) throws IOException{
        HandlerDto handler=new HandlerDto();
        jjim.setJjStatus("공개");
        int add=jjimService.add(jjim);
        handler.setAdd(add);
        return handler;
    }

    @DeleteMapping("/handler.do")
    public @ResponseBody HandlerDto removeHandler(
            JjimManageDto jjim,
            @SessionAttribute UserDto loginUser
    ){
        HandlerDto handler=new HandlerDto();
        int remove= jjimService.delete(jjim);
        handler.setRemove(remove);
        return handler;
    }

}
