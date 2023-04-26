package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapstorylikesDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface chapstorylikeMapper {
    // 게시글에 좋아요 수 반환
    // 게시글에서

    ChapstorylikesDto findByCNumAndUId(@Param("CNum")int CNum, @Param("UId")String UId);
    ChapstorylikesDto findByCNumAndUIdIsLoginUserId(@Param("CNum")int CNum);
    int insertOne(ChapstorylikesDto chapLike);
    int deleteOne(ChapstorylikesDto chapLike);
    int likeCheck (ChapstorylikesDto chapLike);
    int likeCheckCancel (ChapstorylikesDto chapLike);
}
