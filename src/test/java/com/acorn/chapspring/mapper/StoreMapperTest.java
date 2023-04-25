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
    private RecommendStoreMapper recommendStoreMapper;
    @Autowired
    private UserMapper userMapper;

    @Test
    void findAllStores() {
    }

    @Test
    void findStoreByStoreNum() {
        StoresDto store=storeMapper.findStoreByStoreNum(1);
        System.out.println("store = " + store);
        assertNotNull(store);
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
    void findAndSortStoresByFilter() {
        StoreFilterDto storeFilterDto = new StoreFilterDto();

        // 아래의 필터조건 0개~4개 활성화 가능
//        storeFilterDto.setMenuType(7);
        storeFilterDto.setPriceRange("0-10000");
//        storeFilterDto.setDetailArea("역삼동"); // address에 () 속에 동이름이 들어가야함.
//        storeFilterDto.setParking(1);

        // 정렬조건 4개중 1개
        storeFilterDto.setSortBy("recommended");
//        storeFilterDto.setSortBy("jjim");
//        storeFilterDto.setSortBy("review");
        // 거리순은 아직 미구현
//        storeFilterDto.setSortBy("distance");

        List<StoresDto> stores=storeMapper.findStoresByFilter(storeFilterDto);
        System.out.println("stores = " + stores);
    }

    @Test
    void findByStoreNum() {
//        user=new UserDto();
//        store=new StoresDto();
//        user.setUserId("admin");
//        List<RecommendStoreDto> recommend=recommendStoreMapper.findAllRecommend(user.getUserId());
//        System.out.println(recommend);
//        int myRecommend=0;
//        for(RecommendStoreDto stores :recommend){
//            StoresDto find=storeMapper.findByStoreNum(stores.getStoreNum());
//            System.out.println("recommend store name "+myRecommend+" : "+find.getStoreName());
//            myRecommend++;
//        }
        // 석정씨 user , store 가 빨간줄떠서 주석처리해놨어요
    }

    @Test
    void findAllType() {
    }

    @Test
    void countReviewsByStoreNum() {
    }

    @Test
    void countJjimByStoreNum() {
    }

    @Test
    void findReviewsCountByStoreNum() {

    }
}