package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.*;
import com.acorn.chapspring.mapper.*;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImp implements UserService{
    private UserMapper userMapper;
    private ReviewMapper reviewMapper;
    private JjimManageMapper jjimManageMapper;

    public UserServiceImp(
            UserMapper userMapper,
            ReviewMapper reviewMapper,
            JjimManageMapper jjimManageMapper
    ){
        this.userMapper=userMapper;
        this.reviewMapper=reviewMapper;
        this.jjimManageMapper=jjimManageMapper;
    }
    //로그인,가입,탈퇴,수정 부분----------------------------------------------------------------
    @Override//로그인
    public UserDto login(UserDto user) {//로그인
        return userMapper.findByUserIdAndPw(user);
    }

    @Override//회원가입
    public int signup(UserDto user) {
        return userMapper.insertOne(user);
    }

    @Override//회원탈퇴
    public int dropout(UserDto user) {
        return userMapper.deleteByUserIdAndPw(user);
    }

    @Override//정보 수정
    public int modify(UserDto user){
        return userMapper.updateOne(user);
    }
    //---------------------------------------------------------------------------------
    @Override
    public int nickName_Check(String nickname) throws Exception {
        return userMapper.nickName_Check(nickname);
    }

    @Override
    public int email_Check(String email) throws Exception {
        return userMapper.email_Check(email);
    }

    @Override
    public int modifyEmailCheck(UserDto user) {
        int modifyEmailCheck=userMapper.updateStatusByUidAndEmailCheckCode(user);
        return modifyEmailCheck;
    }
    @Override
    public int idCheck(String userId) throws Exception {
        return userMapper.idCheck(userId);
    }

    @Override//유저 정보
    public UserDto detail(String userId) {
        return userMapper.findByUserId(userId);
    }


    @Override//유저 상세페이지 링크 임시 구현 부분
    public List<UserDto> userList(){
        List<UserDto> list=userMapper.findAllUsers();
        return list;
    }

    //아이디 찾기
    @Override
    public UserDto findByNameByEmail(UserDto user) {
        return userMapper.findByNameByEmail(user);
    }

    //비밀번호 찾기
    @Override
    public UserDto findByUserIdAndEmail(UserDto user) {
        return userMapper.findByUserIdAndEmail(user);
    }
}
