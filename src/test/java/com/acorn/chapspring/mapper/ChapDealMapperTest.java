package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapDealDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ChapDealMapperTest {
    @Autowired
    private ChapDealMapper chapDealMapper;

    @Test
    void findAll() {
        List<ChapDealDto> chapDealList=chapDealMapper.findAll();
        System.out.println("chapDealList = " + chapDealList);
        assertNotNull(chapDealList);
    }
}