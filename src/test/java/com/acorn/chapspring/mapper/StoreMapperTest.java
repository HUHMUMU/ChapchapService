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

    @Test
    void findAllStores() {
    }

    @Test
    void findStoresByFilterAndSort() {
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
}