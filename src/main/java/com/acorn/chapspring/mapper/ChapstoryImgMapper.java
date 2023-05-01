package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapstoryimgsDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper

public interface ChapstoryImgMapper {
    //게시글에서 조회되는 이미지 리스트
    //게시글에 이미지 등록
    //게시글의 이미지 삭제 (수정 x)
    List<ChapstoryimgsDto> findByChapNum(int ChapNum); // 게시글 넘버를 기준으로 조회
    ChapstoryimgsDto findByChsNum(int ChsNum);
    List<ChapstoryimgsDto> findByChsNumIn(List<Integer> ChsNums);
    int insertOne(ChapstoryimgsDto chapsImg);
    int deleteOne(int chsNum);
}
