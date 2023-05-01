package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.ChapstoryPageDto;
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
    List<ChapstorysDto> findAll(ChapstoryPageDto pageDto); //모든 게시글 조회
    List<ChapstorysDto> bestList(); // 조회수를 기준으로 리스트페이지 인기글 정렬
    ChapstorysDto findByChapNum(int chapNum); // 게시글 넘버를 기준으로 게시글 조회
    List<ChapstorysDto> findByUserId(String userId); // 유저 게시글 조회
    List<ChapstorysDto> bestListFindByUserId(String userId); // 조회수를 기준으로 유저 블로그 메인페이지 인기글 정렬
    int insertOne(ChapstorysDto chaps); // 등록
    int updateOne(ChapstorysDto chpas); // 수정
    int deleteByChapsNum(int chapNum); // 삭제

    int updateIncrementViewCountChapNum(int ChapNum); // 조회수 올리기
}
