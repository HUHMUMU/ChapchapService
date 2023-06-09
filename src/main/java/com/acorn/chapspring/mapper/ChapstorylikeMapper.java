package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapstorylikesDto;
import com.acorn.chapspring.dto.ChapstorysDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ChapstorylikeMapper {
    // 게시글에 좋아요 수 반환
    // 게시글에서

    ChapstorylikesDto findByCNumAndUId(@Param("cNum")int CNum, @Param("uId")String UId);
    ChapstorylikesDto findByCNumAndUIdIsLoginUserId(@Param("CNum")int CNum);
    int countByCnum(int Cnum); // 조
    int insertOne(ChapstorylikesDto chapLike);
    int deleteByLikeno(int likeno);
    int deleteOne(ChapstorylikesDto chapLike);
}
