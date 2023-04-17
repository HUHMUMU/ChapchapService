package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.UserDto;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    UserDto login(UserDto user);//로그인
    UserDto detail(String userId);//상세정보
    int modify(UserDto user);//수정
    int signup(UserDto user);//회원가입
    int dropout(UserDto user);//회원탈퇴
}

