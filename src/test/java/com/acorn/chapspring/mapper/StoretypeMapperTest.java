package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.StoretypesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class StoretypeMapperTest {
    @Autowired
    StoretypeMapper storetypeMapper;

    @Test
    void findByStoreType() {
        StoretypesDto type=storetypeMapper.findByStoreType(1);
        System.out.println("type = " + type);
    }
}