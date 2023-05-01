package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.RecommendStoreDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface RecommendStoreMapper {
    List<RecommendStoreDto> findAllRecommendstoreByUserId(String userId);

    int insertOneByUserId(RecommendStoreDto recommendstore);
    int deleteOneByUserIdAndStoreNum(RecommendStoreDto recommendstore);
    int updateOne(RecommendStoreDto recommendstore);

    RecommendStoreDto findOneByUserIdAndStoreNum(String userId,int storeNum);
}
