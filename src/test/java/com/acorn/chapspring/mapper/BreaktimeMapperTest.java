package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.BreaktimesDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class BreaktimeMapperTest {
    @Autowired
    private BreaktimeMapper breaktimeMapper;

    @Test
    void findByStore() {
        List<BreaktimesDto> breaktime=breaktimeMapper.findByStore(1);
        System.out.println("breaktime = " + breaktime);
    }
}