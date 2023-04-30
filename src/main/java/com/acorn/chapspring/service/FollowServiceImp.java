package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.FollowDto;
import com.acorn.chapspring.mapper.FollowMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class FollowServiceImp implements FollowService{
    private FollowMapper followMapper;

    @Override
    public int register(FollowDto follow){
        int register=followMapper.insertOne(follow);
        return register;
    }
    @Override
    public int remove(FollowDto follow){
        int remove=followMapper.deleteByFromIdAndToId(follow);
        return remove;
    }

}
