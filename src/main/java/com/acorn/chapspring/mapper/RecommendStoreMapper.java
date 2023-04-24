package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.RecommendStoreDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface RecommendStoreMapper {
    List<RecommendStoreDto> findAllRecommend(String userId);

    int insertOneByUserId(RecommendStoreDto recommendStore);
    int deleteOneByUserIdAndStoreNum(RecommendStoreDto recommendStore);
}
