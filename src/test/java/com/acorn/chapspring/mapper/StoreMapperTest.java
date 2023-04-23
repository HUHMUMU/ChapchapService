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
    private StoreMapper storeMapper;
    @Autowired
    private static UserDto user;
    @Autowired
    private static RecommendStoreDto recommendstore;
    @Autowired
    private static StoresDto store;
    @Autowired
    private UserMapper userMapper;

    @Test
    void findAllStores() {
    }

    @Test
    void findStoresByFilterAndSort() {
    }

    @Test
    void findStoreByStoreNum() {
    }

    @Test
    void findBreaktimesByStoreNum() {
    }

    @Test
    void findMenusByStoreNum() {
    }

    @Test
    void findReviewsByStoreNum() {
    }

    @Test
    void findJjimByStoreNum() {
    }

    @Test
    void findByStoreNum() {
        user=new UserDto();
        store=new StoresDto();
        user.setUserId("admin");
        List<RecommendStoreDto> recommend=userMapper.findAllRecommend(user.getUserId());
        System.out.println(recommend);
        int myRecommend=0;
        for(RecommendStoreDto stores :recommend){
            StoresDto find=storeMapper.findByStoreNum(stores.getStoreNum());
            System.out.println("recommend store name "+myRecommend+" : "+find.getStoreName());
            myRecommend++;
        }
    }
}