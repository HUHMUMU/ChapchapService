package com.example.chapchapserviceproject.service;

import com.example.chapchapserviceproject.dto.UserDto;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    //로그인
    UserDto login(UserDto user);
    //유저상세
    UserDto detail(String userId);
    //수정
    int modify(UserDto user);
    //회원가입
    int signup(UserDto user);
    //삭제
    int dropout(UserDto user);
}
