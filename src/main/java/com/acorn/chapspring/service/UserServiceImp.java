package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.*;
import com.acorn.chapspring.mapper.UserMapper;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class UserServiceImp implements UserService{
    private UserMapper userMapper;

    public UserServiceImp(UserMapper userMapper){this.userMapper=userMapper;}
    @Override
    public UserDto login(UserDto user) {//로그인
        return userMapper.findByUserIdAndPw(user);
    }

    @Override
    public UserDto detail(String userId) {
        return userMapper.findByUserId(userId);
    }

    @Override
    public int signup(UserDto user) {
        return userMapper.insertOne(user);
    }

    @Override
    public int dropout(UserDto user) {
        return userMapper.deleteByUserIdAndPw(user);
    }


    @Override
    public int nickName_Check(String nickname) throws Exception {
        return userMapper.nickName_Check(nickname);
    }



    @Override
    public List<VisitedStoreDto> visited(String loginUserId) {
        userMapper.setLoginUserId(loginUserId);
        List<VisitedStoreDto> list=userMapper.findAllVisited(loginUserId);
        return list;
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
    public int modify(UserDto user){
        return userMapper.updateOne(user);
    }
    @Override
    public List<ReviewDto> reviewed(String loginUserId){
        userMapper.setLoginUserId(loginUserId);
        List<ReviewDto> list=userMapper.findAllReviewed(loginUserId);
        return list;
    }
    @Override
    public List<UserDto> userList(){
        List<UserDto> list=userMapper.findAllUsers();
        return list;
    }
    @Override
    public List<RecommendStoreDto> recommendList(String userId){
        List<RecommendStoreDto> list=userMapper.findAllRecommend(userId);
        return list;
    }
    @Override
    public  List<JjimManageDto> jjimList(String userId){
        List<JjimManageDto> list=userMapper.findAllJjim(userId);
        return list;
    }

    @Override
    public int idCheck(String userId) throws Exception {
        return userMapper.idCheck(userId);
    }

}
