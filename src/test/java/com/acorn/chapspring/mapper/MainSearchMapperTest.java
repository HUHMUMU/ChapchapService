package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.MenuManagesDto;
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
    void findStore() {
        StoresDto store= mainSearchMapper.findByAddressReviewsOne("서울", "강남구");
        System.out.println("store = " + store);
        assertNotNull(store);
    }
}