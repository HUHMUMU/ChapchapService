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
    StoreFilterDto storeFilterDto = new StoreFilterDto();
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
    void findStoresByFilter() {
//        storeFilterDto.setMenuType("백반");
//        storeFilterDto.setPriceRange();
        storeFilterDto.setDetailArea("역삼동");
        storeFilterDto.setParking(1);
        // 아 테스트 실패했네ㅠㅠㅠ
        List<StoresDto> stores=storeMapper.findStoresByFilter(storeFilterDto);

        System.out.println("stores = " + stores);
    }

    @Test
    void sortFilteredStores() {
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
}