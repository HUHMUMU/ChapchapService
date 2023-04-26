package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.VisitedStoreDto;
import com.acorn.chapspring.mapper.VisitedStoreMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class VisitedStoreServiceImpTest {

    @Autowired
    private VisitedStoreMapper visitedStoreMapper;

    private VisitedStoreDto visited;
    @Test
    void visited() {
        visited=new VisitedStoreDto();
        visited.setUserId("admin");
        List<VisitedStoreDto> list=visitedStoreMapper.findAllVisitedByUserId(visited.getUserId());
        List<VisitedStoreDto> userVisitedList=new ArrayList<>(list.size());
        int listNum=0;
        for(VisitedStoreDto visitedList : list){
            listNum++;
            visitedList.setListNum(listNum);
            userVisitedList.add(visitedList);
        }
        System.out.println(userVisitedList);
    }
}