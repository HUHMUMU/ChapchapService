package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.VisitedStoreDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class VisitedStoreMapperTest {
    @Autowired
    private VisitedStoreMapper visitedStoreMapper;

    private static VisitedStoreDto visitedstore;
    @Test
    void findAllVisitedByUserId() {
        visitedstore=new VisitedStoreDto();
        visitedstore.setUserId("admin");
        List<VisitedStoreDto> lists=visitedStoreMapper.findAllVisitedByUserId(visitedstore.getUserId());
        int listnum=0;
        for (VisitedStoreDto list : lists){
            listnum++;
            System.out.println("num "+listnum+" : "+list);
        }
    }
}