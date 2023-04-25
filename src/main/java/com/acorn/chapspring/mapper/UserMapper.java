package com.acorn.chapspring.mapper;

import com.acorn.chapspring.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    int updateStatusByUidAndEmailCheckCode(UserDto user); //이메일 인증 코드
    UserDto findByUserId(String userId);//유저 정보
    UserDto findByUserIdAndPw(UserDto user);//로그인 정보 비교

    //아이디 찾기
    UserDto findByNameByEmail(UserDto user);
    //비밀번호 찾기
    UserDto findByUserIdAndEmail(UserDto user);

    int updateOne(UserDto user);//유저정보 수정
    int insertOne(UserDto user);//유저 등록
    int deleteByUserIdAndPw(UserDto user);//유저 삭제
    int setLoginUserId(String userId);
    int setLoginUserIdIsNull();

    List<UserDto> findAllUsers();
    //아이디 중복 검사
    int idCheck(String userId);
    //닉네임 중복 검사
    int nickName_Check(String nickname);
    //이메일 중복 검사
    int email_Check(String email);

}
