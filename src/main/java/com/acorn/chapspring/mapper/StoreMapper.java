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

    // 필터링된 결과를 반환하는 메소드 추가
    List<StoresDto> findStoresByFilter(StoreFilterDto filter);

    // 주어진 식당 번호에 해당하는 가게 정보 가져오기
    StoresDto findStoreByStoreNum(int storeNum);

    // 전체 가게 업종 가져오기
    List<TypeClassesDto> findAllType();

    // 주어진 식당 번호에 해당하는 가게의 브레이크 타임 가져오기
    List<BreaktimesDto> findBreaktimesByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 메뉴 가져오기
    List<MenuManagesDto> findMenusByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 리뷰 가져오기
    List<ReviewsDto> findReviewsByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 리뷰 갯수 새기
    int countReviewsByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 찜 갯수 새기
    int countJjimByStoreNum(int storeNum);
    List<ReviewsCountDto> findReviewsCountByStoreNum(int storeNum);

    // 주어진 식당 번호에 해당하는 가게의 찜 가져오기
    List<JjimManageDto> findJjimByStoreNum(int storeNum);

    StoresDto findByStoreNum(int storeNum);
    StoresDto findStoreName(int storeNum);
}
