package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapstorylikesDto;
import com.acorn.chapspring.dto.ChapstorysDto;

public interface ChapstoryLikeService {
    // 해당 게시글의 좋아요 내역을 집계한 결과 조회
    // 좋아요를 등록, 수정, 삭제
    // 로그인한 유저가 좋아요를 했는지 확인

//    ChapstorylikesDto read(int CNum);
//    ChapstorylikesDto read(int CNum, String loginUserId);
    ChapstorylikesDto detail(int CNum, String uId);
    int register(ChapstorylikesDto like);
    int remove(ChapstorylikesDto like);

}
