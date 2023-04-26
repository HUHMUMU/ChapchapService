package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.HolidaysDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class HolidayMapperTest {
    @Autowired
    HolidayMapper holidayMapper;

    @Test
    void findHoliByStore() {
        List<HolidaysDto> holidays=holidayMapper.findHoliByStore(1);
        System.out.println("holidays = " + holidays);
    }
}