package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.VisitedStoreDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface VisitedStoreMapper {
    List<VisitedStoreDto> findAllVisited(String userId);
}
