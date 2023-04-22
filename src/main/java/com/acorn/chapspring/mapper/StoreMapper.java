package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public class StoreMapper {
    // 모든 가게 리스트 가져오기
    List<StoresDto> findAllStores() {
        return null;
    }

    // 필터와 정렬 조건에 맞는 가게 리스트 가져오기
    List<StoresDto> findStoresByFilterAndSort(@Param("filter") StoreFilterDto filter, @Param("sort") String sort) {
        return null;
    }

    // 주어진 식당 번호에 해당하는 가게 정보 가져오기
    StoresDto findStoreByStoreNum(int storeNum) {
        return null;
    }

    // 주어진 식당 번호에 해당하는 가게의 브레이크 타임 가져오기
    List<BreaktimesDto> findBreaktimesByStoreNum(int storeNum) {
        return null;
    }

    // 주어진 식당 번호에 해당하는 가게의 메뉴 가져오기
    List<MenuManagesDto> findMenusByStoreNum(int storeNum) {
        return null;
    }

    // 주어진 식당 번호에 해당하는 가게의 리뷰 가져오기
    List<ReviewDto> findReviewsByStoreNum(int storeNum) {
        return null;
    }

    // 주어진 식당 번호에 해당하는 가게의 찜 가져오기
    List<JjimManageDto> findJjimByStoreNum(int storeNum) {
        return null;
    }

    // 주어진 식당 번호에 해당하는 가게의 좋아요 수 가져오기
    int findLikesCountByStoreNum(int storeNum) {
        return 0;
    }
}
