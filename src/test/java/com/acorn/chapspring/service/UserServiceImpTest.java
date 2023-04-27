package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.JjimManageDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.mapper.JjimManageMapper;
import com.acorn.chapspring.mapper.UserMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class UserServiceImpTest {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private JjimManageMapper jjimManageMapper;

    private JjimManageDto jjim;

    private static UserDto user;
    @Test
    void jjimList() {
        jjim=new JjimManageDto();
        jjim.setUserId("admin");
        List<JjimManageDto> lists=jjimManageMapper.findAllJjimByUserId(jjim.getUserId());
        List<JjimManageDto> userJjimList=new ArrayList<>(lists.size());
        int listNum=0;
        for(JjimManageDto list : lists){
            listNum++;
            list.setListNum(listNum);
            userJjimList.add(list);
        }
        System.out.println(userJjimList);
    }
}