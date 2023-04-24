package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.StoreManagesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class StoreManageMapperTest {
    @Autowired
    private StoreManageMapper storeManageMapper;

    @Test
    void findStoreCall() {
        StoreManagesDto storeCall=storeManageMapper.findStoreCall(1);
        System.out.println("storeCall = " + storeCall);
        assertNotNull(storeCall);
    }
}