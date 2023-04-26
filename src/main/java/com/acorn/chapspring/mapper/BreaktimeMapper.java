package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.BreaktimesDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface BreaktimeMapper {
    List<BreaktimesDto> findByStore(int storeNum);
}
