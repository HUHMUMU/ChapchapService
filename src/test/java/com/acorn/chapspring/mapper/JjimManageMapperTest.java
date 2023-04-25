package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.JjimManageDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class JjimManageMapperTest {
    @Autowired
    private JjimManageMapper jjimManageMapper;

    private static JjimManageDto jjim;
    @Test
    void findAllJjimByUserId() {
        jjim=new JjimManageDto();
        jjim.setUserId("admin");
        List<JjimManageDto> lists=jjimManageMapper.findAllJjimByUserId(jjim.getUserId());
        int listnum=0;
        for (JjimManageDto list : lists){
            listnum++;
            System.out.println("num "+listnum+" : "+list);
        }
    }

    @Test
    void insertOneByUserId(){
        jjim=new JjimManageDto();
        jjim.setUserId("admin");
        jjim.setStoreNum(5);
        jjim.setJjStatus("공개");
        int insert= jjimManageMapper.insertOneByUserId(jjim);
        assertEquals(insert,1);
    }

    @Test
    void deleteOneByUserIdAndStoreNum(){
        jjim=new JjimManageDto();
        jjim.setUserId("admin");
        jjim.setStoreNum(5);
        int delete=jjimManageMapper.deleteOneByUserIdAndStoreNum(jjim);
        assertEquals(delete,1);
    }
}