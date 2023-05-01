package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.StoresDto;
import com.acorn.chapspring.service.MainService;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper //session Factory 에서 생성 및 관리
@Repository
public interface MainSearchMapper {
    //주소를 받아서 해당되는 가게들을 가져오기
    //리뷰 개수가 가장 많은 가게 하나 찾기
    StoresDto findByStoreReviewsOne (String siAdd, String guAdd);
    StoresDto findByCafeReviewsOne (String siAdd, String guAdd);
    StoresDto findByPubReviewsOne (String siAdd, String guAdd);

    List<StoresDto> findByStoreAddress (String address);
    List<StoresDto> findByStoreName (String storeName);
    List<StoresDto> findByStoreMenu (String storeMenu);
}
