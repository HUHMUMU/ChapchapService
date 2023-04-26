package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.TypeClassesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class TypeClasseMapperTest {
    @Autowired
    TypeClasseMapper typeClasseMapper;
    @Test
    void findByStoreType() {
        TypeClassesDto typeClass=typeClasseMapper.findByStoreType(5);
        System.out.println("typeClass = " + typeClass);
    }
}