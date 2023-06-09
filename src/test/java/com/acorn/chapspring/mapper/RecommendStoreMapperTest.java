package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.MenuManagesDto;
import com.acorn.chapspring.dto.RecommendStoreDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class RecommendStoreMapperTest {
    @Autowired
    private RecommendStoreMapper recommendStoreMapper;

    private static RecommendStoreDto recommendstore;

    @Test
    void findAllRecommendstoreByUserId() {
        recommendstore=new RecommendStoreDto();
        recommendstore.setUserId("admin");
        List<RecommendStoreDto> lists=recommendStoreMapper.findAllRecommendstoreByUserId(recommendstore.getUserId());
        int listnum=0;
        for(RecommendStoreDto list : lists){
            listnum++;
            System.out.println("num " + listnum+ " : "+list);
        }
    }

    @Test
    void insertOneByUserId() {
        recommendstore=new RecommendStoreDto();
        recommendstore.setUserId("admin");
        recommendstore.setComment("분위기가 좋아요");
        recommendstore.setStoreNum(8);
        int insert=recommendStoreMapper.insertOneByUserId(recommendstore);
        assertEquals(insert,1);
    }
    @Test
    void updateOne(){
//        recommendstore=new RecommendStoreDto();
//        recommendstore.setStoreNum(1);
//        recommendstore.setUserId("admin");
//
//        RecommendStoreDto recommend=recommendStoreMapper.findOneByUserIdAndStoreNum(recommendstore.getUserId(),recommendstore.getStoreNum());
//        List<MenuManagesDto> storeMenu=recommend.getMenuList();
//        recommendstore.setRecommendMenu(storeMenu.get(0).getMenuNum());
//        recommendstore.setComment("햄버거가 정말 맛있어요!");
//        int update=recommendStoreMapper.updateOne(recommendstore);
//        assertEquals(update,1);
//        System.out.println(recommendstore);
    }

    @Test
    void deleteOneByUserIdAndStoreNum() {
        recommendstore=new RecommendStoreDto();
        recommendstore.setUserId("admin");
        recommendstore.setStoreNum(4);
        int delete=recommendStoreMapper.deleteOneByUserIdAndStoreNum(recommendstore);
        assertEquals(delete,1);
    }

    @Test
    void findOneByUserIdAndStoreNum() {
        recommendstore=new RecommendStoreDto();
        recommendstore.setUserId("admin");
        recommendstore.setStoreNum(1);
        RecommendStoreDto findOne=recommendStoreMapper.findOneByUserIdAndStoreNum(recommendstore.getUserId(),recommendstore.getStoreNum());
        System.out.println(findOne);
    }



}