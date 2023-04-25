package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.dto.UserDto;
import org.springframework.stereotype.Component;

import java.util.List;
@Component

public interface ChapStoryService {
    List<ChapstorysDto> list(); //챱스토리 게시글 조회
    ChapstorysDto detail(int chapNum); //챱스토리 게시글 상세 조회
    List<ChapstorysDto> blogMain(String userId); //챱스토리 블로그메인 게시글 조회
    int register(ChapstorysDto chaps); //챱스토리 작성
    int modify(ChapstorysDto chaps); //챱스토리 수정
    int remove(); //챱스토리 삭제


}
