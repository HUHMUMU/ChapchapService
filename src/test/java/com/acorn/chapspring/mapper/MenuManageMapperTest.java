package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.MenuManagesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
class MenuManageMapperTest {
    @Autowired
    private MenuManageMapper menuManageMapper;
    @Test
    void findMenuByStore() {
        List<MenuManagesDto> menu=menuManageMapper.findMenuByStore(1);
        System.out.println("menu = " + menu);
        assertNotNull(menu);
    }
}