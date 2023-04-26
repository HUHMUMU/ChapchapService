package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.MenuManagesDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MenuManageMapper {

    List<MenuManagesDto> findMenuByStore(int storeNum); //가게별 메뉴 정보
    MenuManagesDto findMenuNameByNum(int menuNum); //메뉴번호별 메뉴 정보
}
