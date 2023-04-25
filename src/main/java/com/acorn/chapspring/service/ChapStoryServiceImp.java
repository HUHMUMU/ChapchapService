package com.acorn.chapspring.service;

import com.acorn.chapspring.dto.ChapstorysDto;
import com.acorn.chapspring.dto.UserDto;
import com.acorn.chapspring.mapper.ChapStoryMapper;
import com.acorn.chapspring.mapper.UserMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class ChapStoryServiceImp implements ChapStoryService{
    private ChapStoryMapper chapStoryMapper;
    private UserMapper userMapper;
//    public ChapStoryServiceImp(ChapStoryMapper chapStoryMapper){this.chapStoryMapper=chapStoryMapper;}

    @Override
    public List<ChapstorysDto> list() {
        List<ChapstorysDto> list=chapStoryMapper.findAll();
        return list;
    }

    @Override
    @Transactional
    public ChapstorysDto detail(int chapNum) {
        ChapstorysDto detail = chapStoryMapper.findByChapNum(chapNum);
        return detail;
    }

    @Override
    public List<ChapstorysDto> blogMain(String userId) {
        List<ChapstorysDto> blogmain = chapStoryMapper.findByUserId(userId);
        return blogmain;
    }

    @Override
    @Transactional
    public int register(ChapstorysDto chaps) {
        int register = chapStoryMapper.insertOne(chaps);
        return register;
    }

    @Override
    @Transactional
    public int modify(ChapstorysDto chaps) {
        int modify=chapStoryMapper.updateOne(chaps);
        return modify;
    }

    @Override
    public int remove() {
        return 0;
    }

}
