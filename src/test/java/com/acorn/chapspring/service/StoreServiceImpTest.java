package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.StoresDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class StoreServiceImpTest {
    @Autowired
    private StoreService storeService;

    @Test
    void storeList() {
    }

    @Test
    void storeTypesList() {
    }

    @Test
    void getStore() {
    }

    @Test
    void getFilteredAndSortedStores() {
    }

    @Test
    void getStoreByStoreNum() {
        StoresDto stores=storeService.getStoreByStoreNum(1);
        System.out.println("stores = " + stores);
    }
}