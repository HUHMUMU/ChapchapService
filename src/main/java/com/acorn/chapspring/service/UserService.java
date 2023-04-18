package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ReviewDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.dto.VisitedStoreDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserService {
    UserDto login(UserDto user);//로그인
    UserDto detail(String userId);//상세정보
    int modify(UserDto user);//수정
    int signup(UserDto user);//회원가입
    int dropout(UserDto user);//회원탈퇴
    List<VisitedStoreDto> visited(String userId);//유저 방문조회
    List<ReviewDto> reviewed(String userId);//유저 리뷰조회
}

