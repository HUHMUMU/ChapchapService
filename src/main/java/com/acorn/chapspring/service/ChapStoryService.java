package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapstoryPageDto;
import com.acorn.chapspring.dto.ChapstoryimgsDto;
import com.acorn.chapspring.dto.ChapstorysDto;

import java.util.List;

public interface ChapStoryService {
    List<ChapstorysDto> list(ChapstoryPageDto pageDto); //챱스토리 게시글 조회
    List<ChapstorysDto> bestList(); // 인기글 조회
    List<ChapstorysDto> bestListFindByUserId(String userId); //블로그 인기글 조회
    ChapstorysDto detail(int chapNum); //챱스토리 게시글 상세 조회
    List<ChapstorysDto> blogMain(String userId); //챱스토리 블로그메인 게시글 조회
    int register(ChapstorysDto chaps); //챱스토리 작성
    int modify(ChapstorysDto chaps, int[] delImgChsNums); //챱스토리 수정
    int remove(int chapNum); //챱스토리 삭제
    List<ChapstoryimgsDto> imgList(int[]chsNum);


}
