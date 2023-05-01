package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.UsersWaitingDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class WaitingMapperTest {
    @Autowired
    private WaitingMapper waitingMapper;
    @Test
    void getWaitingList() {
        waitingMapper.getWaitingList(1,"user13");
        waitingMapper.getWaitingList(1,"user01");
        waitingMapper.getWaitingList(1,"user02");
        waitingMapper.getWaitingList(1,"user03");
        waitingMapper.getWaitingList(1,"user04");
        waitingMapper.getWaitingList(1,"user05");
        waitingMapper.getWaitingList(1,"user06");
        waitingMapper.getWaitingList(1,"user07");
        waitingMapper.getWaitingList(1,"user08");
        waitingMapper.getWaitingList(1,"user14");
        waitingMapper.getWaitingList(1,"user15");
        waitingMapper.getWaitingList(1,"user16");
        waitingMapper.getWaitingList(1,"user17");
        waitingMapper.getWaitingList(1,"user18");
        waitingMapper.getWaitingList(1,"user19");
        waitingMapper.getWaitingList(1,"user20");
        waitingMapper.getWaitingList(2,"user21");
        waitingMapper.getWaitingList(2,"user22");
        waitingMapper.getWaitingList(2,"user23");
        waitingMapper.getWaitingList(2,"user24");
        waitingMapper.getWaitingList(2,"user25");
        waitingMapper.getWaitingList(2,"user26");
        waitingMapper.getWaitingList(2,"user27");
        waitingMapper.getWaitingList(2,"user28");
        waitingMapper.getWaitingList(3,"user01");
        waitingMapper.getWaitingList(3,"user02");
        waitingMapper.getWaitingList(3,"user03");
        waitingMapper.getWaitingList(3,"user04");
        waitingMapper.getWaitingList(3,"user05");
        waitingMapper.getWaitingList(3,"user06");
        waitingMapper.getWaitingList(3,"user07");
        waitingMapper.getWaitingList(3,"user08");
        waitingMapper.getWaitingList(3,"user09");
    }
    @Test
    void findByWaitNum() {
        waitingMapper.findOne(1,"user01");
        waitingMapper.findOne(1,"user02");
        waitingMapper.findOne(1,"user03");
        waitingMapper.findOne(1,"user04");
        waitingMapper.findOne(1,"user05");
        waitingMapper.findOne(1,"user06");
        waitingMapper.findOne(1,"user07");
        waitingMapper.findOne(1,"user08");
        waitingMapper.findOne(1,"user09");
        waitingMapper.findOne(1,"user10");
        waitingMapper.findOne(1,"user11");
        waitingMapper.findOne(1,"user12");
    }


    @Test
    void addWaiting() {
    }

    @Test
    void updateOne() {
    }

    @Test
    void deleteByWaitingNum() {
        waitingMapper.deleteByWaitingNum(1);
        waitingMapper.deleteByWaitingNum(2);
        waitingMapper.deleteByWaitingNum(3);
        waitingMapper.deleteByWaitingNum(4);
        waitingMapper.deleteByWaitingNum(5);
        waitingMapper.deleteByWaitingNum(6);
        waitingMapper.deleteByWaitingNum(7);
        waitingMapper.deleteByWaitingNum(8);
        waitingMapper.deleteByWaitingNum(9);
        waitingMapper.deleteByWaitingNum(10);
        waitingMapper.deleteByWaitingNum(11);
        waitingMapper.deleteByWaitingNum(12);
    }
}