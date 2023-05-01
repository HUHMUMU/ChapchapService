package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapDealDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper //session Factory 에서 생성 및 관리
@Repository //spring Container 의 dao 의 의미
public interface ChapDealMapper {
    List<ChapDealDto> findAll(); //모든 챱딜 이벤트 가져오기

    List<ChapDealDto> findEventByStore(int storeNum); //가게별 이벤트 가져오기
}
