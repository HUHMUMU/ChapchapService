package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapstoryimgsDto;
import com.acorn.chapspring.dto.ChapstorysDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
class ChapStoryMapperTest {
    @Autowired
    private ChapStoryMapper chapStoryMapper;

    private static ChapstorysDto chaps;

    @Test
    void findAll() {
    }

    @Test
    void findByChapNum() {
    }

    @Test
    void findByUserId() {
    }

    @Test
    void insertOne() throws ParseException {
        chaps=new ChapstorysDto();
        chaps.setChapNum(19);
        chaps.setTitle("테스트");
        chaps.setContent("테스트");
        chaps.setMainImg("/public/img/chapstory/chapstory1-1.jpg");
        chaps.setUserId("user01");
        int insert= chapStoryMapper.insertOne(chaps);
        ChapStoryMapperTest.chaps=chapStoryMapper.findByChapNum(chaps.getChapNum());
        System.out.println("등록된 챱스토리 게시글 정보 : "+ChapStoryMapperTest.chaps);
        assertEquals(insert,1);
    }

    @Test
    void updateOne() {
        chaps=new ChapstorysDto();
        chaps.setChapNum(19);
        chaps.setTitle("수정 테스트");
        chaps.setContent("수정 테스트");
        chaps.setMainImg("/public/img/chapstory/chapstory1-2.jpg");
        chaps.setUserId("user01");
        int insert= chapStoryMapper.updateOne(chaps);
        ChapStoryMapperTest.chaps=chapStoryMapper.findByChapNum(chaps.getChapNum());
        System.out.println("수정된 게시글 정보 : "+ChapStoryMapperTest.chaps);
        assertEquals(insert,1);
    }

    @Test
    void deleteByChapsNum() {
        int delete= chapStoryMapper.deleteByChapsNum(19);
        assertEquals(delete,1);
    }
}