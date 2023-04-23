package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface StoreMapper {
    // 모든 가게 리스트 가져오기
    List<StoresDto> findAllStores();

    // 필터와 정렬 조건에 맞는 가게 리스트 가져오기
    List<StoresDto> findStoresByFilterAndSort(@Param("filter") StoreFilterDto filter, @Param("sort") String sort);

    // 주어진 식당 번호에 해당하는 가게 정보 가져오기
    StoresDto findStoreByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 브레이크 타임 가져오기
    List<BreaktimesDto> findBreaktimesByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 메뉴 가져오기
    List<MenuManagesDto> findMenusByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 리뷰 가져오기
    List<ReviewDto> findReviewsByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 찜 가져오기
    List<JjimManageDto> findJjimByStoreNum(int storeNum);

    // 주어진 식당의 정보들
    StoresDto findByStoreNum(int storeNum);
}
