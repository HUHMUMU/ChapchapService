package com.example.chapchapserviceproject.service;

import com.example.chapchapserviceproject.dto.UserDto;
import com.example.chapchapserviceproject.mapper.UserMapper;

public class UserServiceImp implements UserService{
    private UserMapper userMapper;
    private UserServiceImp(UserMapper userMapper) {this.userMapper=userMapper;}
    @Override
    public UserDto login(UserDto user) {
        return userMapper.findByStoreIdAndPw(user);
    }

    @Override
    public UserDto detail(String userId) {
        return userMapper.findByStoreId(userId);
    }

    @Override
    public int modify(UserDto user) {
        return userMapper.updateOne(user);
    }

    @Override
    public int signup(UserDto user) {
        return userMapper.insertOne(user);
    }

    @Override
    public int dropout(UserDto user) {
        return userMapper.deleteByStoreIdAndPw(user);
    }
}
