package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.UsersWaitingDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface UsersWaitingMapper {
    UsersWaitingDto findWaitingNum(int storeNum); //가게별 웨이팅 수
}
