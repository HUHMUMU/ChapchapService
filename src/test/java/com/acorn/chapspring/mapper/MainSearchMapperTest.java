package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.StoresDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class MainSearchMapperTest {
    @Autowired
    private MainSearchMapper mainSearchMapper;

    @Test
    void findByName(){
        List<StoresDto> storeList = mainSearchMapper.findByNameContaining("햄");
        assertNotNull(storeList);
        System.out.println("storeList = " + storeList);
    }
}