package com.example.chapchapserviceproject.mapper;

import com.example.chapchapserviceproject.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    //유저 상세 정보
    UserDto findByStoreId(String userId);

    //로그인
    UserDto findByStoreIdAndPw(UserDto user);

    //아이디 찾기
    String findStoreIdByEmailAndPhoneAndName(UserDto user);

    //유저정보수정
    int updateOne(UserDto user);

    //비밀번호 찾기
    int updatePwByStoreId(UserDto user);

    //회원가입
    int insertOne(UserDto user);

    //회원정보 삭제
    int deleteByStoreIdAndPw(UserDto user);

}
