package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapstorylikesDto;
import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.mapper.ChapstorylikeMapper;
import com.acorn.chapspring.mapper.UserMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class ChapstoryLikeServiceImp implements ChapstoryLikeService {
    private ChapstorylikeMapper chapstorylikeMapper;
    private UserMapper userMapper;


//    @Override
//    public ChapstorylikesDto read(int CNum) {
//        ChapstorylikesDto read = chapstorylikeMapper.countByCnum(CNum);
//        return read;
//    }
//
//    @Override
//    public ChapstorylikesDto read(int CNum, String loginUserId) {
//        userMapper.setLoginUserId(loginUserId);
//        ChapstorylikesDto read = chapstorylikeMapper.countByCnum(CNum);
//        userMapper.setLoginUserIdIsNull();
//        return read;
//    }

    @Override
    public ChapstorylikesDto detail(int CNum, String uId) {
        ChapstorylikesDto datail=chapstorylikeMapper.findByCNumAndUId(CNum,uId);
        return datail;
    }

    @Override
    public int register(ChapstorylikesDto like) {
        int register=chapstorylikeMapper.insertOne(like);
        return register;
    }


    @Override
    public int remove(ChapstorylikesDto like) {
        int remove=chapstorylikeMapper.deleteOne(like);
        return remove;
    }
}
