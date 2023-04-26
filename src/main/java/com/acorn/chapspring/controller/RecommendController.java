package com.acorn.chapspring.controller;

import com.acorn.chapspring.dto.RecommendStoreDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.service.RecommendService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/recommend")
public class RecommendController {
    private RecommendService recommendService;

    @DeleteMapping("/{storeNum}/handler.do")
    public int deleteHandler(
            @PathVariable int storeNum,
            @SessionAttribute UserDto loginUser
            ){
        int remove=0;
        RecommendStoreDto recommendstore=new RecommendStoreDto();
        recommendstore.setUserId(loginUser.getUserId());
        recommendstore.setStoreNum(storeNum);

        remove=recommendService.delete(recommendstore);
        return remove;
    }

    @PostMapping("/{storeNum}/handler.do")
    public int addHandler(
            @PathVariable int storeNum,
            @SessionAttribute UserDto loginUser
    ){
        int add=0;
        RecommendStoreDto recommendStore=new RecommendStoreDto();
        recommendStore.setStoreNum(storeNum);
        recommendStore.setUserId(loginUser.getUserId());

        add=recommendService.add(recommendStore);
        return add;
    }
}
