package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapstoryimgsDto;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest

class ChapstoryImgMapperTest {
    @Autowired
    private ChapstoryImgMapper chapstoryImgMapper;
    @Test
    void findByChapNum() {
        List<ChapstoryimgsDto> imgs = chapstoryImgMapper.findByChapNum(1);
        Assertions.assertNotNull(imgs);
    }

    @Test
    void findByChsNum() {
    }

    @Test
    void findByChsNumIn() {
    }

    @Test
    void insertOne() {
    }

    @Test
    void deleteOne() {
    }
}