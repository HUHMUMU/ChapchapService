package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.JjimManageDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface JjimManageMapper {
    List<JjimManageDto> findAllJjimByUserId(String userId);

    int insertOneByUserId(JjimManageDto jjim);

    int deleteOneByUserIdAndStoreNum(JjimManageDto jjim);

    JjimManageDto findOneByUserIdAndStoreNum(@Param("userId") String userId, @Param("storeNum") int storeNum);
}
