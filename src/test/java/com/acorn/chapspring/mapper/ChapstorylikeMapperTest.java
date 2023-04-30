package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapstorylikesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class ChapstorylikeMapperTest {
    @Autowired
    private ChapstorylikeMapper chapstorylikeMapper;
    @Test
    void countByCnum() {
    }

    @Test
    void insertDeleteOne() {
        ChapstorylikesDto chapLike = new ChapstorylikesDto();
        chapLike.setChapNum(1);
        chapLike.setUserId("user17");
        int insert = chapstorylikeMapper.insertOne(chapLike);
        int delete = chapstorylikeMapper.deleteOne(chapLike);
        assertEquals(insert+delete,2);
    }

}