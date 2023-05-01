package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.HolidaysDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface HolidayMapper {
    List<HolidaysDto> findHoliByStore(int storeNum); //가게별 휴일
}
