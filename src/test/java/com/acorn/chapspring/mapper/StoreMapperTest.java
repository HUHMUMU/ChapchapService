package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class StoreMapperTest {
@Autowired
private UserMapper userMapper;
@Autowired
private StoreMapper storeMapper;

private static UserDto user;
private static RecommendStoreDto recommendstore;
private static StoreDto store;

    @Test
    void findByStoreNum() {
        user=new UserDto();
        store=new StoreDto();
        user.setUserId("admin");
        List<RecommendStoreDto> recommend=userMapper.findAllRecommend(user.getUserId());
        System.out.println(recommend);
        int myRecommend=0;
        for(RecommendStoreDto stores :recommend){
            StoreDto find=storeMapper.findByStoreNum(stores.getStoreNum());
            System.out.println("recommend store name "+myRecommend+" : "+find.getStoreName());
            myRecommend++;
        }
    }
}