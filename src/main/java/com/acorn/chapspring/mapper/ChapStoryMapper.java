package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapstorylikesDto;
import com.acorn.chapspring.dto.ChapstorysDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ChapStoryMapper {
    // 리스트, 상세, 등록, 수정, 삭제, 신고
    // 상세보기시 조회수 올리기
    List<ChapstorysDto> findAll();
    ChapstorysDto findByChapNum(int chapNum);
    List<ChapstorysDto> findByUserId(String userId);
    int insertOne(ChapstorysDto chaps);
    int updateOne(ChapstorysDto chpas);
    int deleteByChapsNum(int chapNum);

    int updateIncrementViewCountChapNum(int ChapNum);
//    int updateIncrementLikeChapNum(int ChapNum);
}
